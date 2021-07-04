import 'package:flutter/material.dart';
import 'package:maps_app/models/search_location_result.dart';

class SearchLocation extends SearchDelegate<SearchLocationResult> {
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
    return Text("buildResults", style: TextStyle(color: Colors.red));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
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
                    enableSelectLocation: true, cancel: false));
          },
        )
      ],
    );
  }
}
