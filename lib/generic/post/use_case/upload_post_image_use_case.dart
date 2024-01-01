import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/generic/post/model/upload_post_image_params.dart';
import 'package:superkauf/generic/post/model/upload_post_image_result.dart';
import 'package:superkauf/library/use_case.dart';

class UploadPostImageUseCase extends UseCase<UploadImageResult, UploadImageParams> {
  UploadPostImageUseCase();

  @override
  Future<UploadImageResult> call(params) async {
    try {
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

      final newPath = '${params.path}/$hash';

      final supabase = Supabase.instance.client;

      final response = await supabase.storage.from('posts').upload(newPath, File(result.path), fileOptions: const FileOptions(upsert: true));

      if (response == "") {
        return const UploadImageResult.failure('Upload failed');
      }
      return UploadImageResult.success(newPath);
    } catch (e) {
      return UploadImageResult.failure('Upload failed: $e');
    }
  }
}
