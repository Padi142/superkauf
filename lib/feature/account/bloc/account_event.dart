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
  final UserModel user;

  const ChangeUsername({required this.username, required this.user});
}

class ChangeInstagram extends AccountEvent {
  final String instagram;
  final UserModel user;

  const ChangeInstagram({required this.instagram, required this.user});
}

class ChangeProfilePic extends AccountEvent {
  final UserModel? user;

  const ChangeProfilePic({required this.user});
}

class UpdateCountry extends AccountEvent {
  final CountryModel country;

  const UpdateCountry({required this.country});
}

class LogOut extends AccountEvent {
  const LogOut();
}
