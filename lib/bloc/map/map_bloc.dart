import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/themes/map_style.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  late GoogleMapController _mapController;
  Polyline _routeLine = new Polyline(
      polylineId: PolylineId(
        'myroute',
      ),
      width: 2,
      color: Colors.transparent);
  Polyline _routeToDestination = new Polyline(
      polylineId: PolylineId(
        'routeToDestination',
      ),
      width: 2,
      color: Colors.green);
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
      yield state.copyWith(mapIsLoaded: true);
    }
    if (event is OnChangeLocationUser) {
      yield* _onChangeLocationUser(event);
    }

    if (event is OnEnablePolyline) {
      yield* _onEnablePolyline(event);
    }

    if (event is OnEnableFollowUser) {
      yield state.copyWith(enableFollowUser: !state.enableFollowUser);
    }

    if (event is OnMoveCamera) {
      yield state.copyWith(positionCenterMap: event.positionCenterMap);
    }

    if (event is OnDrawRoute) {
      yield* _onDrawRoute(event);
    }
  }

  Stream<MapState> _onChangeLocationUser(OnChangeLocationUser event) async* {
    if (state.enableFollowUser) {
      await _mapController
          .animateCamera(CameraUpdate.newLatLng(event.newLocation));
    }
    List<LatLng> points = [...this._routeLine.points, event.newLocation];
    this._routeLine = this._routeLine.copyWith(pointsParam: points);
    final currentPolylines = state.polylines;
    currentPolylines['myroute'] = this._routeLine;

    yield state.copyWith(polyline: currentPolylines);
  }

  Stream<MapState> _onEnablePolyline(OnEnablePolyline event) async* {
    print('state ===>${state.enablePolylines}');
    if (state.enablePolylines) {
      this._routeLine =
          this._routeLine.copyWith(colorParam: Colors.blue.shade500);
    } else {
      this._routeLine =
          this._routeLine.copyWith(colorParam: Colors.transparent);
    }
    final currentPolylines = state.polylines;
    currentPolylines['myroute'] = this._routeLine;

    yield state.copyWith(
        polyline: currentPolylines, enablePolylines: !state.enablePolylines);
  }

  Stream<MapState> _onDrawRoute(OnDrawRoute event) async* {
    this._routeToDestination =
        this._routeToDestination.copyWith(pointsParam: event.polyline);
    final currentPolylines = state.polylines;
    currentPolylines['routeToDestination'] = this._routeToDestination;
    final initialMarker = new Marker(
        markerId: MarkerId("initialPosition"), position: event.polyline[0]);
    final endMarker = new Marker(
        markerId: MarkerId("endPosition"),
        position: event.polyline[event.polyline.length - 1]);

    final updatedMarkers = {...state.markers};
    updatedMarkers["initialMarker"] = initialMarker;
    updatedMarkers["endMarker"] = endMarker;

    yield state.copyWith(polyline: currentPolylines, markers: updatedMarkers);
  }
}
