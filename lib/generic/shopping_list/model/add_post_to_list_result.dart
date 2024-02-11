import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_post_to_list_result.freezed.dart';

@freezed
class AddSavedPostToLostResult with _$AddSavedPostToLostResult {
  const factory AddSavedPostToLostResult.success() = Success;

  const factory AddSavedPostToLostResult.failure(String message) = Failure;
}
