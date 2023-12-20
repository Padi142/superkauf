import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/create_post/bloc/create_post_bloc.dart';
import 'package:superkauf/feature/create_post/use_case/create_post_navigation.dart';
import 'package:superkauf/feature/create_post/use_case/pick_image_camera_use_case.dart';
import 'package:superkauf/feature/create_post/use_case/pick_image_use_case.dart';
import 'package:superkauf/feature/create_post/view/create_post_page.dart';
import 'package:superkauf/generic/post/use_case/create_post_use_case.dart';
import 'package:superkauf/generic/post/use_case/upload_post_image_use_case.dart';
import 'package:superkauf/generic/store/bloc/store_bloc.dart';
import 'package:superkauf/generic/store/use_case/get_stores_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_uid_use_case.dart';

import '../../library/app_module.dart';

class CreatePostModule extends AppModule {
  @override
  void registerNavigation() {
    GetIt.I.registerFactory<CreatePostNavigation>(() => CreatePostNavigation());
  }

  @override
  void registerUseCase() {
    GetIt.I.registerFactory<PickImageUseCase>(
      () => PickImageUseCase(),
    );

    GetIt.I.registerFactory<PickImageCameraUseCase>(
      () => PickImageCameraUseCase(),
    );
  }

  @override
  void registerBloc() {
    GetIt.I.registerFactory<CreatePostBloc>(
      () => CreatePostBloc(
        uploadPostImageUseCase: GetIt.I.get<UploadPostImageUseCase>(),
        createPostUseCase: GetIt.I.get<CreatePostUseCase>(),
        pickImageUseCase: GetIt.I.get<PickImageUseCase>(),
        createPostNavigation: GetIt.I.get<CreatePostNavigation>(),
        getUserByUidUseCase: GetIt.I.get<GetUserByUidUseCase>(),
        pickImageCameraUseCase: GetIt.I.get<PickImageCameraUseCase>(),
        getStoresUseCase: GetIt.I.get<GetStoresUseCase>(),
      ),
    );
  }

  @override
  void registerScreen() {
    GetIt.I.registerFactory<CreatePostScreen>(() => CreatePostScreen());
  }

  @override
  void registerRoute(routes) {
    routes[CreatePostScreen.name] = (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<CreatePostBloc>.value(
            value: GetIt.I.get<CreatePostBloc>(),
          ),
          BlocProvider<StoreBloc>.value(
            value: GetIt.I.get<StoreBloc>(),
          ),
        ],
        child: GetIt.I.get<CreatePostScreen>(),
      );
    };
  }
}
