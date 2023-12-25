import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/comments/model/post_comment_model.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

part 'comment_state.freezed.dart';

@freezed
abstract class CommentState with _$CommentState {
  const factory CommentState.loading() = Loading;

  const factory CommentState.success(
      List<PostCommentModel> comments, UserModel? currentUser) = Success;

  const factory CommentState.error(String error) = Error;
}
