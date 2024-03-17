import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/settings/bloc/settings_bloc.dart';
import 'package:superkauf/feature/settings/view/settings_page.dart';
import 'package:superkauf/generic/countries/bloc/countries_bloc.dart';
import 'package:superkauf/generic/settings/use_case/get_settings_use_case.dart';

import '../../library/app_module.dart';

class UserSettingsModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerUseCase() {}

  @override
  void registerBloc() {
    GetIt.I.registerFactory<UserSettingsBloc>(() => UserSettingsBloc(
          getSettingsUseCase: GetIt.I.get<GetSettingsUseCase>(),
        ));
  }

  @override
  void registerScreen() {
    GetIt.I.registerFactory<SettingsScreen>(() => SettingsScreen());
  }

  @override
  void registerRoute(routes) {
    routes[SettingsScreen.name] = (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<UserSettingsBloc>.value(
            value: GetIt.I.get<UserSettingsBloc>(),
          ),
          BlocProvider<CountriesBloc>.value(
            value: GetIt.I.get<CountriesBloc>(),
          ),
        ],
        child: GetIt.I.get<SettingsScreen>(),
      );
    };
  }
}
