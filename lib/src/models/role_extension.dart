class RoleExtension {
  RoleExtension({
    required this.roleExtensionId,
    required this.roleId,
    required this.displayName,
    required this.area,
    required this.filter,
    required this.rootNodeId,
    required this.nodeId,
    required this.accessRight,
  });

  final int? roleExtensionId;
  final int? roleId;
  final String? displayName;
  final String? area;
  final String? filter;
  final dynamic rootNodeId;
  final dynamic nodeId;
  final dynamic accessRight;

  factory RoleExtension.fromJson(Map<String, dynamic> json) {
    return RoleExtension(
      roleExtensionId: json["roleExtensionId"],
      roleId: json["roleId"],
      displayName: json["displayName"],
      area: json["area"],
      filter: json["filter"],
      rootNodeId: json["rootNodeId"],
      nodeId: json["nodeId"],
      accessRight: json["accessRight"],
    );
  }

  Map<String, dynamic> toJson() => {
        "roleExtensionId": roleExtensionId,
        "roleId": roleId,
        "displayName": displayName,
        "area": area,
        "filter": filter,
        "rootNodeId": rootNodeId,
        "nodeId": nodeId,
        "accessRight": accessRight,
      };
}
