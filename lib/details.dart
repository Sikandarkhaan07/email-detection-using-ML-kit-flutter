// ignore_for_file: unused_field

import 'dart:async';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class DetailScreen extends StatefulWidget {
  final String imagePath;

  const DetailScreen({super.key, required this.imagePath});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late String _imagePath;
  late TextRecognizer _textDetector;
  Size? _imageSize;
  final List<TextElement> _elements = [];

  List<String>? _listEmailStrings;

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();
    final Image image = Image.file(imageFile);

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

  void _recognizeEmails() async {
    _getImageSize(File(_imagePath));
  }

  late final inputImage = InputImage.fromFilePath(_imagePath);
  late final text = _textDetector.processImage(inputImage);

  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
  late RegExp regEx = RegExp(pattern);

  List<String> emailStrings = [];

  @override
  void setState(VoidCallback fn) {
    _listEmailStrings = emailStrings;
    super.setState(fn);
  }
  // Finding and storing the text String(s) and the TextElement(s)

  @override
  void initState() {
    _imagePath = widget.imagePath;
    // Initializing the text detector
    _textDetector = GoogleMlKit.vision.textRecognizer();
    _recognizeEmails();
    super.initState();
  }

  @override
  void dispose() {
    // Disposing the text detector when not used anymore
    _textDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Details"),
      ),
      body: _imageSize != null
          ? Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  color: Colors.black,
                  child: AspectRatio(
                    aspectRatio: _imageSize!.aspectRatio,
                    child: Image.file(
                      File(_imagePath),
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
                            height: 60,
                            child: SingleChildScrollView(
                              child: _listEmailStrings != null
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: _listEmailStrings!.length,
                                      itemBuilder: (context, index) =>
                                          Text(_listEmailStrings![index]),
                                    )
                                  : Container(),
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
