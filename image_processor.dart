/*
Date: 2024.09.03
Producer: Se Jun Lim
Email: lsj1137jsl@gmail.com
ReadMe: 
This document is about image processing function.
Dependency documents:
https://api.flutter.dev/flutter/widgets/Image-class.html
https://pub.dev/packages/image_picker
*/

import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

final ImagePicker picker = ImagePicker();

// pick a image from gallery
Future<File?> pickImage() async {
  File? result;
  XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
  if (xFile != null) {
    result = File(xFile.path);
  }
  return result;
}

// pick multiple images from gallery
Future<List<File?>> pickMultiImage() async {
  List<File?> result = [];
  List<XFile?> xFiles = await picker.pickMultiImage();
  if (xFiles.isNotEmpty) {
    for (XFile? xf in xFiles) {
      result.add(File(xf!.path));
    }
  }
  return result;
}

// compressImage
Future<File> compressImage(File imageFile) async {
  final bytes = await imageFile.readAsBytes();
  img.Image image = img.decodeImage(bytes)!;

  img.Image resizedImage = img.copyResize(image, width: 1024);

  final compressedBytes = img.encodeJpg(resizedImage, quality: 85);

  final compressedImageFile = File(
      '${imageFile.path.substring(0, imageFile.path.length - 4)}_compressed.jpg')
    ..writeAsBytesSync(compressedBytes);

  return compressedImageFile;
}
