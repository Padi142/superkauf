import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/feature/account/use_case/account_navigation.dart';
import 'package:superkauf/feature/login/model/login_params.dart';
import 'package:superkauf/feature/login/use_case/email_login_use_case.dart';
import 'package:superkauf/feature/login/use_case/email_register_use_case.dart';
import 'package:superkauf/feature/login/use_case/login_navigation.dart';
import 'package:superkauf/generic/user/model/create_user_body.dart';
import 'package:superkauf/generic/user/use_case/create_user_use_case.dart';

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
  final AccountNavigation accountNavigation;
  final CreateUserUseCase createUserUseCase;
  final LoginNavigation loginNavigation;
  final EmailRegisterUseCase emailRegisterUseCase;

  LoginBloc({
    required this.discordLoginUseCase,
    required this.appleLoginUseCase,
    required this.googleLoginUseCase,
    required this.spotifyLoginUseCase,
    required this.emailLoginUseCase,
    required this.loginNavigation,
    required this.createUserUseCase,
    required this.accountNavigation,
    required this.emailRegisterUseCase,
  }) : super(const LoginState.loading()) {
    on<DiscordLogin>(_onDiscordLogin);
    on<EmailLoginEvent>(_onEmailLoginEvent);
    on<EmailRegisterEvent>(_onEmailRegisterEvent);
    on<GoogleLogin>(_onGoogleLogin);
    on<AppleLogin>(_onAppleLogin);
    on<SpotifyEvent>(_onSpotifyEvent);
    on<CreateUserProfile>(_onCreateUserProfile);
    on<GoBack>(_onGoBack);
  }

  Future<void> _onEmailLoginEvent(
    EmailLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginState.loginInProgress());

    final params = LoginParams(email: event.email, password: event.password);
    final response = await emailLoginUseCase.call(params);
    if (response == null || response.session == null) {
      emit(const LoginState.error('There was an error logging in. Please try again.'));
      emit(const LoginState.loading());
      return;
    }

    Posthog().capture(eventName: 'user_logged_in', properties: {
      'login_type': 'email',
    });

    accountNavigation.goToAccount();
  }

  Future<void> _onEmailRegisterEvent(
    EmailRegisterEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginState.loginInProgress());

    final params = LoginParams(email: event.email, password: event.password);
    final response = await emailRegisterUseCase.call(params);
    if (response == null) {
      emit(const LoginState.error('There was an error registering you. Please try again.'));
      emit(const LoginState.loading());
      return;
    }

    Posthog().capture(eventName: 'user_registered', properties: {
      'login_type': 'email',
    });

    emit(const LoginState.confirmEmail());
  }

  Future<void> _onDiscordLogin(
    DiscordLogin event,
    Emitter<LoginState> emit,
  ) async {
    await discordLoginUseCase.call();

    Posthog().capture(eventName: 'user_logged_in', properties: {
      'login_type': 'discord',
    });
  }

  Future<void> _onGoogleLogin(
    GoogleLogin event,
    Emitter<LoginState> emit,
  ) async {
    try {
      await googleLoginUseCase.call();
    } catch (e) {
      print(e);
      emit(const LoginState.error('There was an error logging you in with google. Please try another provider.'));
    }

    Posthog().capture(eventName: 'user_logged_in', properties: {
      'login_type': 'google',
    });
    emit(const LoginState.loading());
  }

  Future<void> _onAppleLogin(
    AppleLogin event,
    Emitter<LoginState> emit,
  ) async {
    await appleLoginUseCase.call();

    Posthog().capture(eventName: 'user_logged_in', properties: {
      'login_type': 'apple',
    });
  }

  Future<void> _onSpotifyEvent(
    SpotifyEvent event,
    Emitter<LoginState> emit,
  ) async {
    await spotifyLoginUseCase.call();
  }

  Future<void> _onCreateUserProfile(
    CreateUserProfile event,
    Emitter<LoginState> emit,
  ) async {
    final supabase = Supabase.instance.client;
    final session = supabase.auth.currentSession;
    if (session == null) {
      return;
    }

    final params = CreateUserBody(username: 'somarek123', supabaseUid: session.user.id);
    final result = await createUserUseCase.call(params);

    result.map(success: (success) {
      Posthog().identify(userId: success.user.id.toString(), userProperties: {
        "supabase_uid": session.user.id,
        "username": success.user.username,
      });

      Posthog().capture(eventName: 'user_signed_up', properties: {
        'login_type': 'email',
      });

      accountNavigation.goToAccount();
    }, failure: (failure) {
      print(failure);
    });
  }

  Future<void> _onGoBack(
    GoBack event,
    Emitter<LoginState> emit,
  ) async {
    loginNavigation.goBack(event.path);
  }
}
