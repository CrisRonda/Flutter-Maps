import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/helpers/debouncer.dart';
import 'package:maps_app/models/geocoding_response.dart';
import 'package:maps_app/models/reverse_geocoding_response.dart';
import 'package:maps_app/models/route_response.dart';

class TrafficService {
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();
  final _baseURLDirections = 'https://api.mapbox.com/directions/v5';
  final _baseURLGeocoding = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 700));
  final StreamController<GeocodingResponse> _suggestionStreamController =
      new StreamController<GeocodingResponse>.broadcast();

  Stream<GeocodingResponse> get suggestionStream =>
      this._suggestionStreamController.stream;

  final _accessToken =
      'pk.eyJ1IjoiY3Jpc3JvbmRhIiwiYSI6ImNrcW16MWV6eDBsZGkybm5ub3Bqcng5czgifQ.7_w-2gpW4xJ0Dgkat41s2g';

  Future<RouteResponse> getRoute(
      LatLng? startLocation, LatLng? endLocation) async {
    try {
      if (startLocation == null || endLocation == null) {
        return RouteResponse(routes: [], code: '', uuid: '', waypoints: []);
      }
      final coordsString =
          "${startLocation.longitude},${startLocation.latitude};${endLocation.longitude},${endLocation.latitude}";
      final url = '${this._baseURLDirections}/mapbox/driving/$coordsString';
      final resp = await this._dio.get(url, queryParameters: {
        'alternatives': true,
        'geometries': "polyline6",
        "steps": false,
        "language": "es",
        "access_token": this._accessToken,
      });
      final RouteResponse data = RouteResponse.fromJson(resp.data);

      return data;
    } catch (e) {
      return RouteResponse(routes: [], code: '', uuid: '', waypoints: []);
    }
  }

  Future<GeocodingResponse> getLocationsByNameLocation(
      String nameLocation, LatLng position) async {
    try {
      if (nameLocation.isEmpty) throw Error();
      final url = "${this._baseURLGeocoding}/$nameLocation.json";
      final resp = await this._dio.get(url, queryParameters: {
        "autocomplete": true,
        'proximity': "${position.longitude},${position.latitude}",
        "language": "es",
        "access_token": this._accessToken,
      });
      final result = geocodingResponseFromJson(resp.data);
      return result;
    } catch (e) {
      return GeocodingResponse();
    }
  }

  Future<ReverseGeocodingResponse> getNameByCoordsLocation(
      LatLng position) async {
    try {
      final url =
          "${this._baseURLGeocoding}/${position.longitude},${position.latitude}.json";
      final resp = await this._dio.get(url, queryParameters: {
        "language": "es",
        "access_token": this._accessToken,
      });
      final result = reverseGeocodingResponseFromJson(resp.data);
      return result;
    } catch (e) {
      return ReverseGeocodingResponse();
    }
  }

  void getSuggestionsByQuery(String locationName, LatLng proximityLocation) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      print("onValue =---> $value");
      final result =
          await this.getLocationsByNameLocation(value, proximityLocation);
      this._suggestionStreamController.add(result);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = locationName;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel());
  }

  void dispose() {
    _suggestionStreamController.close();
  }
}
