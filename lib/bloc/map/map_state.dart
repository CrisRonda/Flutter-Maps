part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapIsLoaded;

  MapState({this.mapIsLoaded = false});

  MapState copyWith({bool? mapIsLoaded}) =>
      new MapState(mapIsLoaded: mapIsLoaded ?? this.mapIsLoaded);
}
