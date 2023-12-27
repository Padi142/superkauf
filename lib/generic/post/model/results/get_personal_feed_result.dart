import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';

part 'get_personal_feed_result.freezed.dart';

@freezed
class GetPersonalFeedResult with _$GetPersonalFeedResult {
  const factory GetPersonalFeedResult.success(GetPersonalFeedResponseModel response) = Success;

  const factory GetPersonalFeedResult.failure(String message) = Failure;
}
