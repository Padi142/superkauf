import 'package:superkauf/generic/post/model/upload_post_image_params.dart';
import 'package:superkauf/generic/post/model/upload_post_image_result.dart';
import 'package:superkauf/generic/upload/data/r2_upload_service.dart';
import 'package:superkauf/library/use_case.dart';

class UploadUserImageUseCase
    extends UseCase<UploadImageResult, UploadImageParams> {
  final R2UploadService uploadService;

  UploadUserImageUseCase({
    required this.uploadService,
  });

  @override
  Future<UploadImageResult> call(params) async {
    return uploadService.uploadImage(
      params: params,
      bucket: 'profile_pics',
    );
  }
}
