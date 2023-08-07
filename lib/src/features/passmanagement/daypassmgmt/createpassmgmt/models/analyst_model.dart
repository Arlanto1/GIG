// To parse this JSON data, do
//
//     final analyst = analystFromJson(jsonString);

import 'dart:convert';

Analyst analystFromJson(String str) => Analyst.fromJson(json.decode(str));

String analystToJson(Analyst data) => json.encode(data.toJson());

class Analyst {
    List<T1Analyst>? t1Analyst;

    Analyst({
        this.t1Analyst,
    });

    factory Analyst.fromJson(Map<String, dynamic> json) => Analyst(
        t1Analyst: json["T1_Analyst"] == null ? [] : List<T1Analyst>.from(json["T1_Analyst"]!.map((x) => T1Analyst.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "T1_Analyst": t1Analyst == null ? [] : List<dynamic>.from(t1Analyst!.map((x) => x.toJson())),
    };
}

class T1Analyst {
    String? email;
    int? id;
    String? name;

    T1Analyst({
        this.email,
        this.id,
        this.name,
    });

    factory T1Analyst.fromJson(Map<String, dynamic> json) => T1Analyst(
        email: json["Email"],
        id: json["Id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Email": email,
        "Id": id,
        "Name": name,
    };
}
