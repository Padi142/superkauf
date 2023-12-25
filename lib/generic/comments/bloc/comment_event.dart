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
  const CreateCommentEvent({
    required this.postId,
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
