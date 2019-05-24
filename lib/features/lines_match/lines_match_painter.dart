import 'package:flutter/material.dart';

class LinesMatchPainter extends CustomPainter {
  Offset offsetA;
  Offset offsetB;
  Offset offsetC;
  Offset offsetD;

  LinesMatchPainter.empty();

  LinesMatchPainter({this.offsetA, this.offsetB, this.offsetC, this.offsetD});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..color = Colors.yellow[800];

    if (offsetA != null && offsetB != null) {
      canvas.drawLine(offsetA, offsetB, paint);
    }

    if (offsetB != null && offsetC != null) {
      canvas.drawLine(offsetB, offsetC, paint);
    }

    if (offsetC != null && offsetD != null) {
      canvas.drawLine(offsetC, offsetD, paint);
    }

//    canvas.drawPaint(paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
