import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/feature/account/bloc/account_state.dart';
import 'package:superkauf/feature/account/use_case/account_navigation.dart';
import 'package:superkauf/feature/create_post/use_case/pick_image_use_case.dart';
import 'package:superkauf/generic/post/model/upload_post_image_params.dart';
import 'package:superkauf/generic/user/model/update_user_body.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_uid_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_username_use_case.dart';
import 'package:superkauf/generic/user/use_case/updat_user_use_case.dart';
import 'package:superkauf/generic/user/use_case/upload_user_image_use_case.dart';

part 'account_event.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountNavigation accountNavigation;
  final GetUserByUidUseCase getUserByUidUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final GetUserByUsernameUseCase getUserByUsernameUseCase;
  final PickImageUseCase pickImageUseCase;
  final UploadUserImageUseCase uploadUserImageUseCase;

  AccountBloc({
    required this.accountNavigation,
    required this.getUserByUidUseCase,
    required this.updateUserUseCase,
    required this.getUserByUsernameUseCase,
    required this.pickImageUseCase,
    required this.uploadUserImageUseCase,
  }) : super(const AccountState.loading()) {
    on<GetUser>(_onGetUser);
    on<LogOut>(_onLogOut);
    on<ChangeUsername>(_onChangeUsername);
    on<ChangeProfilePic>(_onChangeProfilePic);
  }

  Future<void> _onGetUser(
    GetUser event,
    Emitter<AccountState> emit,
  ) async {
    final supabase = Supabase.instance.client;

    final session = supabase.auth.currentSession;
    if (session == null) {
      emit(const AccountState.error("You are not logged in"));
      accountNavigation.goToLogin();
      return;
    }

    final supabaseUser = session.user;
    final result = await getUserByUidUseCase.call(supabaseUser.id);

    result.map(success: (success) {
      Posthog().identify(userId: session.user.id.toString(), properties: {
        "supabase_uid": session.user.id,
        "username": success.user.username,
      });
      emit(AccountState.loaded(success.user));
    }, failure: (failure) {
      print(failure);
      emit(const AccountState.error("You probably dont exist :/// "));
    });
  }

  Future<void> _onLogOut(
    LogOut event,
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountState.loading());

    final supabase = Supabase.instance.client;

    await supabase.auth.signOut();

    final box = await Hive.openBox('user');
    await box.clear();

    Posthog().reset();

    OneSignal.logout();

    add(const GetUser());
  }

  Future<void> _onChangeUsername(
    ChangeUsername event,
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountState.loading());

    var shouldReturn = false;

    final userResult = await getUserByUsernameUseCase.call(event.username.toLowerCase());

    userResult.map(
        success: (success) {
          emit(const AccountState.error("Username already taken"));

          shouldReturn = true;
          add(const GetUser());
        },
        failure: (failure) {});

    if (shouldReturn) {
      return;
    }

    final params = UpdateUserBody(
      username: event.username,
      id: event.user.id,
      profilePicture: event.user.profilePicture,
    );
    final result = await updateUserUseCase.call(params);

    add(const GetUser());
  }

  Future<void> _onChangeProfilePic(
    ChangeProfilePic event,
    Emitter<AccountState> emit,
  ) async {
    final supabase = Supabase.instance.client;
    emit(const AccountState.loading());

    final image = await pickImageUseCase.call();
    if (image == null) {
      add(const GetUser());
      return;
    }

    final path = '${event.user.id}/${event.user.username}';
    final params = UploadImageParams(path: path, file: image);

    final result = await uploadUserImageUseCase.call(params);

    result.map(
        success: (success) {},
        failure: (failure) {
          emit(const AccountState.error("Something went wrong"));
          return;
        });

    final imageLink = supabase.storage.from('profile_pics').getPublicUrl(path);

    final updateParams = UpdateUserBody(
      id: event.user.id,
      profilePicture: imageLink,
      username: event.user.username,
    );

    final updateResult = await updateUserUseCase.call(updateParams);

    updateResult.map(
        success: (success) {},
        failure: (failure) {
          emit(const AccountState.error("Something went wrong"));
          return;
        });

    add(const GetUser());
  }
}
