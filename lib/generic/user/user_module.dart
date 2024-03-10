import 'package:get_it/get_it.dart';
import 'package:superkauf/generic/api/user_api.dart';
import 'package:superkauf/generic/user/data/user_repository.dart';
import 'package:superkauf/generic/user/use_case/create_user_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_id_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_uid_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_username_use_case.dart';
import 'package:superkauf/generic/user/use_case/updat_user_use_case.dart';
import 'package:superkauf/generic/user/use_case/upload_user_image_use_case.dart';
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

    GetIt.I.registerFactory<CreateUserUseCase>(
      () => CreateUserUseCase(repository: GetIt.I.get<UserRepository>()),
    );

    GetIt.I.registerFactory<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(repository: GetIt.I.get<UserRepository>()),
    );

    GetIt.I.registerFactory<GetUserByUsernameUseCase>(
      () => GetUserByUsernameUseCase(repository: GetIt.I.get<UserRepository>()),
    );

    GetIt.I.registerFactory<UploadUserImageUseCase>(
      () => UploadUserImageUseCase(),
    );

    GetIt.I.registerFactory<UploadUserS3ImageUseCase>(
      () => UploadUserS3ImageUseCase(),
    );
  }

  @override
  void registerDI() {}
}
