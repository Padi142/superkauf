import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/feature/account/bloc/account_state.dart';
import 'package:superkauf/feature/account/use_case/account_navigation.dart';
import 'package:superkauf/generic/user/model/update_user_body.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_uid_use_case.dart';
import 'package:superkauf/generic/user/use_case/updat_user_use_case.dart';

part 'account_event.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountNavigation accountNavigation;
  final GetUserByUidUseCase getUserByUidUseCase;
  final UpdateUserUseCase updateUserUseCase;

  AccountBloc({
    required this.accountNavigation,
    required this.getUserByUidUseCase,
    required this.updateUserUseCase,
  }) : super(const AccountState.loading()) {
    on<GetUser>(_onGetUser);
    on<LogOut>(_onLogOut);
    on<ChangeUsername>(_onChangeUsername);
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

    supabase.auth.signOut();
    add(const GetUser());
  }

  Future<void> _onChangeUsername(
    ChangeUsername event,
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountState.loading());

    final params = UpdateUserBody(username: event.username, id: event.id, profilePicture: null);
    final result = await updateUserUseCase.call(params);
    add(const GetUser());
  }
}
