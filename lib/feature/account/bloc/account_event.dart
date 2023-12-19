part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetUser extends AccountEvent {
  const GetUser();
}

class ChangeUsername extends AccountEvent {
  final String username;
  final int id;

  const ChangeUsername({required this.username, required this.id});
}

class LogOut extends AccountEvent {
  const LogOut();
}
