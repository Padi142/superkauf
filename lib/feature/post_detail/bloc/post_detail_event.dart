part of 'post_detail_bloc.dart';

abstract class PostDetailEvent extends Equatable {
  const PostDetailEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends PostDetailEvent {
  final PostModel? post;
  final int? postId;
  final UserModel? user;
  final int? userId;

  const InitialEvent({this.post, this.user, this.postId, this.userId});
}

class GetPost extends PostDetailEvent {
  final String postId;

  const GetPost({required this.postId});
}

class ReloadPost extends PostDetailEvent {
  final bool wait;
  final String postId;

  const ReloadPost({required this.postId, this.wait = false});
}
