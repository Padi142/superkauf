import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/generic/comments/bloc/comment_state.dart';
import 'package:superkauf/generic/comments/model/create_comment_body.dart';
import 'package:superkauf/generic/comments/model/delete_comment_body.dart';
import 'package:superkauf/generic/comments/model/post_comment_model.dart';
import 'package:superkauf/generic/comments/use_case/create_comment_use_case.dart';
import 'package:superkauf/generic/comments/use_case/delete_comment_use_case.dart';
import 'package:superkauf/generic/comments/use_case/get_comments_for_post_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

part 'comment_event.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetCommentsForPostUseCase getCommentsUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;
  final CreateCommentUseCase createCommentUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  CommentBloc({
    required this.getCommentsUseCase,
    required this.deleteCommentUseCase,
    required this.createCommentUseCase,
    required this.getCurrentUserUseCase,
  }) : super(const CommentState.loading()) {
    on<GetCommentsForPost>(_onGetCommentsForPost);
    on<CreateCommentEvent>(_onCreateCommentEvent);
    on<DeleteCommentEvent>(_onDeleteCommentEvent);
  }

  Future<void> _onGetCommentsForPost(
    GetCommentsForPost event,
    Emitter<CommentState> emit,
  ) async {
    emit(const CommentState.loading());
    final currentUser = await getCurrentUserUseCase.call();

    final result = await getCommentsUseCase.call(event.postId);
    result.when(
      success: (success) {
        emit(CommentState.success(success, currentUser));
      },
      failure: (message) {
        emit(CommentState.error(message));
      },
    );
  }

  Future<void> _onCreateCommentEvent(
    CreateCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    emit(const CommentState.loading());

    final user = await getCurrentUserUseCase.call();

    if (user == null) {
      emit(const CommentState.error('No user found. Are you logged in?'));
      return;
    }

    final params = CreateCommentBody(
      post: event.postId,
      user: user.id,
      comment: event.comment,
    );

    final result = await createCommentUseCase.call(params);
    result.when(
      success: (success) {
        add(GetCommentsForPost(postId: event.postId));
      },
      failure: (message) {
        emit(CommentState.error(message));
      },
    );

    add(GetCommentsForPost(postId: event.postId));
  }

  Future<void> _onDeleteCommentEvent(
    DeleteCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    emit(const CommentState.loading());

    final user = await getCurrentUserUseCase.call();

    if (user == null) {
      emit(const CommentState.error('user not found'));
      return;
    }

    final params = DeleteCommentBody(
      user: user.id,
      commentId: event.post.comment.id,
    );

    final result = await deleteCommentUseCase.call(params);
    result.when(
      success: (success) {
        add(GetCommentsForPost(postId: event.postId));
      },
      failure: (message) {
        emit(CommentState.error(message));
      },
    );
  }
}
