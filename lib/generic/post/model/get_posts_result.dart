import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';

part 'get_posts_result.freezed.dart';

@freezed
class GetPostsResult with _$GetPostsResult {
  const factory GetPostsResult.success(List<FeedPostModel> posts) = Success;

  const factory GetPostsResult.failure(String message) = Failure;
}
