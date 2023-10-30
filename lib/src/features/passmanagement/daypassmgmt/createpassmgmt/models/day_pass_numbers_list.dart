import 'dart:convert';

import 'package:db_atom/src/models/organisation.dart';

DayPassNumberLists dayPassNumberListsFromJson(String str) =>
    DayPassNumberLists.fromJson(json.decode(str));

String dayPassNumberListsToJson(DayPassNumberLists data) =>
    json.encode(data.toJson());

class DayPassNumberLists {
  List<Organisation>? activePassInfoList;

  DayPassNumberLists({
    this.activePassInfoList,
  });

  factory DayPassNumberLists.fromJson(Map<String, dynamic> json) =>
      DayPassNumberLists(
        activePassInfoList: json["activePassInfoList"] == null
            ? []
            : List<Organisation>.from(json["activePassInfoList"]!
                .map((x) => Organisation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "activePassInfoList": activePassInfoList == null
            ? []
            : List<dynamic>.from(activePassInfoList!.map((x) => x.toJson())),
      };
}
