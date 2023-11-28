import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/models/base_object.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../models/organisation.dart';

part 'sla_violation_penalty_response_model.g.dart';

class SLAViolationPenaltyResponseModel extends BaseObject {
  List<SLAViolationPenaltyModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  SLAViolationPenaltyResponseModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  SLAViolationPenaltyResponseModel.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) =>
                SLAViolationPenaltyModel.fromJson(e as Map<String, dynamic>))
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
class SLAViolationPenaltyModel extends BaseObject {
  int? id;
  String? slNo;
  Organisation? location;
  Organisation? locationRegion;
  String? inputDate;
  User? entrySecurity;
  String? modifiedDate;
  String? modifiedBy;
  int? status;
  List<Organisation>? entities;
  List<Organisation>? vendor;
  List<Organisation>? typeOfService;
  List<String>? poc;

  SLAViolationPenaltyModel({
    this.id,
    this.slNo,
    this.location,
    this.locationRegion,
    this.inputDate,
    this.entrySecurity,
    this.modifiedDate,
    this.modifiedBy,
    this.status,
    this.entities,
    this.vendor,
    this.poc,
    this.typeOfService,
  });

  factory SLAViolationPenaltyModel.fromJson(Map<String, dynamic> json) =>
      _$SLAViolationPenaltyModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SLAViolationPenaltyModelToJson(this);
}
