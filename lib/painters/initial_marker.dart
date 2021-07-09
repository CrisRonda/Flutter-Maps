part of "custom_markers.dart";


class InitialMarker extends CustomPainter {
  final double timeInMinutes;

  InitialMarker(this.timeInMinutes);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()..color = Colors.black;
    final double radius = 20;
    final double radiusSmallCircle = 7;

    // black circle
    canvas.drawCircle(Offset(radius, size.height - radius), radius, paint);

    // smallCircle
    paint.color = Colors.white;

    canvas.drawCircle(
        Offset(radius, size.height - radius), radiusSmallCircle, paint);

    // Shadow
    final Path path = new Path();
    path.moveTo(radius * 2, radius);
    path.lineTo(size.width - 10, radius);
    path.lineTo(size.width - 10, radius * 5);
    path.lineTo(radius * 2, radius * 5);

    canvas.drawShadow(path, Colors.black, 10, false);

    // white box 
    final whiteBox =
        Rect.fromLTWH(radius * 2, radius, size.width - radius * 3, radius * 4);
    canvas.drawRect(whiteBox, paint);

    paint.color = Colors.black;

    // white box

    final blackBox =
        Rect.fromLTWH(radius * 2, radius, radius * 3.5, radius * 4);
    canvas.drawRect(blackBox, paint);

    createText(
        canvas: canvas,
        text: "${timeInMinutes.toStringAsFixed(0)}",
        pX: radius * 2,
        pY: radius * 1.75,
        color: Colors.white,
        fontSize: 28);

    createText(
        canvas: canvas,
        text: "min",
        pX: radius * 2,
        pY: radius * 3.2,
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontSize: 28);

    createText(
        canvas: canvas,
        text: "Mi Ubicación",
        pX: radius * 6.5,
        pY: size.height / 3,
        color: Colors.black,
        fontWeight: FontWeight.w600,
        maxWidth: 130,
        fontSize: 18);

    // Ubicacion
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
