import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/key_management_master_model.dart';

class KeyHistoryRecordRequest {
  KeyManagementMasterModel? keyLossGi;

  KeyHistoryRecordRequest({
    this.keyLossGi,
  });

  KeyHistoryRecordRequest.fromJson(Map<String, dynamic> json)
      : keyLossGi = (json['keyLossGi'] as Map<String, dynamic>?) != null
            ? KeyManagementMasterModel.fromJson(
                json['keyLossGi'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'keyLossGi': keyLossGi?.toJson()};
}
class KeyHistoryRequestModel {
  final int? id;
  final CreatedBy? createdBy;
  final String? createdDate;
  final int? status;
  final int? keyType;
  final int? type;
  final String? slNo;
  final Srh? srh;
  final String? lostKeyDetails;
  final SecurityManager? securityManager;
  final DestructionReason? destructionReason;
  final int? noOfKeys;
  final String? additionalInformation;
  final bool? investigationRequired;

  KeyHistoryRequestModel({
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
    this.investigationRequired,
  });

  KeyHistoryRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        createdBy = (json['createdBy'] as Map<String,dynamic>?) != null ? CreatedBy.fromJson(json['createdBy'] as Map<String,dynamic>) : null,
        createdDate = json['createdDate'] as String?,
        status = json['status'] as int?,
        keyType = json['keyType'] as int?,
        type = json['type'] as int?,
        slNo = json['slNo'] as String?,
        srh = (json['srh'] as Map<String,dynamic>?) != null ? Srh.fromJson(json['srh'] as Map<String,dynamic>) : null,
        lostKeyDetails = json['lostKeyDetails'] as String?,
        securityManager = (json['securityManager'] as Map<String,dynamic>?) != null ? SecurityManager.fromJson(json['securityManager'] as Map<String,dynamic>) : null,
        destructionReason = (json['destructionReason'] as Map<String,dynamic>?) != null ? DestructionReason.fromJson(json['destructionReason'] as Map<String,dynamic>) : null,
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

class CreatedBy {
  final int? userId;
  final String? userName;
  final String? email;
  final String? firstName;
  final String? lastName;

  CreatedBy({
    this.userId,
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
  });

  CreatedBy.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int?,
        userName = json['userName'] as String?,
        email = json['email'] as String?,
        firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?;

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'userName' : userName,
    'email' : email,
    'firstName' : firstName,
    'lastName' : lastName
  };
}

class Srh {
  final int? userId;
  final String? userName;
  final String? email;
  final String? firstName;
  final String? lastName;

  Srh({
    this.userId,
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
  });

  Srh.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int?,
        userName = json['userName'] as String?,
        email = json['email'] as String?,
        firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?;

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'userName' : userName,
    'email' : email,
    'firstName' : firstName,
    'lastName' : lastName
  };
}

class SecurityManager {
  final int? userId;
  final String? userName;
  final String? email;
  final String? firstName;
  final String? lastName;

  SecurityManager({
    this.userId,
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
  });

  SecurityManager.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int?,
        userName = json['userName'] as String?,
        email = json['email'] as String?,
        firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?;

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'userName' : userName,
    'email' : email,
    'firstName' : firstName,
    'lastName' : lastName
  };
}

class DestructionReason {
  final int? id;
  final String? name;
  final String? keyname;
  final String? description;

  DestructionReason({
    this.id,
    this.name,
    this.keyname,
    this.description,
  });

  DestructionReason.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        keyname = json['keyname'] as String?,
        description = json['description'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'keyname' : keyname,
    'description' : description
  };
}