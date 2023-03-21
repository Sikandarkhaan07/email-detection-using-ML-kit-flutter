// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/components/dialog.dart';
import '../../../core/routes/routes_name.dart';

class CnicController {
  String? name;
  String? cnicNumber;
  String? expiryDate;

  final ImagePicker _picker = ImagePicker();

  late ImageSource source;

  TextRecognizer recognizer = TextRecognizer();

  bool isNameSelected = false;
  bool isExpirySelected = false;

  Future<Map<String, dynamic>> scanImage(
      {required ImageSource imageSource}) async {
    source = imageSource;
    XFile? image = await _picker.pickImage(source: imageSource);

    if (image != null) {
      final inputImage = InputImage.fromFilePath(image.path);
      final detectedText = await recognizer.processImage(inputImage);
      if (detectedText.text.isNotEmpty) {
        for (TextBlock block in detectedText.blocks) {
          for (TextLine line in block.lines) {
            //the consecative two if statements below are for detecting NAME
            if (isNameSelected) {
              name = line.text;
              isNameSelected = false;
            }
            if (line.text == 'Name') {
              isNameSelected = true;
            }
            //the consecative two if statements below are for detecting EXPIRY DATE
            if (isExpirySelected) {
              expiryDate = line.text;
              isExpirySelected = false;
            }
            if (line.text == 'Date of Expiry') {
              isExpirySelected = true;
            }
            //loop for detecting CNIC number
            for (TextElement element in line.elements) {
              if (element.text.length == 15) {
                if (element.text.contains('-', 5) &&
                    element.text.contains('-', 13)) {
                  cnicNumber = element.text;
                }
              }
            }
          }
        }
        log('\nName: $name \nCNIC: $cnicNumber \n Expiry: $expiryDate');

        return {
          'name': name,
          'cnicNumber': cnicNumber,
          'expiryDate': expiryDate,
        };
      }
    }
    return {};
  }

  static Future<void> scanCnic(
      ImageSource imageSource, BuildContext context) async {
    DialogUtility.showProgressBar(context);
    final cnicData = await CnicController().scanImage(imageSource: imageSource);
    if (cnicData.isNotEmpty) {
      Navigator.popAndPushNamed(
        context,
        RoutesName.cnicDetailsScreen,
        arguments: cnicData,
      );
    } else {
      Navigator.pop(context);
    }
  }
}
