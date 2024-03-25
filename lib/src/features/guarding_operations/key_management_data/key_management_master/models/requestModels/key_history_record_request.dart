import 'package:db_atom/index.dart';

class KeyHistoryRecordRequest {
  KeyHistoryModel? keyLossGi;

  KeyHistoryRecordRequest({
    this.keyLossGi,
  });

  KeyHistoryRecordRequest.fromJson(Map<String, dynamic> json)
      : keyLossGi = (json['keyLossGi'] as Map<String, dynamic>?) != null
            ? KeyHistoryModel.fromJson(
                json['keyLossGi'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'keyLossGi': keyLossGi?.toJson()};
}
class KeyHistoryModel {
  int? id;
  User? createdBy;
  String? createdDate;
  int? status;
  int? keyType;
  int? type;
  String? slNo;
  User? srh;
  String? lostKeyDetails;
  User? securityManager;
  Organisation? destructionReason;
  int? noOfKeys;
  String? additionalInformation;
  bool? investigationRequired;

  KeyHistoryModel({
    this.id,
    this.createdBy,
    this.createdDate,
    this.status,
    this.keyType,
    this.type,
    this.slNo,
    this.srh,
    this.lostKeyDetails,
    this.securityManager,
    this.destructionReason,
    this.noOfKeys,
    this.additionalInformation,
    this.investigationRequired = false,
  });

  KeyHistoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        createdBy = (json['createdBy'] as Map<String,dynamic>?) != null ? User.fromJson(json['createdBy'] as Map<String,dynamic>) : null,
        createdDate = json['createdDate'] as String?,
        status = json['status'] as int?,
        keyType = json['keyType'] as int?,
        type = json['type'] as int?,
        slNo = json['slNo'] as String?,
        srh = (json['srh'] as Map<String,dynamic>?) != null ? User.fromJson(json['srh'] as Map<String,dynamic>) : null,
        lostKeyDetails = json['lostKeyDetails'] as String?,
        securityManager = (json['securityManager'] as Map<String,dynamic>?) != null ? User.fromJson(json['securityManager'] as Map<String,dynamic>) : null,
        destructionReason = (json['destructionReason'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['destructionReason'] as Map<String,dynamic>) : null,
        noOfKeys = json['noOfKeys'] as int?,
        additionalInformation = json['additionalInformation'] as String?,
        investigationRequired = json['investigationRequired'] as bool?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'createdBy' : createdBy?.toJson(),
    'createdDate' : createdDate,
    'status' : status,
    'keyType' : keyType,
    'type' : type,
    'slNo' : slNo,
    'srh' : srh?.toJson(),
    'lostKeyDetails' : lostKeyDetails,
    'securityManager' : securityManager?.toJson(),
    'destructionReason' : destructionReason?.toJson(),
    'noOfKeys' : noOfKeys,
    'additionalInformation' : additionalInformation,
    'investigationRequired' : investigationRequired
  };
}