import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/geocoding_response.dart';
import 'package:maps_app/models/search_location_result.dart';
import 'package:maps_app/services/traffic_services.dart';

class SearchLocation extends SearchDelegate<SearchLocationResult> {
  final TrafficService _trafficService;
  final LatLng centerLocation;
  final List<SearchLocationResult> recentLocations;

  SearchLocation(this.centerLocation, this.recentLocations)
      : this._trafficService = new TrafficService();
  @override
  String get searchFieldLabel => "Busca un lugar";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.white54),
          border: InputBorder.none),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white)),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => this.query = '',
          icon: Icon(
            Icons.clear_rounded,
          ))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () =>
            this.close(context, new SearchLocationResult(cancel: true)),
        icon: Icon(
          Icons.arrow_back,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _builderListResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.length == 0) {
      return ListView(
        children: [
          ListTile(
            leading: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            title: Text(
              "Localizar en el mapa",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              this.close(
                  context,
                  new SearchLocationResult(
                      enableSelectLocation: true, manual: true));
            },
          ),
          ...this
              .recentLocations
              .map((location) => ListTile(
                    leading: Icon(
                      Icons.history,
                      color: Colors.white,
                    ),
                    title: Text(
                      location.nameDestination,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      location.description,
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      this.close(
                          context,
                          SearchLocationResult(
                              cancel: false,
                              description: location.description,
                              nameDestination: location.nameDestination,
                              destination: location.destination));
                    },
                  ))
              .toList(),
        ],
      );
    }
    return _builderListResults();
  }

  Widget _builderListResults() {
    this
        ._trafficService
        .getSuggestionsByQuery(this.query.trim(), this.centerLocation);

    return StreamBuilder(
      stream: this._trafficService.suggestionStream,
      builder:
          (BuildContext context, AsyncSnapshot<GeocodingResponse?> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.features!.length == 0) {
          return Center(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Container(
                  child: Row(
                children: [
                  Icon(
                    Icons.not_interested_rounded,
                    size: Theme.of(context).textTheme.headline1?.fontSize,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Sin resultados",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              )),
            ),
          );
        }
        final locations = snapshot.data!.features!;
        return ListView.separated(
          itemCount: locations.length,
          itemBuilder: (_, i) {
            final location = locations[i];
            return ListTile(
              leading: Icon(
                Icons.place,
                color: Colors.white,
              ),
              title: Text(
                location.text!,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              subtitle: Text(location.placeName!),
              onTap: () {
                final position = location.center!;
                this.close(
                    context,
                    SearchLocationResult(
                        cancel: false,
                        description: location.text!,
                        nameDestination: location.text!,
                        destination: LatLng(position[1], position[0])));
              },
            );
          },
          separatorBuilder: (_, i) => Divider(),
        );
      },
    );
  }
}
