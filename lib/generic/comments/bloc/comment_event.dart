part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class GetCommentsForPost extends CommentEvent {
  final int postId;
  const GetCommentsForPost({
    required this.postId,
  });
}

class CreateCommentEvent extends CommentEvent {
  final int postId;
  final String comment;
  final String? reaction;
  const CreateCommentEvent({
    required this.postId,
    required this.comment,
    required this.reaction,
  });
}

class LikeCommentEvent extends CommentEvent {
  final int comment;
  final int postId;
  const LikeCommentEvent({
    required this.comment,
    required this.postId,
  });
}

class ReplyCommentEvent extends CommentEvent {
  final int postId;
  final int commentId;
  final String comment;
  const ReplyCommentEvent({
    required this.postId,
    required this.commentId,
    required this.comment,
  });
}

class DeleteCommentEvent extends CommentEvent {
  final int postId;

  final PostCommentModel post;
  const DeleteCommentEvent({
    required this.postId,
    required this.post,
  });
}
