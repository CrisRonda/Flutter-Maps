part of 'search_location_bloc.dart';

@immutable
class SearchLocationState {
  final bool enableSelectLocation;

  SearchLocationState({this.enableSelectLocation = false});
  SearchLocationState copyWith({bool? enableSelectLocation}) =>
      new SearchLocationState(
          enableSelectLocation:
              enableSelectLocation ?? this.enableSelectLocation);
}
