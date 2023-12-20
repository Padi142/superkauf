import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/generic/post/model/post_model.dart';

part 'get_post_detail_result.freezed.dart';

@freezed
class GetPostDetailResult with _$GetPostDetailResult {
  const factory GetPostDetailResult.success(PostModel post) = Success;

  const factory GetPostDetailResult.failure(String message) = Failure;
}
