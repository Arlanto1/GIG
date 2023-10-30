import 'dart:convert';

import 'package:db_atom/src/models/organisation.dart';

LeoDepartments leoDepartmentsFromJson(String str) => LeoDepartments.fromJson(json.decode(str));

String leoDepartmentsToJson(LeoDepartments data) => json.encode(data.toJson());

class LeoDepartments {
    List<Organisation>? atomLeoDepartments;

    LeoDepartments({
        this.atomLeoDepartments,
    });

    factory LeoDepartments.fromJson(Map<String, dynamic> json) => LeoDepartments(
        atomLeoDepartments: json["ATOM_LEO_DEPARTMENTS"] == null ? [] : List<Organisation>.from(json["ATOM_LEO_DEPARTMENTS"]!.map((x) => Organisation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ATOM_LEO_DEPARTMENTS": atomLeoDepartments == null ? [] : List<dynamic>.from(atomLeoDepartments!.map((x) => x.toJson())),
    };
}

