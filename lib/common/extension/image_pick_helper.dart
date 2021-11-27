import 'dart:io';

import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerHelper {
  ImagePickerHelper._();

  static Future getImage(ImageSource source) async {
    await Permission.storage.request();
    await Permission.camera.request();
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: source, imageQuality: 100, maxWidth: 1024);
    File rotatedImage =
    await FlutterExifRotation.rotateImage(path: pickedImage!.path);
    return rotatedImage.path;
  }
}