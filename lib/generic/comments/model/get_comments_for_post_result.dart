import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/comments/model/post_comment_model.dart';

part 'get_comments_for_post_result.freezed.dart';

@freezed
class GetCommentsForPostResult with _$GetCommentsForPostResult {
  const factory GetCommentsForPostResult.success(List<PostCommentModel> comments) = Success;

  const factory GetCommentsForPostResult.failure(String message) = Failure;
}
