import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/feature/account/bloc/account_state.dart';
import 'package:superkauf/feature/account/use_case/account_navigation.dart';
import 'package:superkauf/feature/create_post/use_case/pick_image_use_case.dart';
import 'package:superkauf/generic/post/model/get_posts_body.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/generic/post/model/pagination_model.dart';
import 'package:superkauf/generic/post/model/upload_post_image_params.dart';
import 'package:superkauf/generic/post/model/upload_post_image_result.dart';
import 'package:superkauf/generic/post/use_case/get_posts_by_user.dart';
import 'package:superkauf/generic/settings/use_case/get_settings_use_case.dart';
import 'package:superkauf/generic/user/model/update_user_body.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_username_use_case.dart';
import 'package:superkauf/generic/user/use_case/updat_user_use_case.dart';
import 'package:superkauf/generic/user/use_case/upload_user_image_use_case.dart';

part 'account_event.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountNavigation accountNavigation;
  final GetCurrentUserUseCase getCurrentUSeUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final GetUserByUsernameUseCase getUserByUsernameUseCase;
  final PickImageUseCase pickImageUseCase;
  final UploadUserImageUseCase uploadUserImageUseCase;
  final GetPostsByUserUseCase getPostsByUserUseCase;
  final GetSettingsUseCase getSettingsUseCase;
  final UploadUserS3ImageUseCase uploadUserS3ImageUseCase;

  AccountBloc({
    required this.accountNavigation,
    required this.getCurrentUSeUseCase,
    required this.updateUserUseCase,
    required this.getUserByUsernameUseCase,
    required this.pickImageUseCase,
    required this.uploadUserImageUseCase,
    required this.getPostsByUserUseCase,
    required this.getSettingsUseCase,
    required this.uploadUserS3ImageUseCase,
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
    final box = await Hive.openBox('user');
    box.clear();
    final user = await getCurrentUSeUseCase.call();

    if (user == null) {
      emit(const AccountState.error('You are not logged in'));
      accountNavigation.goToLogin();
      return;
    }

    final settings = await getSettingsUseCase.call();

    Posthog().identify(userId: user.id.toString(), userProperties: {
      "supabase_uid": user.id,
      "username": user.username,
    });

    final params = GetPersonalFeedParams(
      body: GetPostsBody(
        country: settings.country,
        pagination: const GetPostsPaginationModel(
          perPage: 999,
          offset: 0,
        ),
      ),
      userId: user.id,
    );

    final postsResult = await getPostsByUserUseCase.call(params);

    postsResult.map(success: (success) {
      emit(AccountState.loaded(user, success.response.posts));
    }, failure: (failure) {
      emit(AccountState.loaded(user, []));
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

    Posthog().capture(
      eventName: 'change_user_name',
      properties: {
        'user_id': event.user.id,
        'name': event.username,
      },
    );

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

    Posthog().identify(userId: params.id.toString(), userProperties: {
      "username": params.username!,
    });

    await Future.delayed(const Duration(milliseconds: 600));

    add(const GetUser());
  }

  Future<void> _onChangeProfilePic(
    ChangeProfilePic event,
    Emitter<AccountState> emit,
  ) async {
    final supabase = Supabase.instance.client;
    emit(const AccountState.loading());

    Posthog().capture(
      eventName: 'change_profile_pic',
      properties: {
        'user_id': event.user.id,
      },
    );

    final image = await pickImageUseCase.call();
    if (image == null) {
      add(const GetUser());
      return;
    }

    final path = '${event.user.id}/${event.user.username}';
    final params = UploadImageParams(path: path, file: image);

    late UploadImageResult result;
    await Posthog().reloadFeatureFlags();
    final isEnabled = await Posthog().isFeatureEnabled('use-supabase-storage');
    if (isEnabled) {
      result = await uploadUserImageUseCase.call(params);
    } else {
      result = await uploadUserS3ImageUseCase.call(params);
    }

    String imageLink = '';
    result.map(success: (success) {
      imageLink = success.path;
    }, failure: (failure) {
      emit(const AccountState.error("Something went wrong"));
      return;
    });

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

    await Future.delayed(const Duration(milliseconds: 600));

    add(const GetUser());
  }
}
