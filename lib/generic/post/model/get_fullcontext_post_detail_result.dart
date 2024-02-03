import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';

part 'get_fullcontext_post_detail_result.freezed.dart';

@freezed
class GetFullContextPostDetailResult with _$GetFullContextPostDetailResult {
  const factory GetFullContextPostDetailResult.success(FullContextPostModel post) = Success;

  const factory GetFullContextPostDetailResult.failure(String message) = Failure;
}
