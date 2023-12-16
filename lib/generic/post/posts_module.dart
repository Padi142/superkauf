import 'package:get_it/get_it.dart';
import 'package:superkauf/generic/api/post_api.dart';
import 'package:superkauf/generic/post/data/post_repository.dart';
import 'package:superkauf/generic/post/use_case/get_posts_use_case.dart';
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
  void registerBloc() {}

  @override
  void registerScreen() {}

  @override
  void registerUseCase() {
    GetIt.I.registerFactory<GetPostsUseCase>(
      () => GetPostsUseCase(repository: GetIt.I.get<PostsRepository>()),
    );
  }

  @override
  void registerDI() {}
}
