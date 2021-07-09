  import 'package:flutter/material.dart';

void createText(
      {required Canvas canvas,
      required String text,
      double pX = 0,
      double pY = 0,
      Color color = Colors.white,
      double fontSize = 20,
      double maxWidth = 70,
      FontWeight fontWeight = FontWeight.w500}) {
    final textSpan = new TextSpan(
      style:
          TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
      text: text,
    );
    final textPainter = TextPainter(
        text: textSpan,
        maxLines: 2,
        ellipsis: "...",
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(
        minWidth: 70,
        maxWidth: maxWidth,
      );
    textPainter.paint(canvas, Offset(pX, pY));
  }
