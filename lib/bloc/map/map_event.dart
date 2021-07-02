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
