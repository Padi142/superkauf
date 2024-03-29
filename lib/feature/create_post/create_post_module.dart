import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/create_post/bloc/create_post_bloc.dart';
import 'package:superkauf/feature/create_post/use_case/create_post_navigation.dart';
import 'package:superkauf/feature/create_post/use_case/pick_image_camera_use_case.dart';
import 'package:superkauf/feature/create_post/use_case/pick_image_use_case.dart';
import 'package:superkauf/feature/create_post/view/create_post_page.dart';
import 'package:superkauf/generic/label/bloc/label_bloc.dart';
import 'package:superkauf/generic/label/use_case/create_label_use_case.dart';
import 'package:superkauf/generic/label/use_case/get_labels_use_case.dart';
import 'package:superkauf/generic/post/use_case/create_post_use_case.dart';
import 'package:superkauf/generic/post/use_case/update_post_image_use_case.dart';
import 'package:superkauf/generic/post/use_case/upload_post_image_use_case.dart';
import 'package:superkauf/generic/settings/use_case/get_settings_use_case.dart';
import 'package:superkauf/generic/store/bloc/store_bloc.dart';
import 'package:superkauf/generic/store/use_case/get_stores_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

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
        pickImageCameraUseCase: GetIt.I.get<PickImageCameraUseCase>(),
        getStoresUseCase: GetIt.I.get<GetStoresUseCase>(),
        getCurrentUserUseCase: GetIt.I.get<GetCurrentUserUseCase>(),
        updatePostImageUseCase: GetIt.I.get<UpdatePostImageUseCase>(),
        uploadS3PostImageUseCase: GetIt.I.get<UploadS3PostImageUseCase>(),
        getLabelsUseCase: GetIt.I.get<GetLabelsUseCase>(),
        createLabelUseCase: GetIt.I.get<CreateLabelUseCase>(),
        getSettingsUseCase: GetIt.I.get<GetSettingsUseCase>(),
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
          BlocProvider<StoreBloc>.value(
            value: GetIt.I.get<StoreBloc>(),
          ),
          BlocProvider<LabelBloc>.value(
            value: GetIt.I.get<LabelBloc>(),
          ),
        ],
        child: GetIt.I.get<CreatePostScreen>(),
      );
    };
  }
}
