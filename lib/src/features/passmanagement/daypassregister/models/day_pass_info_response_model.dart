// To parse this JSON data, do
//
//     final dayPassInfoResponse = dayPassInfoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:db_atom/src/models/organisation.dart';

DayPassInfoResponseModel dayPassInfoResponseFromJson(String str) =>
    DayPassInfoResponseModel.fromJson(json.decode(str));

String dayPassInfoResponseToJson(DayPassInfoResponseModel data) =>
    json.encode(data.toJson());

class DayPassInfoResponseModel {
  List<DaypassInfoListElement>? list;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  DayPassInfoResponseModel({
    this.list,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  factory DayPassInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      DayPassInfoResponseModel(
        list: json["list"] == null
            ? []
            : List<DaypassInfoListElement>.from(
                json["list"]!.map((x) => DaypassInfoListElement.fromJson(x))),
        totalCount: json["totalCount"],
        currentPageNo: json["currentPageNo"],
        totalPageCount: json["totalPageCount"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "totalCount": totalCount,
        "currentPageNo": currentPageNo,
        "totalPageCount": totalPageCount,
      };
}

class DaypassInfoListElement {
  int? id;
  int? passType;
  String? passNo;
  String? mifareNo;
  String? expiryDate;
  Organisation? location;
  Organisation? region;
  Organisation? entity;
  bool? dws;
  int? status;

  DaypassInfoListElement({
    this.id,
    this.passType,
    this.passNo,
    this.mifareNo,
    this.expiryDate,
    this.location,
    this.region,
    this.entity,
    this.dws,
    this.status,
  });

  factory DaypassInfoListElement.fromJson(Map<String, dynamic> json) =>
      DaypassInfoListElement(
        id: json["id"],
        passType: json["passType"],
        passNo: json["passNo"],
        mifareNo: json["mifareNo"],
        expiryDate: json["expiryDate"],
        location: json["location"] == null
            ? null
            : Organisation.fromJson(json["location"]),
        region: json["region"] == null
            ? null
            : Organisation.fromJson(json["region"]),
        entity: json["entity"] == null
            ? null
            : Organisation.fromJson(json["entity"]),
        dws: json["dws"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "passType": passType,
        "passNo": passNo,
        "mifareNo": mifareNo,
        "expiryDate": expiryDate,
        "location": location?.toJson(),
        "region": region?.toJson(),
        "entity": entity?.toJson(),
        "dws": dws,
        "status": status,
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
