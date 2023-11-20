// To parse this JSON data, do
//
//     final distributionModel = distributionModelFromJson(jsonString);

import 'dart:convert';

import 'package:db_atom/src/models/organisation.dart';

DistributionGroupModel distributionModelFromJson(String str) =>
    DistributionGroupModel.fromJson(json.decode(str));

String distributionModelToJson(DistributionGroupModel data) =>
    json.encode(data.toJson());

class DistributionGroupModel {
  List<Organisation>? distributionGroups;

  DistributionGroupModel({
    this.distributionGroups,
  });

  factory DistributionGroupModel.fromJson(Map<String, dynamic> json) =>
      DistributionGroupModel(
        distributionGroups: json["Distribution Groups"] == null
            ? []
            : List<Organisation>.from(json["Distribution Groups"]!
                .map((x) => Organisation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Distribution Groups": distributionGroups == null
            ? []
            : List<dynamic>.from(distributionGroups!.map((x) => x.toJson())),
      };
}
