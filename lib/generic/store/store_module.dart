import 'package:get_it/get_it.dart';
import 'package:superkauf/generic/api/store_api.dart';
import 'package:superkauf/generic/settings/use_case/get_settings_use_case.dart';
import 'package:superkauf/generic/store/bloc/store_bloc.dart';
import 'package:superkauf/generic/store/data/stores_repository.dart';
import 'package:superkauf/generic/store/use_case/GetStoresUseCase.dart';
import 'package:superkauf/generic/store/use_case/get_posts_by_store_use_case.dart';
import 'package:superkauf/generic/store/use_case/get_stores_use_case.dart';
import 'package:superkauf/library/app_module.dart';

class StoreModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerRepo() {
    GetIt.I.registerFactory<StoresRepository>(
      () => StoresRepository(
        storeApi: GetIt.I.get<StoreApi>(),
      ),
    );
  }

  @override
  void registerBloc() {
    GetIt.I.registerFactory<StoreBloc>(
      () => StoreBloc(
        getStoresUseCase: GetIt.I.get<GetStoresUseCase>(),
        getSettingsUseCase: GetIt.I.get<GetSettingsUseCase>(),
      ),
    );
  }

  @override
  void registerScreen() {}

  @override
  void registerUseCase() {
    GetIt.I.registerFactory<GetStoresUseCase>(
      () => GetStoresUseCase(repository: GetIt.I.get<StoresRepository>()),
    );

    GetIt.I.registerFactory<GetPostsByStoreUseCase>(
      () => GetPostsByStoreUseCase(repository: GetIt.I.get<StoresRepository>()),
    );

    GetIt.I.registerFactory<GetStoreUseCase>(
      () => GetStoreUseCase(repository: GetIt.I.get<StoresRepository>()),
    );
  }

  @override
  void registerDI() {}
}
