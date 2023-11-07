import 'dart:developer';

import 'package:db_atom/src/features/material_movement/models/material_movement_model.dart';

class MaterialMovementsModel {
  List<MaterialMovementModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  MaterialMovementsModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  MaterialMovementsModel.fromJson(Map<String, dynamic> json) {
    List list = json['list'] as List;
    List<MaterialMovementModel> modellist = list.map((e) {
      try {
        return MaterialMovementModel.fromJson(e as Map<String, dynamic>);
      } catch (e) {
        // Handle the exception, you can log it or take any appropriate action.
        // For example, you can log the error and return a default value.
        print('Error parsing MaterialMovementModel: $e');
        return MaterialMovementModel(); // Return a default instance of MaterialMovementModel.
      }
    }).toList();

    log('--modellist---${modellist.length}');

    try {
      if (json['list'] is List) {
        items = (json['list'] as List)
            .map((dynamic e) =>
                MaterialMovementModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        // Handle the case where 'list' is not a List
        items = [];
      }
      totalCount = json['totalCount'] as int?;
      currentPageNo = json['currentPageNo'] as int?;
      totalPageCount = json['totalPageCount'] as int?;
    } catch (e) {
      // Print debug information
      print('Error parsing MaterialMovementsModel: $e');
      print('json: $json');
    }
  }

  Map<String, dynamic> toJson() => {
        'list': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

class ImageContent {
  String? contentType;
  String? title;
  int? fileSize;
  String? imageContent;

  ImageContent({
    this.contentType,
    this.title,
    this.fileSize,
    this.imageContent,
  });

  ImageContent.fromJson(Map<String, dynamic> json)
      : contentType = json['contentType'] as String?,
        title = json['title'] as String?,
        fileSize = json['fileSize'] as int?,
        imageContent = json['imageContent'] as String?;

  Map<String, dynamic> toJson() => {
        'contentType': contentType,
        'title': title,
        'fileSize': fileSize,
        'imageContent': imageContent
      };
}

class Roles {
  int? roleId;
  String? application;
  String? roleName;
  List<RoleExtensions>? roleExtensions;
  String? name;

  Roles({
    this.roleId,
    this.application,
    this.roleName,
    this.roleExtensions,
    this.name,
  });

  Roles.fromJson(Map<String, dynamic> json)
      : roleId = json['roleId'] as int?,
        application = json['application'] as String?,
        roleName = json['roleName'] as String?,
        roleExtensions = (json['roleExtensions'] as List?)
            ?.map((dynamic e) =>
                RoleExtensions.fromJson(e as Map<String, dynamic>))
            .toList(),
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
        'roleId': roleId,
        'application': application,
        'roleName': roleName,
        'roleExtensions': roleExtensions?.map((e) => e.toJson()).toList(),
        'name': name
      };
}

class RoleExtensions {
  int? roleExtensionId;
  int? roleId;
  String? displayName;
  String? area;
  String? filter;
  dynamic rootNodeId;
  dynamic nodeId;
  dynamic accessRight;

  RoleExtensions({
    this.roleExtensionId,
    this.roleId,
    this.displayName,
    this.area,
    this.filter,
    this.rootNodeId,
    this.nodeId,
    this.accessRight,
  });

  RoleExtensions.fromJson(Map<String, dynamic> json)
      : roleExtensionId = json['roleExtensionId'] as int?,
        roleId = json['roleId'] as int?,
        displayName = json['displayName'] as String?,
        area = json['area'] as String?,
        filter = json['filter'] as String?,
        rootNodeId = json['rootNodeId'],
        nodeId = json['nodeId'],
        accessRight = json['accessRight'];

  Map<String, dynamic> toJson() => {
        'roleExtensionId': roleExtensionId,
        'roleId': roleId,
        'displayName': displayName,
        'area': area,
        'filter': filter,
        'rootNodeId': rootNodeId,
        'nodeId': nodeId,
        'accessRight': accessRight
      };
}
