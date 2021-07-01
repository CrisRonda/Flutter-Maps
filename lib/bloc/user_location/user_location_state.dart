part of 'user_location_bloc.dart';

@immutable
class UserLocationState {
  final bool enableTracking;
  final bool existLocation;
  final LatLng? location;

  UserLocationState(
      {this.enableTracking = true, this.existLocation = false, this.location});

  UserLocationState copyWith({
    bool? enableTracking,
    bool? existLocation,
    LatLng? location,
  }) =>
      new UserLocationState(
          enableTracking: enableTracking ?? this.enableTracking,
          existLocation: existLocation ?? this.existLocation,
          location: location ?? this.location);

  @override
  String toString() {
    return "enableTracking: ${this.enableTracking} - existLocation: ${this.existLocation} - ${this.location.toString()} ";
  }
}
