import 'dart:convert';

import '../../../models/organisation.dart';

Trackers trackersFromJson(String str) => Trackers.fromJson(json.decode(str));

String trackersToJson(Trackers data) => json.encode(data.toJson());

class Trackers {
  List<Organisation>? items;

  Trackers({
    this.items,
  });

  factory Trackers.fromJson(Map<String, dynamic> json) => Trackers(
    items: json["trackers"] == null
        ? []
        : List<Organisation>.from(
        json["trackers"]!.map((x) => Organisation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "trackers": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}
