part of 'search_location_bloc.dart';

@immutable
abstract class SearchLocationEvent {}

class OnEnableSelectLocation extends SearchLocationEvent {}

class OnDisableSelectLocation extends SearchLocationEvent {}

class OnAddRecentLocation extends SearchLocationEvent {
  final SearchLocationResult newLocation;

  OnAddRecentLocation(this.newLocation);
}
