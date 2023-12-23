import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/saved_posts/model/saved_post_model.dart';

part 'create_saved_post_result.freezed.dart';

@freezed
class CreateSavedPostResult with _$CreateSavedPostResult {
  const factory CreateSavedPostResult.success(SavedPostModel post) = Success;

  const factory CreateSavedPostResult.failure(String message) = Failure;
}
