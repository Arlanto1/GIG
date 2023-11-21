// To parse this JSON data, do
//
//     final submitCreateFoundModel = submitCreateFoundModelFromJson(jsonString);

import 'dart:convert';

SubmitCreateFoundModel submitCreateFoundModelFromJson(String str) =>
    SubmitCreateFoundModel.fromJson(json.decode(str));

String submitCreateFoundModelToJson(SubmitCreateFoundModel data) =>
    json.encode(data.toJson());

class SubmitCreateFoundModel {
  String? foundId;
  String? message;

  SubmitCreateFoundModel({
    this.foundId,
    this.message,
  });

  factory SubmitCreateFoundModel.fromJson(Map<String, dynamic> json) =>
      SubmitCreateFoundModel(
        foundId: json["Found ID"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Found ID": foundId,
        "Message": message,
      };
}
