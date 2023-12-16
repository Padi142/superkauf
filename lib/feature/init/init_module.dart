import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/init/use_case/init_navigation.dart';
import 'package:superkauf/feature/init/view/init_screen.dart';

import '../../library/app_module.dart';
import 'bloc/init_bloc.dart';

class InitModule extends AppModule {
  @override
  void registerNavigation() {
    GetIt.I.registerFactory<InitNavigation>(() => InitNavigation());
  }

  @override
  void registerBloc() {
    GetIt.I.registerFactory<InitBloc>(
      () => InitBloc(
        initNavigation: GetIt.I.get<InitNavigation>(),
      ),
    );
  }

  @override
  void registerScreen() {
    GetIt.I.registerFactory<InitScreen>(() => InitScreen());
  }

  @override
  void registerRoute(routes) {
    routes[InitScreen.name] = (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<InitBloc>.value(
            value: GetIt.I.get<InitBloc>(),
          ),
        ],
        child: GetIt.I.get<InitScreen>(),
      );
    };
  }
}
