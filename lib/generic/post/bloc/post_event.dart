part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class DeletePost extends PostEvent {
  final String postId;
  final int author;

  const DeletePost({
    required this.postId,
    required this.author,
  });
}
