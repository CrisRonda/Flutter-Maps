part of 'widtgets.dart';

class CustomMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final searchLocationBloc = BlocProvider.of<SearchLocationBloc>(context);
    return Stack(
      children: [
        _backButton(searchLocationBloc),
        Center(
          child: Transform.translate(
              offset: Offset(0, -20),
              child: BounceInDown(
                from: 200,
                duration: Duration(seconds: 2),
                child: Icon(
                  Icons.location_on,
                  size: 40,
                  color: Theme.of(context).primaryColorDark,
                ),
              )),
        ),
        Positioned(
          bottom: 20,
          left: 40,
          child: FadeInUp(
            child: MaterialButton(
              minWidth: width - 120,
              color: Colors.black,
              onPressed: () => _getRoute(context, searchLocationBloc),
              splashColor: Colors.transparent,
              elevation: 0,
              shape: StadiumBorder(),
              child: Text(
                "Confirmar destino",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  Positioned _backButton(SearchLocationBloc searchLocationBloc) {
    return Positioned(
      child: FadeInLeft(
        child: CircleAvatar(
          maxRadius: 25,
          backgroundColor: Colors.black,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => searchLocationBloc.add(OnDisableSelectLocation()),
          ),
        ),
      ),
      top: 50,
      left: 16,
    );
  }

  _getRoute(BuildContext context, SearchLocationBloc searchLocationBloc) async {
    showAlert(
        context: context,
        title: "Espere por favor",
        content: "Estamos buscando la mejor ruta");
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final trafficService = TrafficService();
    final startLocation =
        BlocProvider.of<UserLocationBloc>(context).state.location;
    final endLocation = mapBloc.state.positionCenterMap;
    final trafficResponse =
        await trafficService.getRoute(startLocation, endLocation);
    if (trafficResponse == null) {
      Navigator.pop(context);
      showAlert(
          context: context,
          title: "Lo sentimos",
          content: "Ocurrio un error inesperado",
          actions: [
            CupertinoButton(
                child: Text('ok'), onPressed: () => Navigator.pop(context))
          ]);
      return;
    }
    final firstRoute = trafficResponse.routes[0];
    final distance = firstRoute.distance;
    final duration = firstRoute.duration;
    final decodePoints =
        this._decode(firstRoute.geometry, 6); //--> precision type polyline6
    final List<LatLng> polyline =
        decodePoints.map((point) => new LatLng(point[0], point[1])).toList();
    mapBloc.add(OnDrawRoute(
        polyline: polyline, distance: distance, duration: duration));
    Navigator.pop(context);
    searchLocationBloc.add(OnDisableSelectLocation());
  }

  List<List<double>> _decode(String str, int precision) {
    int index = 0,
        lat = 0,
        lng = 0,
        shift = 0,
        result = 0,
        byte,
        latitudeChange,
        longitudeChange,
        factor = pow(10, precision is int ? precision : 5).toInt();
    // ignore: omit_local_variable_types
    List<List<double>> coordinates = [];

    // Coordinates have variable length when encoded, so just keep
    // track of whether we've hit the end of the string. In each
    // loop iteration, a single coordinate is decoded.
    while (index < str.length) {
      // Reset shift, result, and byte
      byte = 0;
      shift = 0;
      result = 0;

      do {
        byte = str.codeUnitAt(index++) - 63;
        result |= (byte & 0x1f) << shift;
        shift += 5;
      } while (byte >= 0x20);

      latitudeChange = (((result & 1) == 1) ? ~(result >> 1) : (result >> 1));

      shift = result = 0;

      do {
        byte = str.codeUnitAt(index++) - 63;
        result |= (byte & 0x1f) << shift;
        shift += 5;
      } while (byte >= 0x20);

      longitudeChange = ((result & 1) == 1 ? ~(result >> 1) : (result >> 1));

      lat += latitudeChange;
      lng += longitudeChange;

      coordinates.add([lat / factor, lng / factor]);
    }
    return coordinates;
  }
}
