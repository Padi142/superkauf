import 'package:get_it/get_it.dart';
import 'package:superkauf/generic/api/countries_api.dart';
import 'package:superkauf/generic/countries/bloc/countries_bloc.dart';
import 'package:superkauf/generic/countries/data/countries_repository.dart';
import 'package:superkauf/generic/countries/use_case/get_countries_use_case.dart';
import 'package:superkauf/generic/settings/use_case/get_settings_use_case.dart';
import 'package:superkauf/generic/settings/use_case/update_settings_use_case.dart';
import 'package:superkauf/library/app_module.dart';

class CountriesModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerRepo() {
    GetIt.I.registerFactory<CountriesRepository>(
      () => CountriesRepository(
        countriesApi: GetIt.I.get<CountriesApi>(),
      ),
    );
  }

  @override
  void registerBloc() {
    GetIt.I.registerFactory<CountriesBloc>(
      () => CountriesBloc(
        getCountriesUseCase: GetIt.I.get<GetCountriesUseCase>(),
        updateSettingsUseCase: GetIt.I.get<UpdateSettingsUseCase>(),
        getSettingsUseCase: GetIt.I.get<GetSettingsUseCase>(),
      ),
    );
  }

  @override
  void registerScreen() {}

  @override
  void registerUseCase() {
    GetIt.I.registerFactory<GetCountriesUseCase>(
      () => GetCountriesUseCase(repository: GetIt.I.get<CountriesRepository>()),
    );
  }

  @override
  void registerDI() {}
}
