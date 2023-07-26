// To parse this JSON data, do
//
//     final addEntities = addEntitiesFromJson(jsonString);

import 'dart:convert';

AddEntities addEntitiesFromJson(String str) => AddEntities.fromJson(json.decode(str));

String addEntitiesToJson(AddEntities data) => json.encode(data.toJson());

class AddEntities {
    List<AtomEntity>? atomEntities;

    AddEntities({
        this.atomEntities,
    });

    factory AddEntities.fromJson(Map<String, dynamic> json) => AddEntities(
        atomEntities: json["ATOM_ENTITIES"] == null ? [] : List<AtomEntity>.from(json["ATOM_ENTITIES"]!.map((x) => AtomEntity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ATOM_ENTITIES": atomEntities == null ? [] : List<dynamic>.from(atomEntities!.map((x) => x.toJson())),
    };
}

class AtomEntity {
    int? id;
    String? name;

    AtomEntity({
        this.id,
        this.name,
    });

    factory AtomEntity.fromJson(Map<String, dynamic> json) => AtomEntity(
        id: json["Id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
    };
}
