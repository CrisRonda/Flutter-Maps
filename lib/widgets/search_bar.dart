part of 'widtgets.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _showAnimation = true;
  @override
  Widget build(BuildContext context) {
    final centerLocation =
        BlocProvider.of<UserLocationBloc>(context).state.location;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        width: width,
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(
              context: context,
              delegate: SearchLocation(centerLocation!),
            );
            _handleSearchLocationResult(context, result!);
          },
          child: _input(),
        ),
      ),
    );
  }

  Container _input() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      width: double.infinity,
      height: 56,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.pin_drop,
            color: Colors.white,
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            "Vamos ",
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          Visibility(
            visible: _showAnimation,
            child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  onFinished: () {
                    setState(() {
                      this._showAnimation = false;
                    });
                  },
                  pause: Duration(seconds: 1),
                  animatedTexts: [
                    RotateAnimatedText(
                      'a casa?',
                      duration: Duration(seconds: 2),
                    ),
                    RotateAnimatedText(
                      'a la tienda?',
                      duration: Duration(seconds: 2),
                    ),
                    RotateAnimatedText(
                      'donde un amigo?',
                      duration: Duration(seconds: 2),
                    ),
                  ],
                )),
          ),
          Visibility(
            visible: !this._showAnimation,
            child: FadeIn(
              duration: Duration(seconds: 2),
              child: Text(
                "a donde tu quieras!",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
                color: Colors.black45, blurRadius: 5, offset: Offset(0, 2))
          ]),
    );
  }

  _handleSearchLocationResult(
      BuildContext context, SearchLocationResult result) async {
    final searchLocationBloc = BlocProvider.of<SearchLocationBloc>(context);
    if (result.enableSelectLocation) {
      searchLocationBloc.add(OnEnableSelectLocation());
      return;
    }
    if (result.manual) {
      searchLocationBloc.add(OnDisableSelectLocation());
      return;
    }
    final trafficService = TrafficService();
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final initialPosition =
        BlocProvider.of<UserLocationBloc>(context).state.location;
    final destinationPosition = result.destination;
    final drivingTraffic =
        await trafficService.getRoute(initialPosition, destinationPosition);
    final routeGeometry = drivingTraffic.routes[0].geometry;
    final distance = drivingTraffic.routes[0].distance;
    final duration = drivingTraffic.routes[0].duration;
    // TODO: refactor
    final points = decodeLatLngFromString(routeGeometry, 6);
    final route = points.map((coord) => LatLng(coord[0], coord[1])).toList();
    mapBloc.add(
        OnDrawRoute(polyline: route, distance: distance, duration: duration));
  }
}
