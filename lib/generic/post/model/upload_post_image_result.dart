import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_post_image_result.freezed.dart';

@freezed
class UploadPostImageResult with _$UploadPostImageResult {
  const factory UploadPostImageResult.success(String path) = Success;

  const factory UploadPostImageResult.failure(String message) = Failure;
}
