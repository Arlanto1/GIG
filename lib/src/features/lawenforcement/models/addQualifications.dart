// To parse this JSON data, do
//
//     final addEntities = addEntitiesFromJson(jsonString);

import 'dart:convert';

import '../../../models/entity.dart';

AddQualifications addQualificationsFromJson(String str) => AddQualifications.fromJson(json.decode(str));

String addQualificationsToJson(AddQualifications data) => json.encode(data.toJson());

class AddQualifications {
  List<Entity>? guardQualifications;

  AddQualifications({
    this.guardQualifications,
  });

  factory AddQualifications.fromJson(Map<String, dynamic> json) => AddQualifications(
    guardQualifications: json["GUARD_QUALIFICATIONS"] == null ? [] : List<Entity>.from(json["GUARD_QUALIFICATIONS"]!.map((x) => Entity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "GUARD_QUALIFICATIONS": guardQualifications == null ? [] : List<dynamic>.from(guardQualifications!.map((x) => x.toJson())),
  };
}

