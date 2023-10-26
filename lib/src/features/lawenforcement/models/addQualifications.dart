
import 'dart:convert';

import 'package:db_atom/src/models/organisation.dart';


AddQualifications addQualificationsFromJson(String str) => AddQualifications.fromJson(json.decode(str));

String addQualificationsToJson(AddQualifications data) => json.encode(data.toJson());

class AddQualifications {
  List<Organisation>? guardQualifications;

  AddQualifications({
    this.guardQualifications,
  });

  factory AddQualifications.fromJson(Map<String, dynamic> json) => AddQualifications(
    guardQualifications: json["GUARD_QUALIFICATIONS"] == null ? [] : List<Organisation>.from(json["GUARD_QUALIFICATIONS"]!.map((x) => Organisation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "GUARD_QUALIFICATIONS": guardQualifications == null ? [] : List<dynamic>.from(guardQualifications!.map((x) => x.toJson())),
  };
}

