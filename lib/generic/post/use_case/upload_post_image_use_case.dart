import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/generic/post/model/upload_post_image_params.dart';
import 'package:superkauf/generic/post/model/upload_post_image_result.dart';
import 'package:superkauf/library/use_case.dart';

class UploadPostImageUseCase
    extends UseCase<UploadImageResult, UploadImageParams> {
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
        return const UploadImageResult.failure(
            'Upload failed, could not compress image');
      }

      final hash = md5.convert(await result.readAsBytes());

      final newPath = '${params.path}/$hash';

      final supabase = Supabase.instance.client;

      final response = await supabase.storage.from('posts').upload(
          newPath, File(result.path),
          fileOptions: const FileOptions(upsert: true));

      if (response == "") {
        return const UploadImageResult.failure('Upload failed');
      }
      return UploadImageResult.success(
          supabase.storage.from('posts').getPublicUrl(
                newPath,
              ));
    } catch (e) {
      return UploadImageResult.failure('Upload failed: $e');
    }
  }
}

class UploadS3PostImageUseCase
    extends UseCase<UploadImageResult, UploadImageParams> {
  UploadS3PostImageUseCase();

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

      /// Load the credentials from the JSON key file.
      String data =
          await rootBundle.loadString('assets/superkauf-account.json');

      final credentials = ServiceAccountCredentials.fromJson(data);

      final httpClient = await clientViaServiceAccount(
          credentials, [StorageApi.devstorageReadWriteScope]);

      final storage = StorageApi(httpClient);

      final hash = md5.convert(await result.readAsBytes());

      final newPath = 'posts/${params.path}/$hash.webp';

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

class UploadCloudinaryPostImage
    extends UseCase<UploadImageResult, UploadImageParams> {
  UploadCloudinaryPostImage();

  @override
  Future<UploadImageResult> call(params) async {
    final cloudinary =
        CloudinaryPublic('padikulisekuwu', 'superkauf-posts', cache: false);

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

      final hash = md5.convert(await result.readAsBytes());

      final newPath = 'posts/${params.path}/$hash.webp';

      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(result.path,
            resourceType: CloudinaryResourceType.Image,
            publicId: hash.toString(),
            identifier: hash.toString(),
            folder: 'posts/${params.path}'),
      );

      return UploadImageResult.success(response.secureUrl);
    } catch (e) {
      return UploadImageResult.failure('Upload failed: $e');
    }
  }
}
