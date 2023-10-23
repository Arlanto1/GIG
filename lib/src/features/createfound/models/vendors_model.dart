import 'dart:convert';

import '../../../models/organisation.dart';

Vendors vendorsFromJson(String str) =>
    Vendors.fromJson(json.decode(str));

String vendorsToJson(Vendors data) => json.encode(data.toJson());

class Vendors {
  List<Organisation>? vendorsDept;

  Vendors({
    this.vendorsDept,
  });

  factory Vendors.fromJson(Map<String, dynamic> json) => Vendors(
    vendorsDept: json["ATOM_VENDORS"] == null
        ? []
        : List<Organisation>.from(
        json["ATOM_VENDORS"]!.map((x) => Organisation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ATOM_VENDORS": vendorsDept == null
        ? []
        : List<dynamic>.from(vendorsDept!.map((x) => x.toJson())),
  };
}

