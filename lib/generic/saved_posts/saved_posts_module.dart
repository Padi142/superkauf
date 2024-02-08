import 'package:get_it/get_it.dart';
import 'package:superkauf/generic/api/saved_posts_api.dart';
import 'package:superkauf/generic/saved_posts/data/saved_posts_repository.dart';
import 'package:superkauf/generic/saved_posts/use_case/create_saved_post_use_case.dart';
import 'package:superkauf/generic/saved_posts/use_case/delete_saved_post_use_case.dart';
import 'package:superkauf/generic/saved_posts/use_case/get_saved_posts_by_user_use_case.dart';
import 'package:superkauf/generic/saved_posts/use_case/update_saved_post_use_case.dart';
import 'package:superkauf/library/app_module.dart';

class SavedPostsModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerRepo() {
    GetIt.I.registerFactory<SavedPostsRepository>(
      () => SavedPostsRepository(
        savedPostsApi: GetIt.I.get<SavedPostsApi>(),
      ),
    );
  }

  @override
  void registerBloc() {}

  @override
  void registerScreen() {}

  @override
  void registerUseCase() {
    GetIt.I.registerFactory<CreateSavedPostUseCase>(
      () => CreateSavedPostUseCase(
          repository: GetIt.I.get<SavedPostsRepository>()),
    );

    GetIt.I.registerFactory<DeleteSavedPostUseCase>(
      () => DeleteSavedPostUseCase(
          repository: GetIt.I.get<SavedPostsRepository>()),
    );

    GetIt.I.registerFactory<GetSavedPostsByUserUseCase>(
      () => GetSavedPostsByUserUseCase(
          repository: GetIt.I.get<SavedPostsRepository>()),
    );

    GetIt.I.registerFactory<UpdateSavedPostUseCase>(
      () => UpdateSavedPostUseCase(
          repository: GetIt.I.get<SavedPostsRepository>()),
    );
  }

  @override
  void registerDI() {}
}
