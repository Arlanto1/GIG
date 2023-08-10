// To parse this JSON data, do
//
//     final dayPassNumberLists = dayPassNumberListsFromJson(jsonString);

import 'dart:convert';

DayPassNumberLists dayPassNumberListsFromJson(String str) => DayPassNumberLists.fromJson(json.decode(str));

String dayPassNumberListsToJson(DayPassNumberLists data) => json.encode(data.toJson());

class DayPassNumberLists {
    List<ActivePassInfoList>? activePassInfoList;

    DayPassNumberLists({
        this.activePassInfoList,
    });

    factory DayPassNumberLists.fromJson(Map<String, dynamic> json) => DayPassNumberLists(
        activePassInfoList: json["activePassInfoList"] == null ? [] : List<ActivePassInfoList>.from(json["activePassInfoList"]!.map((x) => ActivePassInfoList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "activePassInfoList": activePassInfoList == null ? [] : List<dynamic>.from(activePassInfoList!.map((x) => x.toJson())),
    };
}

class ActivePassInfoList {
    int? id;
    String? name;

    ActivePassInfoList({
        this.id,
        this.name,
    });

    factory ActivePassInfoList.fromJson(Map<String, dynamic> json) => ActivePassInfoList(
        id: json["Id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
    };
}
