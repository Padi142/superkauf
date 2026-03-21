import 'dart:io';

class UploadImageParams {
  final int userId;
  final String path;
  final File file;

  UploadImageParams({
    required this.userId,
    required this.path,
    required this.file,
  });
}
