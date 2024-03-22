import 'package:db_atom/index.dart';

part 'key_loss_destruction_list_model.g.dart';

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
   String? keyManagementId;
   int? id;
   String? slNo;
   int? type;
   int? keyType;
   bool? hasLockChanged;
   dynamic keyDestructionProcess;
   dynamic hasKeyLost;
   User? srh;
   User? securityManager;
   bool investigationRequired;
   String? lostKeyDetails;
   String? additionalInformation;
   Organisation? destructionReason;
   int? status;
   int? noOfKeys;
   User? createdBy;
   String? createdDate;
   String? modifiedDate;
   String? modifiedBy;

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
    this.investigationRequired = false,
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
