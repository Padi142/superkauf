import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/account/bloc/account_bloc.dart';
import 'package:superkauf/feature/account/use_case/account_navigation.dart';
import 'package:superkauf/feature/account/view/account_screen.dart';
import 'package:superkauf/feature/create_post/use_case/pick_image_use_case.dart';
import 'package:superkauf/generic/post/use_case/get_posts_by_user.dart';
import 'package:superkauf/generic/settings/use_case/get_settings_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_username_use_case.dart';
import 'package:superkauf/generic/user/use_case/updat_user_use_case.dart';
import 'package:superkauf/generic/user/use_case/upload_user_image_use_case.dart';

import '../../library/app_module.dart';

class AccountModule extends AppModule {
  @override
  void registerNavigation() {
    GetIt.I.registerFactory<AccountNavigation>(() => AccountNavigation());
  }

  @override
  void registerBloc() {
    GetIt.I.registerFactory<AccountBloc>(
      () => AccountBloc(
        accountNavigation: GetIt.I.get<AccountNavigation>(),
        getCurrentUSeUseCase: GetIt.I.get<GetCurrentUserUseCase>(),
        updateUserUseCase: GetIt.I.get<UpdateUserUseCase>(),
        getUserByUsernameUseCase: GetIt.I.get<GetUserByUsernameUseCase>(),
        pickImageUseCase: GetIt.I.get<PickImageUseCase>(),
        uploadUserImageUseCase: GetIt.I.get<UploadUserImageUseCase>(),
        getPostsByUserUseCase: GetIt.I.get<GetPostsByUserUseCase>(),
        getSettingsUseCase: GetIt.I.get<GetSettingsUseCase>(),
      ),
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
