import 'package:db_atom/index.dart';

part 'key_management_master_model.g.dart';

class KeyManagementMasterResponse {
  final List<KeyManagementMasterModel>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

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

  Map<String, dynamic> toJson() => {
        'data': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

@JsonSerializable()
class KeyManagementMasterModel {
  String? keyManagementId;
  int? id;
  String? slNo;
  User? createdBy;
  List<Organisation>? entities;
  Organisation? location;
  Organisation? region;
  Organisation? destructionReason;
  String? floor;
  Organisation? doorType;
  String? doorName;
  bool doorAccessControl;
  bool doorLockKey;
  bool investigationRequired;
  String? keyNo;
  int? keyTagging;
  int? keyType;
  int? type;
  int? noKeys;
  int? noOfKeys;
  int? noKeysIssued;
  dynamic available;
  dynamic returned;
  dynamic notReturned;
  dynamic lost;
  dynamic damaged;
  int? noMasterKey;
  dynamic noKeysIssuedMaster;
  dynamic availableMaster;
  dynamic returnedMaster;
  dynamic notReturnedMaster;
  dynamic lostMaster;
  dynamic damagedMaster;
  dynamic total;
  String? keysStored;
  String? createdDate;
  dynamic modifiedDate;
  dynamic modifiedBy;
  List<dynamic>? lockChanged;
  List<dynamic>? loss;
  List<dynamic>? damage;
  List<dynamic>? destroy;
  int? status;
  User? srh;
  User? securityManager;
  String? additionalInformation;
  String? lostKeyDetails;

  KeyManagementMasterModel({
    this.keyManagementId,
    this.id,
    this.slNo,
    this.createdBy,
    this.entities,
    this.location,
    this.region,
    this.floor,
    this.doorType,
    this.doorName,
    this.doorAccessControl = false,
    this.doorLockKey = false,
    this.investigationRequired = false,
    this.keyNo,
    this.keyTagging,
    this.noKeys,
    this.noKeysIssued,
    this.available,
    this.returned,
    this.notReturned,
    this.lost,
    this.damaged,
    this.noMasterKey,
    this.noKeysIssuedMaster,
    this.availableMaster,
    this.returnedMaster,
    this.notReturnedMaster,
    this.lostMaster,
    this.damagedMaster,
    this.total,
    this.keysStored,
    this.createdDate,
    this.modifiedDate,
    this.modifiedBy,
    this.lockChanged,
    this.loss,
    this.damage,
    this.destroy,
    this.status,
    this.keyType,
    this.type,
    this.srh,
    this.noOfKeys,
    this.additionalInformation,
    this.lostKeyDetails,
    this.securityManager,
    this.destructionReason,
  });

  factory KeyManagementMasterModel.fromJson(Map<String, dynamic> json) =>
      _$KeyManagementMasterModelFromJson(json);

  Map<String, dynamic> toJson() => _$KeyManagementMasterModelToJson(this);

}
