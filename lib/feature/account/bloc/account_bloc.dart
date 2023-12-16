import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/feature/account/bloc/account_state.dart';
import 'package:superkauf/feature/account/use_case/account_navigation.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

part 'account_event.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountNavigation accountNavigation;

  AccountBloc({
    required this.accountNavigation,
  }) : super(const AccountState.loading()) {
    on<GetUser>(_onGetUser);
  }

  Future<void> _onGetUser(
    GetUser event,
    Emitter<AccountState> emit,
  ) async {
    final supabase = Supabase.instance.client;

    final session = supabase.auth.currentSession;
    if (session == null) {
      emit(const AccountState.error("No session found"));
      accountNavigation.goToLogin();
      return;
    }

    final supabaseUser = session.user;
    final user = UserModel(
      id: 0,
      name: supabaseUser.email!,
      createdAt: DateTime.now(),
      isAdmin: false,
      lastLoggedIn: DateTime.now(),
      profilePicture: 'https://wwrhodyufftnwdbafguo.supabase.co/storage/v1/object/public/profile_pics/klidecek.png',
    );

    emit(AccountState.loaded(user));
  }
}
