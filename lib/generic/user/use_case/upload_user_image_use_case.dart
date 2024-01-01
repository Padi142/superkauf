import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/generic/post/model/upload_post_image_params.dart';
import 'package:superkauf/generic/post/model/upload_post_image_result.dart';
import 'package:superkauf/library/use_case.dart';

class UploadUserImageUseCase extends UseCase<UploadImageResult, UploadImageParams> {
  UploadUserImageUseCase();

  @override
  Future<UploadImageResult> call(params) async {
    final imageUri = Uri.parse(params.file.path);
    final String outputUri = imageUri.resolve('./output.webp').toString();

    var result = await FlutterImageCompress.compressAndGetFile(
      params.file.absolute.path,
      outputUri,
      quality: 50,
      format: CompressFormat.webp,
    );

    if (result == null) {
      return const UploadImageResult.failure('Upload failed, could not compress image');
    }

    final hash = md5.convert(await result.readAsBytes());

    final supabase = Supabase.instance.client;

    final response = await supabase.storage.from('profile_pics').upload(params.path, File(result.path), fileOptions: const FileOptions(upsert: true));
    if (response == "") {
      return const UploadImageResult.failure('Upload failed');
    }
    return UploadImageResult.success(response);
  }
}
