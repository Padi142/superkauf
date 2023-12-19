import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_post_result.freezed.dart';

@freezed
class DeletePostResult with _$DeletePostResult {
  const factory DeletePostResult.success() = Success;

  const factory DeletePostResult.failure(String message) = Failure;
}
