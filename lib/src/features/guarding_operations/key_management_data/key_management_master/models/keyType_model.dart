import 'dart:convert';

import 'package:db_atom/src/models/organisation.dart';

KeyType keyTypeFromJson(String str) => KeyType.fromJson(json.decode(str));

String keyTypeToJson(KeyType data) => json.encode(data.toJson());

class KeyType {
  List<Organisation>? items;

  KeyType({
    this.items,
  });

  factory KeyType.fromJson(Map<String, dynamic> json) => KeyType(
    items: json["KEY_MANAGEMENT_DOOR_TYPE"] == null
        ? []
        : List<Organisation>.from(
        json["KEY_MANAGEMENT_DOOR_TYPE"]!.map((x) => Organisation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "KEY_MANAGEMENT_DOOR_TYPE": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}
