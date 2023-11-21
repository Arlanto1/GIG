import 'dart:convert';

import '../../../models/organisation.dart';

LeoPurposeVisit leoPurposeVisitFromJson(String str) =>
    LeoPurposeVisit.fromJson(json.decode(str));

String leoPurposeVisitToJson(LeoPurposeVisit data) =>
    json.encode(data.toJson());

class LeoPurposeVisit {
  List<Organisation>? atomLeoPurposeVisit;

  LeoPurposeVisit({
    this.atomLeoPurposeVisit,
  });

  factory LeoPurposeVisit.fromJson(Map<String, dynamic> json) =>
      LeoPurposeVisit(
        atomLeoPurposeVisit: json["ATOM_LEO_PURPOSE_VISIT"] == null
            ? []
            : List<Organisation>.from(json["ATOM_LEO_PURPOSE_VISIT"]!
                .map((x) => Organisation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ATOM_LEO_PURPOSE_VISIT": atomLeoPurposeVisit == null
            ? []
            : List<dynamic>.from(atomLeoPurposeVisit!.map((x) => x.toJson())),
      };
}
