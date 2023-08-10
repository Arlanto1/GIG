// To parse this JSON data, do
//
//     final dayPassReason = dayPassReasonFromJson(jsonString);

import 'dart:convert';

DayPassReason dayPassReasonFromJson(String str) => DayPassReason.fromJson(json.decode(str));

String dayPassReasonToJson(DayPassReason data) => json.encode(data.toJson());

class DayPassReason {
    List<DayPassReasonElement>? dayPassReason;

    DayPassReason({
        this.dayPassReason,
    });

    factory DayPassReason.fromJson(Map<String, dynamic> json) => DayPassReason(
        dayPassReason: json["DAY_PASS_REASON"] == null ? [] : List<DayPassReasonElement>.from(json["DAY_PASS_REASON"]!.map((x) => DayPassReasonElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "DAY_PASS_REASON": dayPassReason == null ? [] : List<dynamic>.from(dayPassReason!.map((x) => x.toJson())),
    };
}

class DayPassReasonElement {
    int? id;
    String? name;

    DayPassReasonElement({
        this.id,
        this.name,
    });

    factory DayPassReasonElement.fromJson(Map<String, dynamic> json) => DayPassReasonElement(
        id: json["Id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
    };
}
