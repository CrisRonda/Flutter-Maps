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
    final endLocation = mapBloc.state.positionCenterMap!;
    final trafficResponse =
        await trafficService.getRoute(startLocation, endLocation);
    if (trafficResponse.routes.length == 0) {
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
    final reverseQueryDestination =
        await trafficService.getNameByCoordsLocation(endLocation);

    final firstRoute = trafficResponse.routes[0];
    final distance = firstRoute.distance;
    final duration = firstRoute.duration;
    final nameDestinarion =
        reverseQueryDestination.features[0].text ?? "Destino";
    final decodePoints = decodeLatLngFromString(
        firstRoute.geometry, 6); //--> precision type polyline6
    final List<LatLng> polyline =
        decodePoints.map((point) => new LatLng(point[0], point[1])).toList();
    mapBloc.add(OnDrawRoute(
        polyline: polyline,
        distance: distance,
        duration: duration,
        nameDestination: nameDestinarion));
    Navigator.pop(context);
    searchLocationBloc.add(OnDisableSelectLocation());
  }
}
