import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchLocationResult {
  final bool cancel;
  final bool enableSelectLocation;
  final LatLng? destination;
  final String nameDestination;
  final String description;

  SearchLocationResult(
      {required this.cancel,
      this.enableSelectLocation = false,
      this.destination,
      this.nameDestination = '',
      this.description = ''});
}
