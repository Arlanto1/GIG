// To parse this JSON data, do
//
//     final dayPassReason = dayPassReasonFromJson(jsonString);

import 'dart:convert';

import 'package:db_atom/src/models/organisation.dart';

DayPassReason dayPassReasonFromJson(String str) =>
    DayPassReason.fromJson(json.decode(str));

String dayPassReasonToJson(DayPassReason data) => json.encode(data.toJson());

class DayPassReason {
  List<Organisation>? dayPassReasonElement;

  DayPassReason({
    this.dayPassReasonElement,
  });

  factory DayPassReason.fromJson(Map<String, dynamic> json) => DayPassReason(
        dayPassReasonElement: json["DAY_PASS_REASON"] == null
            ? []
            : List<Organisation>.from(
                json["DAY_PASS_REASON"]!.map((x) => Organisation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "DAY_PASS_REASON": dayPassReasonElement == null
            ? []
            : List<dynamic>.from(dayPassReasonElement!.map((x) => x.toJson())),
      };
}
