import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchLocationResult {
  final bool cancel;
  final bool enableSelectLocation;
  final bool manual;
  final LatLng? destination;
  final String nameDestination;
  final String description;

  SearchLocationResult(
      {this.cancel = false,
      this.enableSelectLocation = false,
      this.manual = false,
      this.destination,
      this.nameDestination = '',
      this.description = ''});
}
