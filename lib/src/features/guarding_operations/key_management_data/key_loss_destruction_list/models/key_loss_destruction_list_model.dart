import 'package:db_atom/index.dart';
part  'key_loss_destruction_list_model.g.dart';


class KeyLossDestructionListResponse {
  List<KeyLossDestructionListModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  KeyLossDestructionListResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  KeyLossDestructionListResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
      ?.map((dynamic e) =>
      KeyLossDestructionListModel.fromJson(e as Map<String, dynamic>))
      .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
    'data': items?.map((e) => e.toJson()).toList(),
    'totalCount': totalCount,
    'currentPageNo': currentPageNo,
    'totalPageCount': totalPageCount
  };
}

@JsonSerializable()
class KeyLossDestructionListModel extends BaseObject {
   final String? keyManagementId;
   final int? id;
   final dynamic slNo;
   final int? type;
   final int? keyType;
   final bool? hasLockChanged;
   final dynamic keyDestructionProcess;
   final dynamic hasKeyLost;
   final  dynamic srh;
   final dynamic securityManager;
   final bool? investigationRequired;
   final String? lostKeyDetails;
   final String? additionalInformation;
   final dynamic destructionReason;
   final int? status;
   final int? noOfKeys;
   final User? createdBy;
   final int? createdDate;
   final int? modifiedDate;
   final String? modifiedBy;

  KeyLossDestructionListModel({
  this.keyManagementId,
  this.id,
  this.slNo,
  this.type,
  this.keyType,
  this.hasLockChanged,
  this.keyDestructionProcess,
  this.hasKeyLost,
  this.srh,
  this.securityManager,
  this.investigationRequired,
  this.lostKeyDetails,
  this.additionalInformation,
  this.destructionReason,
  this.status,
  this.noOfKeys,
  this.createdBy,
  this.createdDate,
  this.modifiedDate,
  this.modifiedBy,
  });

  factory KeyLossDestructionListModel.fromJson(Map<String, dynamic> json) =>
      _$KeyLossDestructionListModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$KeyLossDestructionListModelToJson(this);
}

