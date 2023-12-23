import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/saved_posts/model/saved_post_model.dart';

part 'delete_saved_post_model.freezed.dart';

@freezed
class DeleteSavedPostResult with _$DeleteSavedPostResult {
  const factory DeleteSavedPostResult.success(SavedPostModel post) = Success;

  const factory DeleteSavedPostResult.failure(String message) = Failure;
}
