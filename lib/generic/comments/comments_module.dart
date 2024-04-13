import 'package:get_it/get_it.dart';
import 'package:superkauf/generic/api/comment_api.dart';
import 'package:superkauf/generic/comments/bloc/comment_bloc.dart';
import 'package:superkauf/generic/comments/data/comments_reository.dart';
import 'package:superkauf/generic/comments/use_case/create_comment_use_case.dart';
import 'package:superkauf/generic/comments/use_case/delete_comment_use_case.dart';
import 'package:superkauf/generic/comments/use_case/get_comments_for_post_use_case.dart';
import 'package:superkauf/generic/comments/use_case/like_comment_use_case.dart';
import 'package:superkauf/generic/post/use_case/add_reaction_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';
import 'package:superkauf/library/app_module.dart';

class CommentsModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerRepo() {
    GetIt.I.registerFactory<CommentsRepository>(
      () => CommentsRepository(
        commentApi: GetIt.I.get<CommentApi>(),
      ),
    );
  }

  @override
  void registerBloc() {
    GetIt.I.registerFactory<CommentBloc>(
      () => CommentBloc(
        createCommentUseCase: GetIt.I.get<CreateCommentUseCase>(),
        deleteCommentUseCase: GetIt.I.get<DeleteCommentUseCase>(),
        getCommentsUseCase: GetIt.I.get<GetCommentsForPostUseCase>(),
        getCurrentUserUseCase: GetIt.I.get<GetCurrentUserUseCase>(),
        likeCommentUseCase: GetIt.I.get<LikeCommentUseCase>(),
        addPostReactionUseCase: GetIt.I.get<AddReactionUseCase>(),
      ),
    );
  }

  @override
  void registerScreen() {}

  @override
  void registerUseCase() {
    GetIt.I.registerFactory<CreateCommentUseCase>(
      () => CreateCommentUseCase(
        repository: GetIt.I.get<CommentsRepository>(),
      ),
    );

    GetIt.I.registerFactory<DeleteCommentUseCase>(
      () => DeleteCommentUseCase(
        repository: GetIt.I.get<CommentsRepository>(),
      ),
    );

    GetIt.I.registerFactory<GetCommentsForPostUseCase>(
      () => GetCommentsForPostUseCase(repository: GetIt.I.get<CommentsRepository>()),
    );

    GetIt.I.registerFactory<LikeCommentUseCase>(
      () => LikeCommentUseCase(repository: GetIt.I.get<CommentsRepository>()),
    );
  }

  @override
  void registerDI() {}
}
