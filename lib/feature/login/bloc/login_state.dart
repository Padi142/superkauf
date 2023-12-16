import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.loading() = Loading;
  const factory LoginState.error() = Error;
  const factory LoginState.loggedIn(String username) = LoggedIn;
}
