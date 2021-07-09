part of "custom_markers.dart";

class DestinationMarker extends CustomPainter {
  final String namePlace;
  final double distanceInMeters;

  DestinationMarker(this.namePlace, this.distanceInMeters);
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
    path.moveTo(0, radius);
    path.lineTo(size.width - 10, radius);
    path.lineTo(size.width - 10, radius * 5);
    path.lineTo(0, radius * 5);

    canvas.drawShadow(path, Colors.black, 10, false);

    // white box
    final whiteBox =
        Rect.fromLTWH(0, radius, size.width - radius / 2, radius * 4);
    canvas.drawRect(whiteBox, paint);

    paint.color = Colors.black;

    // white box

    final blackBox = Rect.fromLTWH(0, radius, radius * 3.5, radius * 4);
    canvas.drawRect(blackBox, paint);

    createText(
        canvas: canvas,
        text: "${(distanceInMeters / 1000).toStringAsFixed(1)}",
        pX: 0,
        pY: radius * 1.75,
        color: Colors.white,
        fontSize: 20);

    createText(
        canvas: canvas,
        text: "Km",
        pX: 0,
        pY: radius * 3.2,
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontSize: 28);

    createText(
        canvas: canvas,
        text: "$namePlace",
        pX: radius * 4,
        pY: size.height / 3.5,
        color: Colors.black,
        fontWeight: FontWeight.w600,
        maxWidth: 250,
        fontSize: 18);

    // Ubicacion
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
