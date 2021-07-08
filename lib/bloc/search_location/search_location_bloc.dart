import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:maps_app/models/search_location_result.dart';
import 'package:meta/meta.dart';

part 'search_location_event.dart';
part 'search_location_state.dart';

class SearchLocationBloc
    extends Bloc<SearchLocationEvent, SearchLocationState> {
  SearchLocationBloc() : super(SearchLocationState());

  @override
  Stream<SearchLocationState> mapEventToState(
    SearchLocationEvent event,
  ) async* {
    if (event is OnEnableSelectLocation) {
      yield state.copyWith(enableSelectLocation: true);
    }
    if (event is OnDisableSelectLocation) {
      yield state.copyWith(enableSelectLocation: false);
    }

    if (event is OnAddRecentLocation) {
      final existLocation = state.recentLocations.where((location) =>
          location.nameDestination == event.newLocation.nameDestination).length;
      if (existLocation == 0) {
        yield state.copyWith(
            recentLocations:
                [...state.recentLocations, event.newLocation].toSet().toList());
      }
    }
  }
}
