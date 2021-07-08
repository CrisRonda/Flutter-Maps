part of 'search_location_bloc.dart';

@immutable
class SearchLocationState {
  final bool enableSelectLocation;
  final List<SearchLocationResult> recentLocations;

  SearchLocationState(
      {this.enableSelectLocation = false,
      List<SearchLocationResult> recentLocations = const []})
      : this.recentLocations = recentLocations;
  SearchLocationState copyWith(
          {bool? enableSelectLocation,
          List<SearchLocationResult>? recentLocations}) =>
      new SearchLocationState(
        enableSelectLocation: enableSelectLocation ?? this.enableSelectLocation,
        recentLocations: recentLocations ?? this.recentLocations,
      );
}
