import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bloc/map/map_bloc.dart';
import 'package:maps_app/bloc/user_location/user_location_bloc.dart';
import 'package:maps_app/widgets/widtgets.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    BlocProvider.of<UserLocationBloc>(context).startTracking();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<UserLocationBloc>(context).cancelTracking()();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [ButtonCenterLocation()],
      ),
      body: BlocBuilder<UserLocationBloc, UserLocationState>(
        builder: (context, state) {
          return createMap(state);
        },
      ),
    );
  }

  Widget createMap(UserLocationState state) {
    if (!state.existLocation) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    final cameraPosition = CameraPosition(
        target: state.location ?? new LatLng(-0.2320513, -78.5015669),
        zoom: 15);

    final mapBloc = BlocProvider.of<MapBloc>(context);
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: mapBloc.initMap,
    );
  }
}
