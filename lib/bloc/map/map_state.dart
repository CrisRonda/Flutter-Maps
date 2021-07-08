part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapIsLoaded;
  final bool enablePolylines;
  final bool enableFollowUser;
  final LatLng? positionCenterMap;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  MapState(
      {this.mapIsLoaded = false,
      this.enablePolylines = true,
      this.enableFollowUser = false,
      this.positionCenterMap,
      Map<String, Polyline>? polylines,
      Map<String, Marker>? markers})
      : this.polylines = polylines ?? new Map(),
        this.markers = markers ?? new Map();

  MapState copyWith(
          {bool? mapIsLoaded,
          bool? enablePolylines,
          bool? enableFollowUser,
          LatLng? positionCenterMap,
          Map<String, Polyline>? polyline,
          Map<String, Marker>? markers}) =>
      new MapState(
        mapIsLoaded: mapIsLoaded ?? this.mapIsLoaded,
        enablePolylines: enablePolylines ?? this.enablePolylines,
        polylines: polyline ?? this.polylines,
        enableFollowUser: enableFollowUser ?? this.enableFollowUser,
        positionCenterMap: positionCenterMap ?? this.positionCenterMap,
        markers: markers ?? this.markers,
      );
}
