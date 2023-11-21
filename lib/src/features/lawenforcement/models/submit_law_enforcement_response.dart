// To parse this JSON data, do
//
//     final submitLawEnforcementResponse = submitLawEnforcementResponseFromJson(jsonString);

import 'dart:convert';

SubmitLawEnforcementResponse submitLawEnforcementResponseFromJson(String str) =>
    SubmitLawEnforcementResponse.fromJson(json.decode(str));

String submitLawEnforcementResponseToJson(SubmitLawEnforcementResponse data) =>
    json.encode(data.toJson());

class SubmitLawEnforcementResponse {
  String? message;
  String? lawEnforcementId;

  SubmitLawEnforcementResponse({
    this.message,
    this.lawEnforcementId,
  });

  factory SubmitLawEnforcementResponse.fromJson(Map<String, dynamic> json) =>
      SubmitLawEnforcementResponse(
        message: json["Message"],
        lawEnforcementId: json["Law Enforcement ID"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Law Enforcement ID": lawEnforcementId,
      };
}
