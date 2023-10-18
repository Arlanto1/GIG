// To parse this JSON data, do
//
//     final dayPassReason = dayPassReasonFromJson(jsonString);

import 'dart:convert';

DayPassReason dayPassReasonFromJson(String str) => DayPassReason.fromJson(json.decode(str));

String dayPassReasonToJson(DayPassReason data) => json.encode(data.toJson());

class DayPassReason {
    List<DayPassReasonElement>? dayPassReasonElement;

    DayPassReason({
        this.dayPassReasonElement,
    });

    factory DayPassReason.fromJson(Map<String, dynamic> json) => DayPassReason(
        dayPassReasonElement: json["DAY_PASS_REASON"] == null ? [] : List<DayPassReasonElement>.from(json["DAY_PASS_REASON"]!.map((x) => DayPassReasonElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "DAY_PASS_REASON": dayPassReasonElement == null ? [] : List<dynamic>.from(dayPassReasonElement!.map((x) => x.toJson())),
    };
}

class DayPassReasonElement {
    int? id;
    String? name;

    DayPassReasonElement({
        this.id,
        this.name,
    });

    DayPassReasonElement.fromJson(Map<String, dynamic> json)
        : id = json['id'] ?? json['Id'] as int?,
            name = json['name'] ?? json['Name'] as String?;

    Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
