import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/generic/post/model/post_model.dart';

part 'get_posts_by_store_result.freezed.dart';

@freezed
class GetPostsByStoreResult with _$GetPostsByStoreResult {
  const factory GetPostsByStoreResult.success(List<FeedPostModel> stores) = Success;

  const factory GetPostsByStoreResult.failure(String message) = Failure;
}
