import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';

part 'get_saved_posts_result.freezed.dart';

@freezed
class GetSavedPostsResult with _$GetSavedPostsResult {
  const factory GetSavedPostsResult.success(GetPaginatedPostsResponseModel response) = Success;

  const factory GetSavedPostsResult.failure(String message) = Failure;
}
