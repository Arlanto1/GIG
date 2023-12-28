import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/models/base_object.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../models/organisation.dart';

part 'key_management_issuance_model.g.dart';

class KeyManagementIssuanceResponseModel extends BaseObject {
  List<KeyManagementIssuanceModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  KeyManagementIssuanceResponseModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  KeyManagementIssuanceResponseModel.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) =>
                KeyManagementIssuanceModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  @override
  Map<String, dynamic> toJson() => {
        'data': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

@JsonSerializable()
class KeyManagementIssuanceModel extends BaseObject {
  int? id;
  String? slNo;
  Organisation? location;
  Organisation? locationRegion;
  String? inputDate;
  User? entrySecurity;
  int? status;
  int? employeeType;
  int? keyHandingOverDuration;
  Organisation? vendor;
  List<Organisation>? typeOfService;
  List<Organisation>? entity;
  User? approver;
  String? employeeId;

  KeyManagementIssuanceModel(
      {this.id,
      this.slNo,
      this.location,
      this.locationRegion,
      this.inputDate,
      this.entrySecurity,
      this.status,
      this.entity,
      this.vendor,
      this.employeeId,
      this.typeOfService,
      this.approver,
      this.employeeType,
      this.keyHandingOverDuration});

  factory KeyManagementIssuanceModel.fromJson(Map<String, dynamic> json) =>
      _$KeyManagementIssuanceModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$KeyManagementIssuanceModelToJson(this);
}
