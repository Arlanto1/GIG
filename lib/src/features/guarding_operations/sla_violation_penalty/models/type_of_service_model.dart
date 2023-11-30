import 'dart:convert';

import '../../../../models/organisation.dart';


TypeOfServices typeOfServicesFromJson(String str) => TypeOfServices.fromJson(json.decode(str));

String typeOfServicesToJson(TypeOfServices data) => json.encode(data.toJson());

class TypeOfServices {
  List<Organisation>? items;

  TypeOfServices({
    this.items,
  });

  factory TypeOfServices.fromJson(Map<String, dynamic> json) => TypeOfServices(
    items: json["SLA_VIOLATION_TYPE_OF_SERVICE"] == null
        ? []
        : List<Organisation>.from(
        json["SLA_VIOLATION_TYPE_OF_SERVICE"]!.map((x) => Organisation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "SLA_VIOLATION_TYPE_OF_SERVICE": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}
