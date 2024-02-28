// To parse this JSON data, do
//
//     final dayPassInfoResponse = dayPassInfoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_model.dart';
import 'package:db_atom/src/models/organisation.dart';

DayPassInfoResponseModel dayPassInfoResponseFromJson(String str) =>
    DayPassInfoResponseModel.fromJson(json.decode(str));

String dayPassInfoResponseToJson(DayPassInfoResponseModel data) =>
    json.encode(data.toJson());

class DayPassInfoResponseModel {
  List<PassInfo>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  DayPassInfoResponseModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  factory DayPassInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      DayPassInfoResponseModel(
        items: json["list"] == null
            ? []
            : List<PassInfo>.from(
                json["list"]!.map((x) => PassInfo.fromJson(x))),
        totalCount: json["totalCount"],
        currentPageNo: json["currentPageNo"],
        totalPageCount: json["totalPageCount"],
      );

  Map<String, dynamic> toJson() => {
        "list": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalCount": totalCount,
        "currentPageNo": currentPageNo,
        "totalPageCount": totalPageCount,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
