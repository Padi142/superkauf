import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/saved_posts/model/saved_post_model.dart';

part 'get_saved_post_result.freezed.dart';

@freezed
class GetSavedPostResult with _$GetSavedPostResult {
  const factory GetSavedPostResult.success(SavedPostModel post) = Success;

  const factory GetSavedPostResult.failure(String message) = Failure;
}
