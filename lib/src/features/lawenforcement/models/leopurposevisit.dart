// To parse this JSON data, do
//
//     final leoPurposeVisit = leoPurposeVisitFromJson(jsonString);

import 'dart:convert';

LeoPurposeVisit leoPurposeVisitFromJson(String str) => LeoPurposeVisit.fromJson(json.decode(str));

String leoPurposeVisitToJson(LeoPurposeVisit data) => json.encode(data.toJson());

class LeoPurposeVisit {
    List<AtomLeoPurposeVisit>? atomLeoPurposeVisit;

    LeoPurposeVisit({
        this.atomLeoPurposeVisit,
    });

    factory LeoPurposeVisit.fromJson(Map<String, dynamic> json) => LeoPurposeVisit(
        atomLeoPurposeVisit: json["ATOM_LEO_PURPOSE_VISIT"] == null ? [] : List<AtomLeoPurposeVisit>.from(json["ATOM_LEO_PURPOSE_VISIT"]!.map((x) => AtomLeoPurposeVisit.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ATOM_LEO_PURPOSE_VISIT": atomLeoPurposeVisit == null ? [] : List<dynamic>.from(atomLeoPurposeVisit!.map((x) => x.toJson())),
    };
}

class AtomLeoPurposeVisit {
    int? id;
    String? name;

    AtomLeoPurposeVisit({
        this.id,
        this.name,
    });

    factory AtomLeoPurposeVisit.fromJson(Map<String, dynamic> json) => AtomLeoPurposeVisit(
        id: json["Id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
    };
}
