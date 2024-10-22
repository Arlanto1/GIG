import 'dart:convert';

import '../../../models/organisation.dart';

Priorities priorityFromJson(String str) => Priorities.fromJson(json.decode(str));

String priorityToJson(Priorities data) => json.encode(data.toJson());

class Priorities {
  List<Organisation>? items;

  Priorities({
    this.items,
  });

  factory Priorities.fromJson(Map<String, dynamic> json) => Priorities(
    items: json["priorities"] == null
        ? []
        : List<Organisation>.from(
        json["priorities"]!.map((x) => Organisation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "priorities": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}
