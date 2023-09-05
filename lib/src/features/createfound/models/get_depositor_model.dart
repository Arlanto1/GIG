// To parse this JSON data, do
//
//     final getDepositor = getDepositorFromJson(jsonString);

import 'dart:convert';

import '../../../models/base_user.dart';

GetDepositor getDepositorFromJson(String str) =>
    GetDepositor.fromJson(json.decode(str));

String getDepositorToJson(GetDepositor data) => json.encode(data.toJson());

class GetDepositor {
  List<BaseUser>? atomStaticUser;

  GetDepositor({
    this.atomStaticUser,
  });

  factory GetDepositor.fromJson(Map<String, dynamic> json) => GetDepositor(
        atomStaticUser: json["ATOM_STATIC_USER"] == null
            ? []
            : List<BaseUser>.from(
                json["ATOM_STATIC_USER"]!.map((x) => BaseUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ATOM_STATIC_USER": atomStaticUser == null
            ? []
            : List<dynamic>.from(atomStaticUser!.map((x) => x.toJson())),
      };
}
