// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../detail_screen/detail.dart';

class EmailImageScreen extends StatefulWidget {
  const EmailImageScreen({super.key});

  @override
  State<EmailImageScreen> createState() => _EmailImageScreenState();
}

class _EmailImageScreenState extends State<EmailImageScreen> {
  String? imagePath;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    log('building main.....');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Picture'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.check_box))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          imagePath == null
              ? SizedBox(
                  width: size.width * 0.8,
                  height: size.height * 0.4,
                  child: Image.asset('assets/images/man.png'),
                )
              : SizedBox(
                  width: size.width * 0.8,
                  height: size.height * 0.4,
                  child: Image.file(File(imagePath!)),
                ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.browse_gallery),
                    label: const Text("Gallery"),
                    onPressed: () async {
                      // Pick an image
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        log('Image path: ${image.path}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(image.path),
                          ),
                        );
                      } else {
                        log('Image path: null');
                      }
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt_rounded),
                    label: const Text("Camera"),
                    onPressed: () async {
                      // Capture a photo
                      final XFile? photo =
                          await picker.pickImage(source: ImageSource.camera);
                      if (photo != null) {
                        log('Image path: ${photo.path}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(photo.path),
                          ),
                        );
                      } else {
                        log('Image path: null');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
