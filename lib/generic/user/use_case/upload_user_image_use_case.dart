import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/generic/post/model/upload_post_image_params.dart';
import 'package:superkauf/generic/post/model/upload_post_image_result.dart';
import 'package:superkauf/library/use_case.dart';

class UploadUserImageUseCase
    extends UseCase<UploadImageResult, UploadImageParams> {
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
      return const UploadImageResult.failure(
          'Upload failed, could not compress image');
    }

    final supabase = Supabase.instance.client;

    final response = await supabase.storage.from('profile_pics').upload(
        params.path, File(result.path),
        fileOptions: const FileOptions(upsert: true));

    if (response == "") {
      return const UploadImageResult.failure('Upload failed');
    }

    final imageLink =
        supabase.storage.from('profile_pics').getPublicUrl(params.path);
    return UploadImageResult.success(imageLink);
  }
}

class UploadUserS3ImageUseCase
    extends UseCase<UploadImageResult, UploadImageParams> {
  UploadUserS3ImageUseCase();

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
        return const UploadImageResult.failure(
            'Upload failed, could not compress image');
      }

      String data =
          await rootBundle.loadString('assets/superkauf-account.json');

      final credentials = ServiceAccountCredentials.fromJson(data);

      final httpClient = await clientViaServiceAccount(
          credentials, [StorageApi.devstorageReadWriteScope]);

      final storage = StorageApi(httpClient);

      final newPath = 'profile_pics/${params.path}.webp';

      final fileContent = await params.file.readAsBytes();

      final bucketObject = Object(name: newPath);

      final resp = await storage.objects.insert(
        bucketObject,
        'superkauf',
        uploadMedia: Media(
          Stream<List<int>>.fromIterable([fileContent]),
          fileContent.length,
          contentType: 'image/webp',
        ),
      );

      if (resp.mediaLink != null) {
        return UploadImageResult.success(resp.mediaLink!);
      }
      return const UploadImageResult.failure('Upload failed');
    } catch (e) {
      return UploadImageResult.failure('Upload failed: $e');
    }
  }
}
