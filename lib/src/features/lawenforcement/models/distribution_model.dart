// To parse this JSON data, do
//
//     final distributionModel = distributionModelFromJson(jsonString);

import 'dart:convert';

DistributionGroupModel distributionModelFromJson(String str) => DistributionGroupModel.fromJson(json.decode(str));

String distributionModelToJson(DistributionGroupModel data) => json.encode(data.toJson());

class DistributionGroupModel {
    List<DistributionGroup>? distributionGroups;

    DistributionGroupModel({
        this.distributionGroups,
    });

    factory DistributionGroupModel.fromJson(Map<String, dynamic> json) => DistributionGroupModel(
        distributionGroups: json["Distribution Groups"] == null ? [] : List<DistributionGroup>.from(json["Distribution Groups"]!.map((x) => DistributionGroup.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Distribution Groups": distributionGroups == null ? [] : List<dynamic>.from(distributionGroups!.map((x) => x.toJson())),
    };
}

class DistributionGroup {
    int? id;
    String? name;

    DistributionGroup({
        this.id,
        this.name,
    });

    factory DistributionGroup.fromJson(Map<String, dynamic> json) => DistributionGroup(
        id: json["Id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
    };
}
