import 'dart:convert';

import '../../../../../models/base_user.dart';

Analyst analystFromJson(String str) => Analyst.fromJson(json.decode(str));

String analystToJson(Analyst data) => json.encode(data.toJson());

class Analyst {
  List<BaseUser>? t1Analyst;

  Analyst({
    this.t1Analyst,
  });

  factory Analyst.fromJson(Map<String, dynamic> json) => Analyst(
        t1Analyst: json["T1_Analyst"] == null
            ? []
            : List<BaseUser>.from(
                json["T1_Analyst"]!.map((x) => BaseUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "T1_Analyst": t1Analyst == null
            ? []
            : List<dynamic>.from(t1Analyst!.map((x) => x.toJson())),
      };
}
