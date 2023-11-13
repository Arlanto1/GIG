// To parse this JSON data, do
//
//     final dayPassReason = dayPassReasonFromJson(jsonString);

import 'dart:convert';

import 'package:db_atom/src/models/organisation.dart';

VendorPassReason vendorPassReasonFromJson(String str) => VendorPassReason.fromJson(json.decode(str));

String vendorPassReasonToJson(VendorPassReason data) => json.encode(data.toJson());

class VendorPassReason {
  List<Organisation>? vendorPassReason;

  VendorPassReason({
    this.vendorPassReason,
  });

  factory VendorPassReason.fromJson(Map<String, dynamic> json) => VendorPassReason(
    vendorPassReason: json["VENDOR_PASS_REASON"] == null ? [] : List<Organisation>.from(json["VENDOR_PASS_REASON"]!.map((x) => Organisation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "VENDOR_PASS_REASON": vendorPassReason == null ? [] : List<dynamic>.from(vendorPassReason!.map((x) => x.toJson())),
  };
}
