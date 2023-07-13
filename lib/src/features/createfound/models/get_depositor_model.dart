// To parse this JSON data, do
//
//     final getDepositor = getDepositorFromJson(jsonString);

import 'dart:convert';

GetDepositor getDepositorFromJson(String str) => GetDepositor.fromJson(json.decode(str));

String getDepositorToJson(GetDepositor data) => json.encode(data.toJson());

class GetDepositor {
    List<AtomStaticUser>? atomStaticUser;

    GetDepositor({
        this.atomStaticUser,
    });

    factory GetDepositor.fromJson(Map<String, dynamic> json) => GetDepositor(
        atomStaticUser: json["ATOM_STATIC_USER"] == null ? [] : List<AtomStaticUser>.from(json["ATOM_STATIC_USER"]!.map((x) => AtomStaticUser.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ATOM_STATIC_USER": atomStaticUser == null ? [] : List<dynamic>.from(atomStaticUser!.map((x) => x.toJson())),
    };
}

class AtomStaticUser {
    String? email;
    int? id;
    String? name;

    AtomStaticUser({
        this.email,
        this.id,
        this.name,
    });

    factory AtomStaticUser.fromJson(Map<String, dynamic> json) => AtomStaticUser(
        email: json["Email"],
        id: json["Id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Email": email,
        "Id": id,
        "Name": name,
    };
}
