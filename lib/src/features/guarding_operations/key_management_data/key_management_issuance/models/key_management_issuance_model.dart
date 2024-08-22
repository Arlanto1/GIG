// import 'package:db_atom/src/features/createfound/models/user.dart';
// import 'package:db_atom/src/models/base_object.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// import '../../../../../models/organisation.dart';
//
// part 'key_management_issuance_model.g.dart';
//
// class KeyManagementIssuanceResponseModel extends BaseObject {
//   List<KeyManagementIssuanceModel>? items;
//   int? totalCount;
//   int? currentPageNo;
//   int? totalPageCount;
//
//   KeyManagementIssuanceResponseModel({
//     this.items,
//     this.totalCount,
//     this.currentPageNo,
//     this.totalPageCount,
//   });
//
//   KeyManagementIssuanceResponseModel.fromJson(Map<String, dynamic> json)
//       : items = (json['data'] as List?)
//             ?.map((dynamic e) =>
//                 KeyManagementIssuanceModel.fromJson(e as Map<String, dynamic>))
//             .toList(),
//         totalCount = json['totalCount'] as int?,
//         currentPageNo = json['currentPageNo'] as int?,
//         totalPageCount = json['totalPageCount'] as int?;
//
//   @override
//   Map<String, dynamic> toJson() => {
//         'data': items?.map((e) => e.toJson()).toList(),
//         'totalCount': totalCount,
//         'currentPageNo': currentPageNo,
//         'totalPageCount': totalPageCount
//       };
// }
//
// @JsonSerializable()
// class KeyManagementIssuanceModel extends BaseObject {
//    int? id;
//    User? createdBy;
//    String? createdDate;
//    int? status;
//    String? keyHandOverDate;
//    Organisation? location;
//    String? slNo;
//    List<Organisation>? entities;
//    Organisation? department;
//    int? keyHandingOverDuration;
//    String? keyHandOverDue;
//    int? employeeType;
//    String? employeeID;
//    User? handedOverTo;
//    User? dbSponsorCwrT2;
//    String? keyReturnDateTime;
//    String? returnedByName;
//    String? modifiedDate;
//    String? modifiedBy;
//
//   KeyManagementIssuanceModel(
//       {
//         this.id,
//         this.createdBy,
//         this.createdDate,
//         this.status,
//         this.keyHandOverDate,
//         this.location,
//         this.slNo,
//         this.entities,
//         this.department,
//         this.keyHandingOverDuration,
//         this.keyHandOverDue,
//         this.employeeType,
//         this.employeeID,
//         this.handedOverTo,
//         this.dbSponsorCwrT2,
//         this.keyReturnDateTime,
//         this.returnedByName,
//         this.modifiedDate,
//         this.modifiedBy,
//        });
//
//   factory KeyManagementIssuanceModel.fromJson(Map<String, dynamic> json) =>
//       _$KeyManagementIssuanceModelFromJson(json);
//
//   @override
//   Map<String, dynamic> toJson() => _$KeyManagementIssuanceModelToJson(this);
// }
import 'package:db_atom/index.dart';

class KeyManagementIssuanceResponseModel {
  final List<KeyManagementIssuanceModel>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

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

