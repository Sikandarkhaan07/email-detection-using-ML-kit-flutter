// ignore_for_file: use_build_context_synchronously

import 'package:email_detection/core/components/dialog.dart';
import 'package:email_detection/ui/screens/email_screen/email_controller.dart';
import 'package:flutter/material.dart';

class EmailImageScreen extends StatefulWidget {
  const EmailImageScreen({super.key});

  @override
  State<EmailImageScreen> createState() => _EmailImageScreenState();
}

class _EmailImageScreenState extends State<EmailImageScreen> {
  final controller = EmailController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Picture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  width: size.width * 0.8,
                  height: size.height * 0.4,
                  child: Image.asset('assets/images/man.png'),
                ),
              ),
              SizedBox(
                height: 50,
                width: 400,
                child: ElevatedButton(
                    onPressed: () {
                      final controller = EmailController();
                      DialogUtility.showBottomSheet(
                          context: context,
                          fromCamera: () async {
                            await controller.takeImageFromCamera(context);
                          },
                          fromGallery: () async {
                            await controller.takeImageFromGallery(context);
                          });
                    },
                    child: const Text('TAKE PICTURE')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
