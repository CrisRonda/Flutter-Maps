part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnMapLoaded extends MapEvent {}

class OnChangeLocationUser extends MapEvent {
  final LatLng newLocation;

  OnChangeLocationUser(this.newLocation);
}

class OnEnablePolyline extends MapEvent {}

class OnEnableFollowUser extends MapEvent {}

class OnMoveCamera extends MapEvent {
  final LatLng positionCenterMap;

  OnMoveCamera(this.positionCenterMap);
}

class OnDrawRoute extends MapEvent {
  final List<LatLng> polyline;
  final double distance;
  final double duration;

  OnDrawRoute(
      {required this.polyline, required this.distance, required this.duration});
}
