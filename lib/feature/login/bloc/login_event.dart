part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class CallbackEvent extends LoginEvent {
  const CallbackEvent();
}

class EmailLoginEvent extends LoginEvent {
  final String email;
  final String password;

  const EmailLoginEvent({required this.email, required this.password});
}

class EmailRegisterEvent extends LoginEvent {
  final String email;
  final String password;

  const EmailRegisterEvent({required this.email, required this.password});
}

class DiscordLogin extends LoginEvent {
  const DiscordLogin();
}

class GoogleLogin extends LoginEvent {
  const GoogleLogin();
}

class AppleLogin extends LoginEvent {
  const AppleLogin();
}

class SpotifyEvent extends LoginEvent {
  const SpotifyEvent();
}

class CreateUserProfile extends LoginEvent {
  final String? returnPath;

  const CreateUserProfile({this.returnPath});

  @override
  List<Object?> get props => [returnPath];
}

class GoBack extends LoginEvent {
  final String path;

  const GoBack({
    required this.path,
  });
}
