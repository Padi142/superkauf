import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/account/bloc/account_bloc.dart';
import 'package:superkauf/feature/account/use_case/account_navigation.dart';
import 'package:superkauf/feature/account/view/account_screen.dart';

import '../../library/app_module.dart';

class AccountModule extends AppModule {
  @override
  void registerNavigation() {
    GetIt.I.registerFactory<AccountNavigation>(() => AccountNavigation());
  }

  @override
  void registerBloc() {
    GetIt.I.registerFactory<AccountBloc>(
      () => AccountBloc(accountNavigation: GetIt.I.get<AccountNavigation>()),
    );
  }

  @override
  void registerScreen() {
    GetIt.I.registerFactory<AccountScreen>(() => AccountScreen());
  }

  @override
  void registerRoute(routes) {
    routes[AccountScreen.name] = (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<AccountBloc>.value(
            value: GetIt.I.get<AccountBloc>(),
          ),
        ],
        child: GetIt.I.get<AccountScreen>(),
      );
    };
  }
}
