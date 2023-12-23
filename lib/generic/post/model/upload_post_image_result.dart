import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_post_image_result.freezed.dart';

@freezed
class UploadImageResult with _$UploadImageResult {
  const factory UploadImageResult.success(String path) = Success;

  const factory UploadImageResult.failure(String message) = Failure;
}
