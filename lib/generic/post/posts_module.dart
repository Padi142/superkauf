import 'package:get_it/get_it.dart';
import 'package:superkauf/generic/api/post_api.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';
import 'package:superkauf/generic/post/data/post_repository.dart';
import 'package:superkauf/generic/post/use_case/add_reaction_use_case.dart';
import 'package:superkauf/generic/post/use_case/create_post_use_case.dart';
import 'package:superkauf/generic/post/use_case/delete_post_use_case.dart';
import 'package:superkauf/generic/post/use_case/get_personal_feed_use_case.dart';
import 'package:superkauf/generic/post/use_case/get_post_detail_use_case.dart';
import 'package:superkauf/generic/post/use_case/get_posts_by_user.dart';
import 'package:superkauf/generic/post/use_case/get_posts_use_case.dart';
import 'package:superkauf/generic/post/use_case/remove_reaction_use_case.dart';
import 'package:superkauf/generic/post/use_case/update_post_image_use_case.dart';
import 'package:superkauf/generic/post/use_case/update_post_use_case.dart';
import 'package:superkauf/generic/post/use_case/upload_post_image_use_case.dart';
import 'package:superkauf/generic/report/user_case/create_report_use_case.dart';
import 'package:superkauf/generic/saved_posts/use_case/create_saved_post_use_case.dart';
import 'package:superkauf/generic/saved_posts/use_case/delete_saved_post_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';
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
        createSavedPostUseCase: GetIt.I.get<CreateSavedPostUseCase>(),
        deleteSavedPostUseCase: GetIt.I.get<DeleteSavedPostUseCase>(),
        getCurrentUser: GetIt.I.get<GetCurrentUserUseCase>(),
        updatePostUseCase: GetIt.I.get<UpdatePostUseCase>(),
        updatePostValidUntilUseCase: GetIt.I.get<UpdatePostValidUntilUseCase>(),
        addReactionUseCase: GetIt.I.get<AddReactionUseCase>(),
        removeReactionUseCase: GetIt.I.get<RemoveReactionUseCase>(),
        createReportUseCase: GetIt.I.get<CreateReportUseCase>(),
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

    GetIt.I.registerFactory<UpdatePostImageUseCase>(
      () => UpdatePostImageUseCase(repository: GetIt.I.get<PostsRepository>()),
    );

    GetIt.I.registerFactory<UpdatePostUseCase>(
      () => UpdatePostUseCase(repository: GetIt.I.get<PostsRepository>()),
    );

    GetIt.I.registerFactory<AddReactionUseCase>(
      () => AddReactionUseCase(repository: GetIt.I.get<PostsRepository>()),
    );

    GetIt.I.registerFactory<RemoveReactionUseCase>(
      () => RemoveReactionUseCase(repository: GetIt.I.get<PostsRepository>()),
    );

    GetIt.I.registerFactory<GetPersonalFeedUseCase>(
      () => GetPersonalFeedUseCase(repository: GetIt.I.get<PostsRepository>()),
    );

    GetIt.I.registerFactory<UpdatePostValidUntilUseCase>(
      () => UpdatePostValidUntilUseCase(repository: GetIt.I.get<PostsRepository>()),
    );
  }

  @override
  void registerDI() {}
}
