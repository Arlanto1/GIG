import 'dart:convert';

import 'package:db_atom/src/models/organisation.dart';

AddEntities addEntitiesFromJson(String str) =>
    AddEntities.fromJson(json.decode(str));

String addEntitiesToJson(AddEntities data) => json.encode(data.toJson());

class AddEntities {
  List<Organisation>? atomEntities;

  AddEntities({
    this.atomEntities,
  });

  factory AddEntities.fromJson(Map<String, dynamic> json) => AddEntities(
        atomEntities: json["ATOM_ENTITIES"] == null
            ? []
            : List<Organisation>.from(
                json["ATOM_ENTITIES"]!.map((x) => Organisation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ATOM_ENTITIES": atomEntities == null
            ? []
            : List<dynamic>.from(atomEntities!.map((x) => x.toJson())),
      };
}
