import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';

part 'get_paginatedl_feed_result.freezed.dart';

@freezed
class GetPersonalFeedResult with _$GetPersonalFeedResult {
  const factory GetPersonalFeedResult.success(GetPaginatedPostsResponseModel response) = Success;

  const factory GetPersonalFeedResult.failure(String message) = Failure;
}
