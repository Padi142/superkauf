import 'dart:io';

class UploadImageParams {
  final String path;
  final File file;

  UploadImageParams({
    required this.path,
    required this.file,
  });
}
