part of 'user_location_bloc.dart';

@immutable
abstract class UserLocationEvent {}

class OnChangeLocation extends UserLocationEvent {
  final LatLng location;

  OnChangeLocation({required this.location});
}
