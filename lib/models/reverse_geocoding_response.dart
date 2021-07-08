// To parse this JSON data, do
//
//     final reverseGeocodingResponse = reverseGeocodingResponseFromJson(jsonString);

import 'dart:convert';

ReverseGeocodingResponse reverseGeocodingResponseFromJson(String str) =>
    ReverseGeocodingResponse.fromJson(json.decode(str));

String reverseGeocodingResponseToJson(ReverseGeocodingResponse data) =>
    json.encode(data.toJson());

class ReverseGeocodingResponse {
  ReverseGeocodingResponse({
    this.type = '',
    this.query = const [],
    this.features = const [],
  });

  String type;
  List<double> query;
  List<Feature> features;

  factory ReverseGeocodingResponse.fromJson(Map<String, dynamic> json) =>
      ReverseGeocodingResponse(
        type: json["type"],
        query: List<double>.from(json["query"].map((x) => x.toDouble())),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class Feature {
  Feature({
    this.id,
    this.type,
    this.placeType,
    this.relevance,
    this.textEs,
    this.placeNameEs,
    this.text,
    this.placeName,
    this.center,
    this.languageEs,
    this.language,
  });

  String? id;
  String? type;
  List<String>? placeType;
  int? relevance;
  String? textEs;
  String? placeNameEs;
  String? text;
  String? placeName;
  List<double>? center;
  String? languageEs;
  String? language;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"],
        textEs: json["text_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        languageEs: json["language_es"] == null ? null : json["language_es"],
        language: json["language"] == null ? null : json["language"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType!.map((x) => x)),
        "relevance": relevance,
        "text_es": textEs,
        "place_name_es": placeNameEs,
        "text": text,
        "place_name": placeName,
        "center":
            center == null ? [] : List<dynamic>.from(center!.map((x) => x)),
        "language_es": languageEs == null ? null : languageEs,
        "language": language == null ? null : language,
      };
}
