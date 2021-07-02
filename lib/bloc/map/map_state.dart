part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapIsLoaded;
  final bool enablePolylines;
  final bool enableFollowUser;
  final LatLng? positionCenterMap;
  final Map<String, Polyline> polylines;

  MapState(
      {this.mapIsLoaded = false,
      this.enablePolylines = true,
      this.enableFollowUser = false,
      this.positionCenterMap,
      Map<String, Polyline>? polylines})
      : this.polylines = polylines ?? new Map();

  MapState copyWith(
          {bool? mapIsLoaded,
          bool? enablePolylines,
          bool? enableFollowUser,
          LatLng? positionCenterMap,
          Map<String, Polyline>? polyline}) =>
      new MapState(
        mapIsLoaded: mapIsLoaded ?? this.mapIsLoaded,
        enablePolylines: enablePolylines ?? this.enablePolylines,
        polylines: polyline ?? this.polylines,
        enableFollowUser: enableFollowUser ?? this.enableFollowUser,
        positionCenterMap: positionCenterMap ?? this.positionCenterMap,
      );
}
