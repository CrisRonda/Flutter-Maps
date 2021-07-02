import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'user_location_event.dart';
part 'user_location_state.dart';

class UserLocationBloc extends Bloc<UserLocationEvent, UserLocationState> {
  UserLocationBloc() : super(UserLocationState());

  late StreamSubscription<Position> _positionSusciption;
  startTracking() {
    this._positionSusciption = Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.high, distanceFilter: 20)
        .listen((position) {
      final newLocation = new LatLng(position.latitude, position.longitude);
      // print("##===> $newLocation");
      add(OnChangeLocation(location: newLocation));
    });
  }

  cancelTracking() {
    this._positionSusciption.cancel();
  }

  @override
  Stream<UserLocationState> mapEventToState(
    UserLocationEvent event,
  ) async* {
    if (event is OnChangeLocation) {
      yield state.copyWith(location: event.location,existLocation: true);
    }
  }
}
