import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/comments/model/comment_model.dart';

part 'get_comments_result.freezed.dart';

@freezed
class GetCommentsResult with _$GetCommentsResult {
  const factory GetCommentsResult.success(List<CommentModel> comments) =
      Success;

  const factory GetCommentsResult.failure(String message) = Failure;
}
