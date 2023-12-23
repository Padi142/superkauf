import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';

part 'get_saved_posts_result.freezed.dart';

@freezed
class GetSavedPostsResult with _$GetSavedPostsResult {
  const factory GetSavedPostsResult.success(List<FeedPostModel> posts) = Success;

  const factory GetSavedPostsResult.failure(String message) = Failure;
}
