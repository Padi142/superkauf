import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.loading() = Loading;

  const factory LoginState.error(String message) = Error;

  const factory LoginState.loginInProgress() = LoginInProgress;

  const factory LoginState.confirmEmail() = ConfirmEmail;

  const factory LoginState.loggedIn(String username) = LoggedIn;
}
