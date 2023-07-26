// To parse this JSON data, do
//
//     final leoDepartments = leoDepartmentsFromJson(jsonString);

import 'dart:convert';

LeoDepartments leoDepartmentsFromJson(String str) => LeoDepartments.fromJson(json.decode(str));

String leoDepartmentsToJson(LeoDepartments data) => json.encode(data.toJson());

class LeoDepartments {
    List<AtomLeoDepartment>? atomLeoDepartments;

    LeoDepartments({
        this.atomLeoDepartments,
    });

    factory LeoDepartments.fromJson(Map<String, dynamic> json) => LeoDepartments(
        atomLeoDepartments: json["ATOM_LEO_DEPARTMENTS"] == null ? [] : List<AtomLeoDepartment>.from(json["ATOM_LEO_DEPARTMENTS"]!.map((x) => AtomLeoDepartment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ATOM_LEO_DEPARTMENTS": atomLeoDepartments == null ? [] : List<dynamic>.from(atomLeoDepartments!.map((x) => x.toJson())),
    };
}

class AtomLeoDepartment {
    int? id;
    String? name;

    AtomLeoDepartment({
        this.id,
        this.name,
    });

    factory AtomLeoDepartment.fromJson(Map<String, dynamic> json) => AtomLeoDepartment(
        id: json["Id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
    };
}
