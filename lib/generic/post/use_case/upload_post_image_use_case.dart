import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/generic/post/model/upload_post_image_params.dart';
import 'package:superkauf/generic/post/model/upload_post_image_result.dart';
import 'package:superkauf/library/use_case.dart';

class UploadPostImageUseCase extends UseCase<UploadPostImageResult, UploadPostImageParams> {
  UploadPostImageUseCase();

  @override
  Future<UploadPostImageResult> call(params) async {
    final supabase = Supabase.instance.client;

    // final session = supabase.auth.currentSession;
    // if (session == null) {
    //   return const UploadPostImageResult.failure('Not logged in');
    // }

    final response = await supabase.storage.from('posts').upload(params.path, params.file);
    if (response == "") {
      return const UploadPostImageResult.failure('Upload failed');
    }
    return UploadPostImageResult.success(response);
  }
}
