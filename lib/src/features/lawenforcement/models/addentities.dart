// To parse this JSON data, do
//
//     final addEntities = addEntitiesFromJson(jsonString);

import 'dart:convert';

import '../../../models/entity.dart';

AddEntities addEntitiesFromJson(String str) => AddEntities.fromJson(json.decode(str));

String addEntitiesToJson(AddEntities data) => json.encode(data.toJson());

class AddEntities {
    List<Entity>? atomEntities;

    AddEntities({
        this.atomEntities,
    });

    factory AddEntities.fromJson(Map<String, dynamic> json) => AddEntities(
        atomEntities: json["ATOM_ENTITIES"] == null ? [] : List<Entity>.from(json["ATOM_ENTITIES"]!.map((x) => Entity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ATOM_ENTITIES": atomEntities == null ? [] : List<dynamic>.from(atomEntities!.map((x) => x.toJson())),
    };
}

