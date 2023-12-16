import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/feature/account/use_case/account_navigation.dart';
import 'package:superkauf/feature/login/model/login_params.dart';
import 'package:superkauf/feature/login/use_case/email_login_use_case.dart';

import '../use_case/apple_login.dart';
import '../use_case/discord_login.dart';
import '../use_case/google_login.dart';
import '../use_case/spotify_login.dart';
import 'login_state.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DiscordLoginUseCase discordLoginUseCase;
  final AppleLoginUseCase appleLoginUseCase;
  final GoogleLoginUseCase googleLoginUseCase;
  final SpotifyLoginUseCase spotifyLoginUseCase;
  final EmailLoginUseCase emailLoginUseCase;
  final AccountNavigation loginNavigation;

  LoginBloc({
    required this.discordLoginUseCase,
    required this.appleLoginUseCase,
    required this.googleLoginUseCase,
    required this.spotifyLoginUseCase,
    required this.emailLoginUseCase,
    required this.loginNavigation,
  }) : super(const LoginState.loading()) {
    on<DiscordLogin>(_onDiscordLogin);
    on<EmailLogin>(_onEmailLogin);
    on<GoogleLogin>(_onGoogleLogin);
    on<AppleLogin>(_onAppleLogin);
    on<SpotifyEvent>(_onSpotifyEvent);
  }

  Future<void> _onEmailLogin(
    EmailLogin event,
    Emitter<LoginState> emit,
  ) async {
    final params = LoginParams(email: event.email, password: event.password);
    final response = await emailLoginUseCase.call(params);
    if (response == null || response.session == null) {
      loginNavigation.goToLogin();
      return;
    }
    loginNavigation.goToAccount();
  }

  Future<void> _onDiscordLogin(
    DiscordLogin event,
    Emitter<LoginState> emit,
  ) async {
    await discordLoginUseCase.call();
  }

  Future<void> _onGoogleLogin(
    GoogleLogin event,
    Emitter<LoginState> emit,
  ) async {
    await googleLoginUseCase.call();
  }

  Future<void> _onAppleLogin(
    AppleLogin event,
    Emitter<LoginState> emit,
  ) async {
    await appleLoginUseCase.call();
  }

  Future<void> _onSpotifyEvent(
    SpotifyEvent event,
    Emitter<LoginState> emit,
  ) async {
    await spotifyLoginUseCase.call();
  }
}
