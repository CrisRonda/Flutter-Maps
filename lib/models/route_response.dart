// To parse this JSON data, do
//
//     final routeResponse = routeResponseFromJson(jsonString);

import 'dart:convert';

RouteResponse routeResponseFromJson(String str) =>
    RouteResponse.fromJson(json.decode(str));

String routeResponseToJson(RouteResponse data) => json.encode(data.toJson());

class RouteResponse {
  RouteResponse({
    required this.routes,
    required this.waypoints,
    required this.code,
    required this.uuid,
  });

  List<Route> routes;
  List<Waypoint> waypoints;
  String code;
  String uuid;

  factory RouteResponse.fromJson(Map<String, dynamic> json) => RouteResponse(
        routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
        waypoints: List<Waypoint>.from(
            json["waypoints"].map((x) => Waypoint.fromJson(x))),
        code: json["code"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> toJson() => {
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
        "waypoints": List<dynamic>.from(waypoints.map((x) => x.toJson())),
        "code": code,
        "uuid": uuid,
      };
}

class Route {
  Route({
    required this.weightName,
    required this.weight,
    required this.duration,
    required this.distance,
    required this.legs,
    required this.geometry,
  });

  String weightName;
  double weight;
  double duration;
  double distance;
  List<Leg> legs;
  String geometry;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        weightName: json["weight_name"],
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        distance: json["distance"].toDouble(),
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
        geometry: json["geometry"],
      );

  Map<String, dynamic> toJson() => {
        "weight_name": weightName,
        "weight": weight,
        "duration": duration,
        "distance": distance,
        "legs": List<dynamic>.from(legs.map((x) => x.toJson())),
        "geometry": geometry,
      };
}

class Leg {
  Leg({
    required this.weight,
    required this.duration,
    required this.steps,
    required this.distance,
    required this.summary,
  });

  double weight;
  double duration;
  List<dynamic> steps;
  double distance;
  String summary;

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        steps: List<dynamic>.from(json["steps"].map((x) => x)),
        distance: json["distance"].toDouble(),
        summary: json["summary"],
      );

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "duration": duration,
        "steps": List<dynamic>.from(steps.map((x) => x)),
        "distance": distance,
        "summary": summary,
      };
}

class Waypoint {
  Waypoint({
    required this.distance,
    required this.name,
    required this.location,
  });

  double distance;
  String name;
  List<double> location;

  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
        distance: json["distance"].toDouble(),
        name: json["name"],
        location: List<double>.from(json["location"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "name": name,
        "location": List<dynamic>.from(location.map((x) => x)),
      };
}
