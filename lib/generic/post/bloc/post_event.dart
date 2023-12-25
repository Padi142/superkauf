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

class SavePost extends PostEvent {
  final int postId;

  const SavePost({
    required this.postId,
  });
}

class UpdatePost extends PostEvent {
  final int postId;
  final String newDescription;

  const UpdatePost({
    required this.postId,
    required this.newDescription,
  });
}

class RemoveSavedPost extends PostEvent {
  final int postId;

  const RemoveSavedPost({
    required this.postId,
  });
}
