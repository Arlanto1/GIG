import 'package:db_atom/index.dart';

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

class KeyManagementMasterModel {
  String? keyManagementId;
  int? id;
  String? slNo;
  User? createdBy;
  List<Organisation>? entities;
  Organisation? location;
  Organisation? region;
  String? floor;
  dynamic doorType;
  String? doorName;
  bool doorAccessControl;
  bool doorLockKey;
  String? keyNo;
  int? keyTagging;
  dynamic noKeys;
  dynamic noKeysIssued;
  dynamic available;
  dynamic returned;
  dynamic notReturned;
  dynamic lost;
  dynamic damaged;
  dynamic noMasterKey;
  dynamic noKeysIssuedMaster;
  dynamic availableMaster;
  dynamic returnedMaster;
  dynamic notReturnedMaster;
  dynamic lostMaster;
  dynamic damagedMaster;
  dynamic total;
  String? keysStored;
  int? createdDate;
  dynamic modifiedDate;
  dynamic modifiedBy;
  List<dynamic>? lockChanged;
  List<dynamic>? loss;
  List<dynamic>? damage;
  List<dynamic>? destroy;
  int? status;

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
  });

  KeyManagementMasterModel.fromJson(Map<String, dynamic> json)
      : keyManagementId = json['keyManagementId'] as String?,
        id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        createdBy = (json['createdBy'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['createdBy'] as Map<String, dynamic>)
            : null,
        entities = (json['entities'] as List<dynamic>?)
            ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
            .toList(),
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        region = (json['region'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['region'] as Map<String, dynamic>)
            : null,
        floor = json['floor'] as String?,
         doorType = json['doorType'],
        doorName = json['doorName'] as String?,
        doorAccessControl = json['doorAccessControl'] as bool,
        doorLockKey = json['doorLockKey'] as bool,
        keyNo = json['keyNo'] as String?,
        keyTagging = json['keyTagging'] as int?,
        noKeys = json['noKeys'],
        noKeysIssued = json['noKeysIssued'],
        available = json['available'],
        returned = json['returned'],
        notReturned = json['notReturned'],
        lost = json['lost'],
        damaged = json['damaged'],
        noMasterKey = json['noMasterKey'],
        noKeysIssuedMaster = json['noKeysIssuedMaster'],
        availableMaster = json['availableMaster'],
        returnedMaster = json['returnedMaster'],
        notReturnedMaster = json['notReturnedMaster'],
        lostMaster = json['lostMaster'],
        damagedMaster = json['damagedMaster'],
        total = json['total'],
        keysStored = json['keysStored'] as String?,
        createdDate = json['createdDate'] as int?,
        modifiedDate = json['modifiedDate'],
        modifiedBy = json['modifiedBy'],
        lockChanged = json['lockChanged'] as List?,
        loss = json['loss'] as List?,
        damage = json['damage'] as List?,
        destroy = json['destroy'] as List?,
        status = json['status'] as int?;

  Map<String, dynamic> toJson() => {
        'keyManagementId': keyManagementId,
        'id': id,
        'slNo': slNo,
        'createdBy': createdBy?.toJson(),
        'floor': floor,
        'entities': entities?.map((e) => e.toJson()).toList(),
        'location': location?.toJson(),
        'region': region?.toJson(),
        'doorType': doorType,
        'doorName': doorName,
        'doorAccessControl': doorAccessControl,
        'doorLockKey': doorLockKey,
        'keyNo': keyNo,
        'keyTagging': keyTagging,
        'noKeys': noKeys,
        'noKeysIssued': noKeysIssued,
        'available': available,
        'returned': returned,
        'notReturned': notReturned,
        'lost': lost,
        'damaged': damaged,
        'noMasterKey': noMasterKey,
        'noKeysIssuedMaster': noKeysIssuedMaster,
        'availableMaster': availableMaster,
        'returnedMaster': returnedMaster,
        'notReturnedMaster': notReturnedMaster,
        'lostMaster': lostMaster,
        'damagedMaster': damagedMaster,
        'total': total,
        'keysStored': keysStored,
        'createdDate': createdDate,
        'modifiedDate': modifiedDate,
        'modifiedBy': modifiedBy,
        'lockChanged': lockChanged,
        'loss': loss,
        'damage': damage,
        'destroy': destroy,
        'status': status
      };
}
