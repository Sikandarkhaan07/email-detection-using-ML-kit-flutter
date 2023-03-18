import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class TextDetectorPainter extends CustomPainter {
  TextDetectorPainter(this.absoluteImageSize, this.elements);

  final Size absoluteImageSize;
  final List<TextElement> elements;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 2.0;

    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    for (TextElement element in elements) {
      canvas.drawRect(
          Rect.fromLTRB(
              element.boundingBox.left * scaleX,
              element.boundingBox.top * scaleY,
              element.boundingBox.right * scaleX,
              element.boundingBox.bottom * scaleY),
          paint);
    }
  }

  @override
  bool shouldRepaint(TextDetectorPainter oldDelegate) {
    return true;
  }
}
