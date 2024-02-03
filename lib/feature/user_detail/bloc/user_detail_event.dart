part of 'user_detail_bloc.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

class InitialUserEvent extends UserDetailEvent {
  final UserModel user;

  const InitialUserEvent({required this.user});
}

class GetUser extends UserDetailEvent {
  final int userID;

  const GetUser({required this.userID});
}

class LoadMore extends UserDetailEvent {
  const LoadMore();
}

class ReloadUser extends UserDetailEvent {
  const ReloadUser();
}
