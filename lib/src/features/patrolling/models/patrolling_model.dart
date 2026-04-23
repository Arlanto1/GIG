import 'package:db_atom/src/models/history.dart';

import '../../../../index.dart';

part 'patrolling_model.g.dart';

class PatrollingModelResponse {
  final List<PatrollingModel>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  PatrollingModelResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  PatrollingModelResponse.fromJson(Map<String, dynamic> json)
      : items = (json['list'] as List?)
      ?.map((dynamic e) =>
      PatrollingModel.fromJson(e as Map<String, dynamic>))
      .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
    'list': items?.map((e) => e.toJson()).toList(),
    'totalCount': totalCount,
    'currentPageNo': currentPageNo,
    'totalPageCount': totalPageCount
  };
}

  @JsonSerializable()
  class PatrollingModel extends BaseObject {
    int? id;
  int? subsectionId;
  String? slNo;
  String? inputDate;
  Organisation? location;
  Organisation? locationRegion;
  Organisation? entity;
  User? entrySecurity;
  int? status;
  String? modifiedBy;
  String? modifiedDate;
  String?  submittedDate;
  String? verifiedDate;
  List<History>? history;
  User? lsm;
  User? securitySupervisor;
  int? shift;

  PatrollingModel({
    this.id,
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.entity,
    this.entrySecurity,
    this.status,
    this.modifiedBy,
    this.modifiedDate,
    this.history,
    this.lsm,
    this.securitySupervisor,
    this.shift,
    this.submittedDate,
    this.verifiedDate
  });

  factory PatrollingModel.fromJson(Map<String, dynamic> json) =>
      _$PatrollingModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PatrollingModelToJson(this);
}
