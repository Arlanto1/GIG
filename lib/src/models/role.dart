import 'role_extension.dart';

class Role {
  Role({
    required this.roleId,
    required this.application,
    required this.roleName,
    required this.roleExtensions,
    required this.name,
  });

  final int? roleId;
  final String? application;
  final String? roleName;
  final List<RoleExtension> roleExtensions;
  final String? name;

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      roleId: json["roleId"],
      application: json["application"],
      roleName: json["roleName"],
      roleExtensions: json["roleExtensions"] == null
          ? []
          : List<RoleExtension>.from(
              json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "application": application,
        "roleName": roleName,
        "roleExtensions": roleExtensions.map((x) => x.toJson()).toList(),
        "name": name,
      };
}
