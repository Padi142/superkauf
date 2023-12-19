import 'dart:io';

class UploadPostImageParams {
  final String path;
  final File file;

  UploadPostImageParams({
    required this.path,
    required this.file,
  });
}
