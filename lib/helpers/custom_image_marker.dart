part of 'helpers.dart';

Future<BitmapDescriptor> getAssetImageMarker() async {
  final icon = BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        devicePixelRatio: 2.5,
      ),
      'assets/marker.png');
  return icon;
}

Future<BitmapDescriptor> getNetworkImageMarker() async {
  final resp = await Dio().get(
      "https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png",
      options: Options(responseType: ResponseType.bytes));
  final byte = resp.data;
  final imageCodec =
      await instantiateImageCodec(byte, targetHeight: 156, targetWidth: 156);
  final frame = await imageCodec.getNextFrame();
  final data = await frame.image.toByteData(format: ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}
