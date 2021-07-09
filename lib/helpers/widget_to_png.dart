part of 'helpers.dart';

Future<BitmapDescriptor> getCustomMarkerImageMarker(double seconds) async {
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  final size = Size(350, 150);

  final initialMarker = new InitialMarker(seconds / 60);
  initialMarker.paint(canvas, size);
  final picture = await recorder
      .endRecording()
      .toImage(size.width.toInt(), size.height.toInt());
  final bytes = await picture.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
}

Future<BitmapDescriptor> getCustomMarkerDestinationImageMarker(String namePlace, double distanceInMeters ) async {
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  final size = Size(350, 150);

  final initialMarker = new DestinationMarker(namePlace, distanceInMeters);
  initialMarker.paint(canvas, size);
  final picture = await recorder
      .endRecording()
      .toImage(size.width.toInt(), size.height.toInt());
  final bytes = await picture.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
}
