import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/models/violation_penalty_model.dart';
import 'package:db_atom/src/models/base_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'violation_penalty_list_response_model.g.dart';

class ViolationPenaltyListResponseModel extends BaseObject {
  List<ViolationPenaltyListModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  ViolationPenaltyListResponseModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  ViolationPenaltyListResponseModel.fromJson(Map<String, dynamic> json)
      : items = (json[''] as List?)
      ?.map((dynamic e) =>
      ViolationPenaltyListModel.fromJson(e as Map<String, dynamic>))
      .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  @override
  Map<String, dynamic> toJson() => {
    '': items?.map((e) => e.toJson()).toList(),
    'totalCount': totalCount,
    'currentPageNo': currentPageNo,
    'totalPageCount': totalPageCount
  };
}

@JsonSerializable()
class ViolationPenaltyListModel extends BaseObject {
  final List<ViolationPenaltyRecord>? violationPenalties;

  ViolationPenaltyListModel({
    this.violationPenalties,
  });

  factory ViolationPenaltyListModel.fromJson(Map<String, dynamic> json) =>
      _$ViolationPenaltyListModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ViolationPenaltyListModelToJson(this);
}

