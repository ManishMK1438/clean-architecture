import 'dart:io';

import 'package:clean_art/core/exports.dart';

class PickImage {
  final _picker = ImagePicker();
  Future<File?> pickImage() async {
    try {
      final xFile = await _picker.pickImage(source: ImageSource.gallery);
      if (xFile != null) {
        return File(xFile.path);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
