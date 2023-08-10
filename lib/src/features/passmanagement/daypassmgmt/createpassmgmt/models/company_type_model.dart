// To parse this JSON data, do
//
//     final companyTypes = companyTypesFromJson(jsonString);

import 'dart:convert';

CompanyTypes companyTypesFromJson(String str) => CompanyTypes.fromJson(json.decode(str));

String companyTypesToJson(CompanyTypes data) => json.encode(data.toJson());

class CompanyTypes {
    List<AtomCompanyType>? atomCompanyTypes;

    CompanyTypes({
        this.atomCompanyTypes,
    });

    factory CompanyTypes.fromJson(Map<String, dynamic> json) => CompanyTypes(
        atomCompanyTypes: json["ATOM_COMPANY_TYPES"] == null ? [] : List<AtomCompanyType>.from(json["ATOM_COMPANY_TYPES"]!.map((x) => AtomCompanyType.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ATOM_COMPANY_TYPES": atomCompanyTypes == null ? [] : List<dynamic>.from(atomCompanyTypes!.map((x) => x.toJson())),
    };
}

class AtomCompanyType {
    int? id;
    String? name;

    AtomCompanyType({
        this.id,
        this.name,
    });

    factory AtomCompanyType.fromJson(Map<String, dynamic> json) => AtomCompanyType(
        id: json["Id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
    };
}
