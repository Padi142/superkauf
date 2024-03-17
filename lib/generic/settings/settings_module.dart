import 'package:get_it/get_it.dart';
import 'package:superkauf/generic/settings/use_case/get_settings_use_case.dart';
import 'package:superkauf/generic/settings/use_case/update_settings_use_case.dart';
import 'package:superkauf/library/app_module.dart';

class SettingsModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerRepo() {}

  @override
  void registerBloc() {}

  @override
  void registerScreen() {}

  @override
  void registerUseCase() {
    GetIt.I.registerFactory<GetSettingsUseCase>(
      () => GetSettingsUseCase(),
    );

    GetIt.I.registerFactory<UpdateSettingsUseCase>(
      () => UpdateSettingsUseCase(),
    );
  }

  @override
  void registerDI() {}
}
