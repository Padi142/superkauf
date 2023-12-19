import 'package:get_it/get_it.dart';
import 'package:superkauf/generic/api/user_api.dart';
import 'package:superkauf/generic/user/data/user_repository.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_id_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_uid_use_case.dart';
import 'package:superkauf/generic/user/use_case/updat_user_use_case.dart';
import 'package:superkauf/library/app_module.dart';

class UserModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerRepo() {
    GetIt.I.registerFactory<UserRepository>(
      () => UserRepository(
        userApi: GetIt.I.get<UserApi>(),
      ),
    );
  }

  @override
  void registerBloc() {}

  @override
  void registerScreen() {}

  @override
  void registerUseCase() {
    GetIt.I.registerFactory<GetUserByIdUseCase>(
      () => GetUserByIdUseCase(repository: GetIt.I.get<UserRepository>()),
    );

    GetIt.I.registerFactory<GetUserByUidUseCase>(
      () => GetUserByUidUseCase(repository: GetIt.I.get<UserRepository>()),
    );

    GetIt.I.registerFactory<UpdateUserUseCase>(
      () => UpdateUserUseCase(repository: GetIt.I.get<UserRepository>()),
    );
  }

  @override
  void registerDI() {}
}
