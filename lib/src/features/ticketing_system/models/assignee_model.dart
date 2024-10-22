import 'dart:convert';

import 'package:db_atom/index.dart';

import '../../../models/organisation.dart';

Assignee assigneeFromJson(String str) => Assignee.fromJson(json.decode(str));

String assigneeToJson(Assignee data) => json.encode(data.toJson());

class Assignee {
  List<BaseUser>? items;

  Assignee({
    this.items,
  });

  factory Assignee.fromJson(Map<String, dynamic> json) => Assignee(
    items: json["users"] == null
        ? []
        : List<BaseUser>.from(
        json["users"]!.map((x) => BaseUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "users": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}
