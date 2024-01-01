import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../library/use_case.dart';

class PickImageCameraUseCase extends UnitUseCase<File?> {
  PickImageCameraUseCase();

  @override
  Future<File?> call() async {
    final ImagePicker picker = ImagePicker();
    final xfile = await picker.pickImage(source: ImageSource.camera, imageQuality: 60);
    if (xfile == null) {
      return null;
    }

    final file = File(xfile.path);
    if (file.existsSync()) {
      return file;
    }
    return null;
  }
}
