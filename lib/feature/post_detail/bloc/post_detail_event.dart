part of 'post_detail_bloc.dart';

abstract class PostDetailEvent extends Equatable {
  const PostDetailEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends PostDetailEvent {
  final PostModel post;
  final UserModel user;

  const InitialEvent({required this.post, required this.user});
}

class GetPost extends PostDetailEvent {
  final String postId;

  const GetPost({required this.postId});
}
