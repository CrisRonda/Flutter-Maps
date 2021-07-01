import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/user_location/user_location_bloc.dart';

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
      body: BlocBuilder<UserLocationBloc, UserLocationState>(
        builder: (context, state) {
          return Center(
            child: createMap(state)
          );
        },
      ),
    );
  }

  Widget createMap(UserLocationState state) {
    if (state.existLocation) {
      return Center(
        child: Text("loading"),
      );
    }

    return Text("data");
  }
}
