import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/account/use_case/account_navigation.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/login/use_case/apple_login.dart';
import 'package:superkauf/feature/login/use_case/discord_login.dart';
import 'package:superkauf/feature/login/use_case/email_login_use_case.dart';
import 'package:superkauf/feature/login/use_case/google_login.dart';
import 'package:superkauf/feature/login/use_case/spotify_login.dart';
import 'package:superkauf/feature/login/view/login_screen.dart';
import 'package:superkauf/feature/my_channel/bloc/my_channel_bloc.dart';

import '../../generic/user/use_case/create_user_use_case.dart';
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
        createUserUseCase: GetIt.I.get<CreateUserUseCase>(),
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
      return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>.value(
            value: GetIt.I.get<LoginBloc>(),
          ),
          BlocProvider<MyChannelBloc>.value(
            value: GetIt.I.get<MyChannelBloc>(),
          ),
          BlocProvider<NavigationBloc>.value(
            value: GetIt.I.get<NavigationBloc>(),
          ),
        ],
        child: GetIt.I.get<LoginScreen>(),
      );
    };
  }
}
