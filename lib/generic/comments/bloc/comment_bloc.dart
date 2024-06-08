import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/generic/comments/bloc/comment_state.dart';
import 'package:superkauf/generic/comments/model/create_comment_body.dart';
import 'package:superkauf/generic/comments/model/delete_comment_body.dart';
import 'package:superkauf/generic/comments/model/like_comment_body.dart';
import 'package:superkauf/generic/comments/model/post_comment_model.dart';
import 'package:superkauf/generic/comments/use_case/create_comment_use_case.dart';
import 'package:superkauf/generic/comments/use_case/delete_comment_use_case.dart';
import 'package:superkauf/generic/comments/use_case/get_comments_for_post_use_case.dart';
import 'package:superkauf/generic/comments/use_case/like_comment_use_case.dart';
import 'package:superkauf/generic/post/model/models/add_reaction_model.dart';
import 'package:superkauf/generic/post/use_case/add_reaction_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

part 'comment_event.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetCommentsForPostUseCase getCommentsUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;
  final CreateCommentUseCase createCommentUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final LikeCommentUseCase likeCommentUseCase;
  final AddReactionUseCase addPostReactionUseCase;

  CommentBloc({
    required this.getCommentsUseCase,
    required this.deleteCommentUseCase,
    required this.createCommentUseCase,
    required this.getCurrentUserUseCase,
    required this.likeCommentUseCase,
    required this.addPostReactionUseCase,
  }) : super(const CommentState.loading()) {
    on<GetCommentsForPost>(_onGetCommentsForPost);
    on<CreateCommentEvent>(_onCreateCommentEvent);
    on<DeleteCommentEvent>(_onDeleteCommentEvent);
    on<LikeCommentEvent>(_onLikeCommentEvent);
    on<ReplyCommentEvent>(_onReplyCommentEvent);
  }

  Future<void> _onGetCommentsForPost(
    GetCommentsForPost event,
    Emitter<CommentState> emit,
  ) async {
    emit(const CommentState.loading());
    final currentUser = await getCurrentUserUseCase.call(false);

    final result = await getCommentsUseCase.call(event.postId);

    result.when(
      success: (success) {
        final comments = success.where((element) => element.comment.parentId == null).toList();

        var replies = <int, List<PostCommentModel>>{};

        comments.asMap().forEach((index, value) {
          replies[index] = success.where((element) => element.comment.parentId == value.comment.id).toList();
          replies[index]!.sort((a, b) => a.comment.createdAt.compareTo(b.comment.createdAt));
        });

        emit(CommentState.success(comments, replies, currentUser));
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

    final user = await getCurrentUserUseCase.call(false);

    if (user == null) {
      emit(const CommentState.error('No user found. Are you logged in?'));
      return;
    }

    int? reactionId;

    if (event.reaction != null) {
      final token = Supabase.instance.client.auth.currentSession?.accessToken ?? '';

      final reactionResult = await addPostReactionUseCase.call((
        model: AddReactionModel(
          type: event.reaction!,
          user: user.id,
          post: event.postId,
        ),
        token: token
      ));

      reactionResult.map(
          success: (success) {
            reactionId = success.reaction.id;
          },
          failure: (failure) {});
    }

    final params = CreateCommentBody(
      post: event.postId,
      user: user.id,
      comment: event.comment,
      parentId: null,
      reactionId: reactionId,
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

    Posthog().capture(eventName: 'comment_created', properties: {
      'post_id': params.post,
    });

    add(GetCommentsForPost(postId: event.postId));
  }

  Future<void> _onDeleteCommentEvent(
    DeleteCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    emit(const CommentState.loading());

    final user = await getCurrentUserUseCase.call(false);

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
        Posthog().capture(eventName: 'comment_deleted', properties: {
          'post_id': event.postId,
        });
        add(GetCommentsForPost(postId: event.postId));
      },
      failure: (message) {
        emit(CommentState.error(message));
      },
    );
  }

  Future<void> _onLikeCommentEvent(
    LikeCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    final oldState = state;
    emit(const CommentState.loading());

    final user = await getCurrentUserUseCase.call(false);

    if (user == null) {
      emit(const CommentState.error('user not found'));
      return;
    }

    final params = LikeCommentBody(
      user: user.id,
      type: 'like',
      comment: event.comment,
    );

    final result = await likeCommentUseCase.call(params);
    result.when(
      success: (success) {
        Posthog().capture(eventName: 'comment_liked', properties: {
          'post_id': event.postId,
        });
        add(GetCommentsForPost(postId: event.postId));
      },
      failure: (message) {
        emit(const CommentState.error("Can't like this comment. Try again later."));
        emit(oldState);
      },
    );
  }

  Future<void> _onReplyCommentEvent(
    ReplyCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    emit(const CommentState.loading());

    final user = await getCurrentUserUseCase.call(false);

    if (user == null) {
      emit(const CommentState.error('user not found'));
      return;
    }

    final params = CreateCommentBody(
      post: event.postId,
      user: user.id,
      comment: event.comment,
      parentId: event.commentId,
      reactionId: null,
    );

    final result = await createCommentUseCase.call(params);
    result.when(
      success: (success) async {
        Posthog().capture(eventName: 'comment_replied', properties: {
          'post_id': event.postId,
        });
      },
      failure: (message) {
        emit(CommentState.error(message));
      },
    );

    add(GetCommentsForPost(postId: event.postId));
  }
}
