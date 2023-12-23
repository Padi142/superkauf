import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/generic/post/model/upload_post_image_result.dart';
import 'package:superkauf/library/use_case.dart';

class DeletePostImageUseCase extends UseCase<UploadImageResult, String> {
  DeletePostImageUseCase();

  @override
  Future<UploadImageResult> call(params) async {
    final supabase = Supabase.instance.client;

    // final session = supabase.auth.currentSession;
    // if (session == null) {
    //   return const UploadImageResult.failure('Not logged in');
    // }

    final response = await supabase.storage.from('posts').remove([params]);
    if (response.isEmpty) {
      return const UploadImageResult.failure('Upload failed');
    }
    return const UploadImageResult.success('');
  }
}
