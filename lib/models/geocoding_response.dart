import 'dart:convert';

GeocodingResponse geocodingResponseFromJson(String str) =>
    GeocodingResponse.fromJson(json.decode(str));

String geocodingResponseToJson(GeocodingResponse data) =>
    json.encode(data.toJson());

class GeocodingResponse {
  GeocodingResponse({
    this.type='',
    this.query = const [],
    this.features = const [],
    this.attribution='',
  });

  String? type;
  List<String>? query;
  List<Feature>? features;
  String? attribution;

  factory GeocodingResponse.fromJson(Map<String, dynamic> json) =>
      GeocodingResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)) ,
        features: List<Feature>.from(
                json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query!.map((x) => x)),
        "features": List<dynamic>.from(features!.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  Feature({
    this.id,
    this.type,
    this.placeType = const [],
    this.relevance,
    this.text,
    this.placeName,
    this.center = const [],
  });

  String? id;
  String? type;
  List<String>? placeType;
  int? relevance;
  String? text;
  String? placeName;
  List<double>? center;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"] ?? null,
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"],
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType!.map((x) => x)),
        "relevance": relevance,
        "text": text,
        "place_name": placeName,
        "center": List<dynamic>.from(center!.map((x) => x)),
      };
}