  Map<String, dynamic> toJson() => {
        'items': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

class KeyManagementIssuanceModel {
  String? kMIssuanceId;
  int? id;
  String? slNo;
  Organisation? location;
  dynamic region;
  User? createdBy;
  int? keyHandingOverDuration;
  String? keyHandOverDate;
  String? keyHandOverDue;
  int? employeeType;
  dynamic handedOverTo;
  dynamic handedOverToCwrT2;
  User? dbSponsorCwrT2;
  String? employeeID;
  dynamic department;
  ImageContent? receiverSign;
  dynamic keyReturnDateTime;
  String? returnedByName;
  ImageContent? securitySign;
  String? createdDate;
  String? modifiedDate;
  String? modifiedBy;
  int? status;
  int? totalAllocated;
  int? totalReturned;
  int? totalNotReturned;
  int? totalLost;
  int? totalDamage;
  List<Organisation>? entities;
  String? lock;

  KeyManagementIssuanceModel({
    this.kMIssuanceId,
    this.id,
    this.slNo,
    this.location,
    this.createdBy,
    this.keyHandingOverDuration,
    this.keyHandOverDate,
    this.keyHandOverDue,
    this.employeeType,
    this.handedOverTo,
    this.handedOverToCwrT2,
    this.dbSponsorCwrT2,
    this.employeeID,
    this.department,
    this.receiverSign,
    this.keyReturnDateTime,
    this.returnedByName,
    this.securitySign,
    this.createdDate,
    this.modifiedDate,
    this.modifiedBy,
    this.status,
    this.totalAllocated,
    this.totalReturned,
    this.totalNotReturned,
    this.totalLost,
    this.totalDamage,
    this.entities,
    this.lock,
  });

  KeyManagementIssuanceModel.fromJson(Map<String, dynamic> json)
      : kMIssuanceId = json['kMIssuanceId'] as String?,
        id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        createdBy = (json['createdBy'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['createdBy'] as Map<String, dynamic>)
            : null,
        keyHandingOverDuration = json['keyHandingOverDuration'] as int?,
        keyHandOverDate = json['keyHandOverDate'] as String?,
        keyHandOverDue = json['keyHandOverDue'] as String?,
        employeeType = json['employeeType'] as int?,
        handedOverTo = (json['handedOverTo'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['handedOverTo'] as Map<String, dynamic>)
            : null,
        handedOverToCwrT2 = json['handedOverToCwrT2'] as String?,
        dbSponsorCwrT2 =
            (json['dbSponsorCwrT2'] as Map<String, dynamic>?) != null
                ? User.fromJson(json['dbSponsorCwrT2'] as Map<String, dynamic>)
                : null,
        employeeID = json['employeeID'] as String?,
        department = (json['department'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['department'] as Map<String, dynamic>)
            : null,
        receiverSign = json['receiverSign'] == null
            ? null
            : ImageContent.fromJson(
                json['receiverSign'] as Map<String, dynamic>),
        keyReturnDateTime = json['keyReturnDateTime'] as String?,
        returnedByName = json['returnedByName'] as String?,
        securitySign = json['securitySign'] == null
            ? null
            : ImageContent.fromJson(
                json['securitySign'] as Map<String, dynamic>),
        createdDate = json['createdDate'] as String?,
        modifiedDate = json['modifiedDate'] as String?,
        modifiedBy = json['modifiedBy'] as String?,
        status = json['status'] as int?,
        totalAllocated = json['totalAllocated'] as int?,
        totalReturned = json['totalReturned'] as int?,
        totalNotReturned = json['totalNotReturned'] as int?,
        totalLost = json['totalLost'] as int?,
        totalDamage = json['totalDamage'] as int?,
        entities = (json['entities'] as List?)
            ?.map(
                (dynamic e) => Organisation.fromJson(e as Map<String, dynamic>))
            .toList(),
        lock = json['lock'] as String?;

  Map<String, dynamic> toJson() => {
        'kMIssuanceId': kMIssuanceId,
        'id': id,
        'slNo': slNo,
        'location': location?.toJson(),
        'createdBy': createdBy?.toJson(),
        'keyHandingOverDuration': keyHandingOverDuration,
        'keyHandOverDate': keyHandOverDate,
        'keyHandOverDue': keyHandOverDue,
        'employeeType': employeeType,
        'handedOverTo': handedOverTo?.toJson(),
        'handedOverToCwrT2': handedOverToCwrT2,
        'dbSponsorCwrT2': dbSponsorCwrT2,
        'employeeID': employeeID,
        'department': department?.toJson(),
        'receiverSign': receiverSign?.toJson(),
        'keyReturnDateTime': keyReturnDateTime,
        'returnedByName': returnedByName,
        'securitySign': securitySign?.toJson(),
        'createdDate': createdDate,
        'entities': entities,
        'modifiedDate': modifiedDate,
        'modifiedBy': modifiedBy,
        'status': status,
        'totalAllocated': totalAllocated,
        'totalReturned': totalReturned,
        'totalNotReturned': totalNotReturned,
        'totalLost': totalLost,
        'totalDamage': totalDamage,
        'lock': lock,
      };
}
