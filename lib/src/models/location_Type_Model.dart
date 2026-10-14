  import 'dart:convert';

  import '../../../../../../index.dart';

  GetLocationType getGetLocationTypeFromJson(String str) =>
      GetLocationType.fromJson(json.decode(str));

  String getGetLocationTypeToJson(GetLocationType data) => json.encode(data.toJson());

  class GetLocationType {
    List<Organisation>? getLocationType;

    GetLocationType({
      this.getLocationType,
    });

    factory GetLocationType.fromJson(Map<String, dynamic> json) => GetLocationType(
      getLocationType: json["locationTypes"] == null
          ? []
          : List<Organisation>.from(
          json["locationTypes"]!.map((x) => Organisation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
      "locationTypes": getLocationType == null
          ? []
          : List<dynamic>.from(getLocationType!.map((x) => x.toJson())),
    };
  }
