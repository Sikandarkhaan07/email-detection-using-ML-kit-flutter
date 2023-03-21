// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/routes/routes_name.dart';

class EmailController {
  final ImagePicker picker = ImagePicker();

  Future<void> takeImageFromGallery(BuildContext context) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Navigator.pushNamed(context, RoutesName.emaildetailScreen,
          arguments: image.path);
    }
  }

  Future<void> takeImageFromCamera(BuildContext context) async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      Navigator.pushNamed(context, RoutesName.emaildetailScreen,
          arguments: photo.path);
    }
  }
}
