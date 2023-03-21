// ignore_for_file: use_build_context_synchronously

import 'package:email_detection/ui/screens/cnic_screen.dart/cnic_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/components/colors.dart';
import '../../../core/components/dialog.dart';

class CnicScreen extends StatefulWidget {
  const CnicScreen({super.key});

  @override
  State<CnicScreen> createState() => _CnicScreenState();
}

class _CnicScreenState extends State<CnicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CNIC'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Scan Your CNIC',
                style: TextStyle(
                    color: Color(kDarkGreyColor),
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 50,
            ),
            Expanded(child: Image.asset('assets/images/cnic.png')),
            SizedBox(
              height: 50,
              width: 400,
              child: ElevatedButton(
                  onPressed: () {
                    /// this is the custom dialog that takes 2 arguments "Camera" and "Gallery"
                    DialogUtility.showBottomSheet(
                        context: context,
                        fromCamera: () {
                          CnicController.scanCnic(ImageSource.camera, context);
                        },
                        fromGallery: () {
                          CnicController.scanCnic(ImageSource.gallery, context);
                        });
                  },
                  child: const Text('TAKE PICTURE')),
            ),
          ],
        ),
      ),
    );
  }
}
