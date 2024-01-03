import 'dart:core';

import 'package:db_atom/index.dart';

part 'key_management_master_model.g.dart';

class KeyManagementMasterResponse {
  List<KeyManagementMasterModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  KeyManagementMasterResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  KeyManagementMasterResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
      ?.map((dynamic e) =>
      KeyManagementMasterModel.fromJson(e as Map<String, dynamic>))
      .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() =>
      {
        'data': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

@JsonSerializable()
class KeyManagementMasterModel extends BaseObject {
    int? id;
    String? slNo;
    Organisation? location;
    Organisation? region;
    User? createdBy;
    int? status;
    String? createdDate;
    List<Organisation>? entities;
    String? floor;
    Organisation? doorType;
    String? doorName;
    bool? doorAccessControl;
    bool? doorLockKey;
    String? keyNo;
    int? keyTagging;
    int? noKeys;
    int? noMasterKey;
    int? total;
    String? keysStored;
    String? modifiedDate;
    String? modifiedBy;


  KeyManagementMasterModel({
     this.id,
     this.slNo,
     this.location,
     this.region,
     this.createdBy,
     this.status,
     this.createdDate,
     this.entities,
     this.floor,
     this.doorType,
     this.doorName,
     this.doorAccessControl,
     this.doorLockKey,
     this.keyNo,
     this.keyTagging,
     this.noKeys,
     this.noMasterKey,
     this.total,
     this.keysStored,
     this.modifiedDate,
     this.modifiedBy,
  });

  factory KeyManagementMasterModel.fromJson(Map<String, dynamic> json) =>
      _$KeyManagementMasterModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$KeyManagementMasterModelToJson(this);
}
