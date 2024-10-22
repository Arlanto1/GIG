import 'dart:convert';

import '../../../models/organisation.dart';

Projects projectsFromJson(String str) => Projects.fromJson(json.decode(str));

String projectsToJson(Projects data) => json.encode(data.toJson());

class Projects {
  List<Organisation>? items;

  Projects({
    this.items,
  });

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
        items: json["projects"] == null
            ? []
            : List<Organisation>.from(
                json["projects"]!.map((x) => Organisation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "projects": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}
