import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/account/use_case/account_navigation.dart';
import 'package:superkauf/feature/login/use_case/apple_login.dart';
import 'package:superkauf/feature/login/use_case/discord_login.dart';
import 'package:superkauf/feature/login/use_case/email_login_use_case.dart';
import 'package:superkauf/feature/login/use_case/google_login.dart';
import 'package:superkauf/feature/login/use_case/spotify_login.dart';
import 'package:superkauf/feature/login/view/login_screen.dart';

import '../../library/app_module.dart';
import 'bloc/login_bloc.dart';

class LoginModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerUseCase() {
    GetIt.I.registerFactory<DiscordLoginUseCase>(
      () => DiscordLoginUseCase(),
    );
    GetIt.I.registerFactory<EmailLoginUseCase>(
      () => EmailLoginUseCase(),
    );
    GetIt.I.registerFactory<AppleLoginUseCase>(
      () => AppleLoginUseCase(),
    );
    GetIt.I.registerFactory<GoogleLoginUseCase>(
      () => GoogleLoginUseCase(),
    );
    GetIt.I.registerFactory<SpotifyLoginUseCase>(
      () => SpotifyLoginUseCase(),
    );
  }

  @override
  void registerBloc() {
    GetIt.I.registerFactory<LoginBloc>(
      () => LoginBloc(
        discordLoginUseCase: GetIt.I.get<DiscordLoginUseCase>(),
        appleLoginUseCase: GetIt.I.get<AppleLoginUseCase>(),
        googleLoginUseCase: GetIt.I.get<GoogleLoginUseCase>(),
        spotifyLoginUseCase: GetIt.I.get<SpotifyLoginUseCase>(),
        emailLoginUseCase: GetIt.I.get<EmailLoginUseCase>(),
        loginNavigation: GetIt.I.get<AccountNavigation>(),
      ),
    );
  }

  @override
  void registerScreen() {
    GetIt.I.registerFactory<LoginScreen>(() => LoginScreen());
  }

  @override
  void registerRoute(routes) {
    routes[LoginScreen.name] = (context) {
      return BlocProvider<LoginBloc>(
        create: (_) => GetIt.I.get<LoginBloc>(),
        child: GetIt.I.get<LoginScreen>(),
      );
    };
  }
}
