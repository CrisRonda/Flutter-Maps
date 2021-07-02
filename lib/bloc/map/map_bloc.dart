import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/themes/map_style.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  late GoogleMapController _mapController;

  initMap(GoogleMapController controller) {
    if (state.mapIsLoaded) {
      return;
    }
    this._mapController = controller;
    this._mapController.setMapStyle(jsonEncode(mapStyle));
    add(OnMapLoaded());
  }

  returnInitialLocation(LatLng location) {
      final cameraUpdate = CameraUpdate.newLatLng(location);
      this._mapController.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is OnMapLoaded) {
      print("Mapa listo");
      yield state.copyWith(mapIsLoaded: true);
    }
  }
}
