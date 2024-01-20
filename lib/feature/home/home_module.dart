import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/home/bloc/home_bloc/home_bloc.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/home/use_case/home_navigation.dart';
import 'package:superkauf/feature/home/view/home_screen.dart';
import 'package:superkauf/feature/snackbar/bloc/snackbar_bloc.dart';
import 'package:superkauf/generic/notifications/presentation/check_notifications_bloc.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';

import '../../library/app_module.dart';

class HomeModule extends AppModule {
  @override
  void registerNavigation() {
    GetIt.I.registerFactory<HomeNavigation>(() => HomeNavigation());
  }

  @override
  void registerBloc() {
    GetIt.I.registerSingleton<HomeBloc>(
      HomeBloc(
        homeNavigation: GetIt.I.get<HomeNavigation>(),
      ),
    );

    GetIt.I.registerSingleton<NavigationBloc>(
      NavigationBloc(),
    );
  }

  @override
  void registerScreen() {
    GetIt.I.registerFactory<HomeScreen>(() => HomeScreen());
  }

  @override
  void registerRoute(routes) {
    routes[HomeScreen.name] = (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>.value(
            value: GetIt.I.get<HomeBloc>(),
          ),
          BlocProvider<PostBloc>.value(
            value: GetIt.I.get<PostBloc>(),
          ),
          BlocProvider<SnackbarBloc>.value(
            value: GetIt.I.get<SnackbarBloc>(),
          ),
          BlocProvider<CheckNotificationBloc>.value(
            value: GetIt.I.get<CheckNotificationBloc>(),
          ),
        ],
        child: GetIt.I.get<HomeScreen>(),
      );
    };
  }
}
