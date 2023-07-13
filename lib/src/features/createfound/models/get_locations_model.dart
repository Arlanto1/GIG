// To parse this JSON data, do
//
//     final getLocations = getLocationsFromJson(jsonString);

import 'dart:convert';

GetLocations getLocationsFromJson(String str) => GetLocations.fromJson(json.decode(str));

String getLocationsToJson(GetLocations data) => json.encode(data.toJson());

class GetLocations {
  List<Mumbai>? west;
  List<Mumbai>? south;
  List<Mumbai>? northEast;
  List<Mumbai>? mumbai;

  GetLocations({
    this.west,
    this.south,
    this.northEast,
    this.mumbai,
  });

  factory GetLocations.fromJson(Map<String, dynamic> json) => GetLocations(
        west: json["West"] == null
            ? []
            : List<Mumbai>.from(json["West"]!.map((x) => Mumbai.fromJson(x))),
        south: json["South"] == null
            ? []
            : List<Mumbai>.from(json["South"]!.map((x) => Mumbai.fromJson(x))),
        northEast: json["North & East"] == null
            ? []
            : List<Mumbai>.from(json["North & East"]!.map((x) => Mumbai.fromJson(x))),
        mumbai: json["Mumbai"] == null
            ? []
            : List<Mumbai>.from(json["Mumbai"]!.map((x) => Mumbai.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "West": west == null ? [] : List<dynamic>.from(west!.map((x) => x.toJson())),
        "South": south == null ? [] : List<dynamic>.from(south!.map((x) => x.toJson())),
        "North & East":
            northEast == null ? [] : List<dynamic>.from(northEast!.map((x) => x.toJson())),
        "Mumbai": mumbai == null ? [] : List<dynamic>.from(mumbai!.map((x) => x.toJson())),
      };
}

class Mumbai {
  int? id;
  String? name;

  Mumbai({
    this.id,
    this.name,
  });

  factory Mumbai.fromJson(Map<String, dynamic> json) => Mumbai(
        id: json["Id"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
