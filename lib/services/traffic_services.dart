import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/route_response.dart';

class TrafficService {
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();
  final baseURL = 'https://api.mapbox.com/directions/v5';
  final _accessToken =
      'pk.eyJ1IjoiY3Jpc3JvbmRhIiwiYSI6ImNrcW16MWV6eDBsZGkybm5ub3Bqcng5czgifQ.7_w-2gpW4xJ0Dgkat41s2g';

  Future<RouteResponse?> getRoute(
      LatLng? startLocation, LatLng? endLocation) async {
    try {
      if (startLocation == null || endLocation == null) {
        return null;
      }
      final coordsString =
          "${startLocation.longitude},${startLocation.latitude};${endLocation.longitude},${endLocation.latitude}";
      final url = '${this.baseURL}/mapbox/driving/$coordsString';
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
      return null;
    }
  }
}
