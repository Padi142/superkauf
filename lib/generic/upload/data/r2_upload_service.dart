import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/generic/post/model/upload_post_image_params.dart';
import 'package:superkauf/generic/post/model/upload_post_image_result.dart';
import 'package:superkauf/generic/upload/model/presigned_upload_data.dart';

class R2UploadService {
  final Dio dio;

  R2UploadService({
    required this.dio,
  });

  Future<UploadImageResult> uploadImage({
    required UploadImageParams params,
    required String bucket,
  }) async {
    try {
      final imageUri = Uri.parse(params.file.path);
      final outputUri = imageUri.resolve('./output.webp').toString();

      final compressed = await FlutterImageCompress.compressAndGetFile(
        params.file.absolute.path,
        outputUri,
        quality: 50,
        format: CompressFormat.webp,
      );

      if (compressed == null) {
        return const UploadImageResult.failure(
            'Upload failed, could not compress image');
      }

      final fileBytes = await compressed.readAsBytes();
      final token =
          Supabase.instance.client.auth.currentSession?.accessToken ?? '';

      if (token.isEmpty) {
        return const UploadImageResult.failure(
            'Upload failed: missing auth session');
      }

      final presignResponse = await dio.post<Map<String, dynamic>>(
        '/upload/presign',
        data: {
          'userId': params.userId,
          'bucket': bucket,
          'path': params.path,
          'contentType': 'image/webp',
        },
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      final uploadData = PresignedUploadData.fromJson(presignResponse.data!);

      await dio.put<void>(
        uploadData.uploadUrl,
        data: Stream<List<int>>.fromIterable([fileBytes]),
        options: Options(
          contentType: 'image/webp',
          headers: {
            HttpHeaders.contentLengthHeader: fileBytes.length,
          },
        ),
      );

      return UploadImageResult.success(uploadData.publicUrl);
    } catch (e) {
      return UploadImageResult.failure('Upload failed: $e');
    }
  }
}
