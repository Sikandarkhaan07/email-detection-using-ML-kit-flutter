// ignore_for_file: no_logic_in_create_state, unused_field, prefer_final_fields

import 'dart:developer';

import 'package:email_detection/painter.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';
import 'dart:async';

import 'api/api.dart';

class DetailScreen extends StatefulWidget {
  final String imagePath;
  const DetailScreen(this.imagePath, {super.key});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Size? _imageSize;
  List<TextElement> _elements = [];
  List<String> identifiedEmails = [];
  TextRecognizer recognizer = TextRecognizer();
  String recognizedText = "Loading ...";
  String mailAddress = "";
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
  late RegExp regEx = RegExp(pattern);

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();

    // Fetching image from path
    final Image image = Image.file(imageFile);

    // Retrieving its size
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;
    setState(() {
      _imageSize = imageSize;
    });
  }

  void initializeVision() async {
    final imageFile = File(widget.imagePath);

    await _getImageSize(imageFile);

    final inputImage = InputImage.fromFile(imageFile);
    final detectedText = await recognizer.processImage(inputImage);
    if (detectedText.text.isNotEmpty) {
      for (TextBlock block in detectedText.blocks) {
        for (TextLine line in block.lines) {
          // Checking if the line contains an email address
          if (regEx.hasMatch(line.text)) {
            identifiedEmails.add(line.text);
            for (TextElement element in line.elements) {
              _elements.add(element);
            }
          }
        }
      }
      if (mounted) {
        setState(() {
          identifiedEmails;
        });
      }
    }
  }

  @override
  void initState() {
    initializeVision();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('test........');
    APIs.getResponse();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Details"),
      ),
      body: _imageSize != null
          ? Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    width: double.maxFinite,
                    color: Colors.black,
                    child: CustomPaint(
                      foregroundPainter:
                          TextDetectorPainter(_imageSize!, _elements),
                      child: AspectRatio(
                        aspectRatio: _imageSize!.aspectRatio,
                        child: Image.file(
                          File(widget.imagePath),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Card(
                    elevation: 8,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "Identified emails",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            child: ListView.builder(
                              itemCount: identifiedEmails.length,
                              itemBuilder: (context, index) {
                                if (identifiedEmails.isNotEmpty) {
                                  return Text(identifiedEmails[index]);
                                } else {
                                  return const Center(
                                      child: Text('No email has been found'));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
