import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../library/use_case.dart';

class PickImageUseCase extends UnitUseCase<File?> {
  PickImageUseCase();

  @override
  Future<File?> call() async {
    final ImagePicker picker = ImagePicker();
    final xfile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
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
