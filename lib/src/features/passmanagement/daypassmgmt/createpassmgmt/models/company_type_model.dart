import 'dart:convert';

import '../../../../../models/organisation.dart';

CompanyTypes companyTypesFromJson(String str) =>
    CompanyTypes.fromJson(json.decode(str));

String companyTypesToJson(CompanyTypes data) => json.encode(data.toJson());

class CompanyTypes {
  List<Organisation>? atomCompanyTypes;

  CompanyTypes({
    this.atomCompanyTypes,
  });

  factory CompanyTypes.fromJson(Map<String, dynamic> json) => CompanyTypes(
        atomCompanyTypes: json["ATOM_COMPANY_TYPES"] == null
            ? []
            : List<Organisation>.from(json["ATOM_COMPANY_TYPES"]!
                .map((x) => Organisation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ATOM_COMPANY_TYPES": atomCompanyTypes == null
            ? []
            : List<dynamic>.from(atomCompanyTypes!.map((x) => x.toJson())),
      };
}
