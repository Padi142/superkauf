import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/generic/post/model/upload_post_image_params.dart';
import 'package:superkauf/generic/post/model/upload_post_image_result.dart';
import 'package:superkauf/library/use_case.dart';

class UploadUserImageUseCase extends UseCase<UploadImageResult, UploadImageParams> {
  UploadUserImageUseCase();

  @override
  Future<UploadImageResult> call(params) async {
    final supabase = Supabase.instance.client;

    final response = await supabase.storage.from('profile_pics').upload(params.path, params.file, fileOptions: const FileOptions(upsert: true));
    if (response == "") {
      return const UploadImageResult.failure('Upload failed');
    }
    return UploadImageResult.success(response);
  }
}
