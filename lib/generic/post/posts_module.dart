import 'package:get_it/get_it.dart';
import 'package:superkauf/generic/api/post_api.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';
import 'package:superkauf/generic/post/data/post_repository.dart';
import 'package:superkauf/generic/post/use_case/create_post_use_case.dart';
import 'package:superkauf/generic/post/use_case/delete_post_use_case.dart';
import 'package:superkauf/generic/post/use_case/get_post_detail_use_case.dart';
import 'package:superkauf/generic/post/use_case/get_posts_by_user.dart';
import 'package:superkauf/generic/post/use_case/get_posts_use_case.dart';
import 'package:superkauf/generic/post/use_case/upload_post_image_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_uid_use_case.dart';
import 'package:superkauf/library/app_module.dart';

class PostModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerRepo() {
    GetIt.I.registerFactory<PostsRepository>(
      () => PostsRepository(
        postApi: GetIt.I.get<PostApi>(),
      ),
    );
  }

  @override
  void registerBloc() {
    GetIt.I.registerFactory<PostBloc>(
      () => PostBloc(
        deletePostUseCase: GetIt.I.get<DeletePostUseCase>(),
        getUserByUidUseCase: GetIt.I.get<GetUserByUidUseCase>(),
      ),
    );
  }

  @override
  void registerScreen() {}

  @override
  void registerUseCase() {
    GetIt.I.registerFactory<GetPostsUseCase>(
      () => GetPostsUseCase(repository: GetIt.I.get<PostsRepository>()),
    );

    GetIt.I.registerFactory<UploadPostImageUseCase>(
      () => UploadPostImageUseCase(),
    );

    GetIt.I.registerFactory<CreatePostUseCase>(
      () => CreatePostUseCase(repository: GetIt.I.get<PostsRepository>()),
    );

    GetIt.I.registerFactory<DeletePostUseCase>(
      () => DeletePostUseCase(repository: GetIt.I.get<PostsRepository>()),
    );

    GetIt.I.registerFactory<GetPostDetailUseCase>(
      () => GetPostDetailUseCase(repository: GetIt.I.get<PostsRepository>()),
    );

    GetIt.I.registerFactory<GetPostsByUserUseCase>(
      () => GetPostsByUserUseCase(repository: GetIt.I.get<PostsRepository>()),
    );
  }

  @override
  void registerDI() {}
}
