import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/home/bloc/home_bloc/home_bloc.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/home/use_case/home_navigation.dart';
import 'package:superkauf/feature/home/view/home_screen.dart';

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
      return BlocProvider<NavigationBloc>(
        create: (_) => GetIt.I.get<NavigationBloc>(),
        child: BlocProvider<HomeBloc>(
          create: (_) => GetIt.I.get<HomeBloc>(),
          child: GetIt.I.get<HomeScreen>(),
        ),
      );
    };
  }

// @override
// void registerRoute(routes) {
//   routes[HomeScreen.name] = (context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<HomeBloc>.value(
//           value: GetIt.I.get<HomeBloc>(),
//         ),
//         BlocProvider<NavigationBloc>.value(
//           value: GetIt.I.get<NavigationBloc>(),
//         ),
//       ],
//       child: GetIt.I.get<HomeScreen>(),
//     );
//   };
// }
// @override
// void registerDI() {
//   GetIt.I.registerFactory<Widget>(
//         () =>
//         MultiBlocProvider(
//           providers: [
//             BlocProvider<HomeBloc>.value(
//               value: GetIt.I.get<HomeBloc>(),
//             ),
//             BlocProvider<NavigationBloc>.value(
//               value: GetIt.I.get<NavigationBloc>(),
//             ),
//           ],
//           child: GetIt.I.get<HomeScreen>(),
//         ),
//     instanceName: ScreenPath.homeScreen,
//   );
// }
}
