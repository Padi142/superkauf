import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/snackbar/bloc/snackbar_bloc.dart';
import 'package:superkauf/library/app_module.dart';

class SnackbarModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerBloc() {
    GetIt.I.registerSingleton<SnackbarBloc>(
      SnackbarBloc(),
    );
  }

  @override
  void registerScreen() {}

  @override
  void registerRoute(routes) {}
}
