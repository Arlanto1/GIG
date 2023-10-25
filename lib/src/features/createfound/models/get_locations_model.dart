import 'dart:convert';

import '../../../models/organisation.dart';

GetLocations getLocationsFromJson(String str) =>
    GetLocations.fromJson(json.decode(str));

String getLocationsToJson(GetLocations data) => json.encode(data.toJson());

class GetLocations {
  List<Organisation>? west;
  List<Organisation>? south;
  List<Organisation>? northEast;
  List<Organisation>? mumbai;

  GetLocations({
    this.west,
    this.south,
    this.northEast,
    this.mumbai,
  });

  factory GetLocations.fromJson(Map<String, dynamic> json) => GetLocations(
        west: json["West"] == null
            ? []
            : List<Organisation>.from(
                json["West"]!.map((x) => Organisation.fromJson(x))),
        south: json["South"] == null
            ? []
            : List<Organisation>.from(
                json["South"]!.map((x) => Organisation.fromJson(x))),
        northEast: json["North & East"] == null
            ? []
            : List<Organisation>.from(
                json["North & East"]!.map((x) => Organisation.fromJson(x))),
        mumbai: json["Mumbai"] == null
            ? []
            : List<Organisation>.from(
                json["Mumbai"]!.map((x) => Organisation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "West": west == null
            ? []
            : List<dynamic>.from(west!.map((x) => x.toJson())),
        "South": south == null
            ? []
            : List<dynamic>.from(south!.map((x) => x.toJson())),
        "North & East": northEast == null
            ? []
            : List<dynamic>.from(northEast!.map((x) => x.toJson())),
        "Mumbai": mumbai == null
            ? []
            : List<dynamic>.from(mumbai!.map((x) => x.toJson())),
      };
}
