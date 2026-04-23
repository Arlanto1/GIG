import 'package:db_atom/index.dart';

part 'patrolling_other_model.g.dart';

class PatrollingOtherModelResponse {
  List<PatrollingOtherModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  PatrollingOtherModelResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  PatrollingOtherModelResponse.fromJson(Map<String, dynamic> json)
      : items = (json['list'] as List?)
            ?.map((dynamic e) =>
                PatrollingOtherModel.fromJson(e as Map<String, dynamic>))
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
class PatrollingOtherModel extends BaseObject {
  int? subsectionId;
  String? subsectionName;
  int? fromSequence;
  int? toSequence;
  int? totalQuestions;
  String? slNo;
  int? status;
  String? inputDate;
  String? submittedDate;
  String? verifiedDate;
  String? closedDate;
  int? locationId;
  String? locationName;
  int? regionId;
  String? regionName;
  int? entityId;
  String? entityName;
  int? entrySecurityId;
  String? entrySecurityName;
  int? securitySupervisorId;
  String? securitySupervisorName;
  int? lsmId;
  String? lsmName;
  List<Items>? items;

  PatrollingOtherModel({
    this.subsectionId,
    this.subsectionName,
    this.fromSequence,
    this.toSequence,
    this.totalQuestions,
    this.slNo,
    this.status,
    this.inputDate,
    this.submittedDate,
    this.verifiedDate,
    this.closedDate,
    this.locationId,
    this.locationName,
    this.regionId,
    this.regionName,
    this.entityId,
    this.entityName,
    this.entrySecurityId,
    this.entrySecurityName,
    this.securitySupervisorId,
    this.securitySupervisorName,
    this.lsmId,
    this.lsmName,
    this.items,
  });

  factory PatrollingOtherModel.fromJson(Map<String, dynamic> json) =>
      _$PatrollingOtherModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PatrollingOtherModelToJson(this);
}

class Items {
  int? id;
  int? sequenceNo;
  String? question;
  int? response;
  String? responseLabel;
  bool? isException;
  String? remarks;
  String? ownerType;
  int? severity;
  User? actionOwner;
  int? actionOwnerId;
  String? actionOwnerName;
  String? eta;
  String? revisedEta;
  String? ownerUpdates;
  User? dbSponsor;
  int? dbSponsorId;
  String? dbSponsorName;
  int? progressStatus;
  int? reviewStatus;
  String? reviewComment;
  List<ImageContent>? attachments;
  bool? canEditGuardFields;
  bool? canEditLsmFields;
  bool? canEditOwnerFields;
  bool? canEditEta;
  bool? canReview;

  Items({
    this.id,
    this.sequenceNo,
    this.question,
    this.response,
    this.responseLabel,
    this.isException,
    this.remarks,
    this.ownerType,
    this.severity,
    this.actionOwnerId,
    this.actionOwnerName,
    this.eta,
    this.revisedEta,
    this.ownerUpdates,
    this.dbSponsor,
    this.dbSponsorId,
    this.dbSponsorName,
    this.progressStatus,
    this.reviewStatus,
    this.reviewComment,
    this.attachments,
    this.canEditGuardFields = false,
    this.canEditLsmFields = false,
    this.canEditOwnerFields = false,
    this.canEditEta = false,
    this.canReview = false,
  });

  Items.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        sequenceNo = json['sequenceNo'] as int?,
        question = json['question'] as String?,
        response = json['response'] as int?,
        responseLabel = json['responseLabel'] as String?,
        isException = json['isException'] as bool?,
        remarks = json['remarks'] as String?,
        ownerType = json['ownerType'] as String?,
        severity = json['severity'] as int?,
        actionOwner = (json['actionOwner'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['actionOwner'] as Map<String, dynamic>)
            : null,
        actionOwnerId = json['actionOwnerId'] as int?,
        actionOwnerName = json['actionOwnerName'] as String?,
        attachments = (json['attachments'] as List?)
            ?.map(
                (dynamic e) => ImageContent.fromJson(e as Map<String, dynamic>))
            .toList(),
        dbSponsor = (json['dbSponsor'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['dbSponsor'] as Map<String, dynamic>)
            : null,
        dbSponsorId = json['dbSponsorId'] as int?,
        dbSponsorName = json['dbSponsorName'] as String?,
        progressStatus = json['progressStatus'] as int?,
        reviewStatus = json['reviewStatus'] as int?,
        reviewComment = json['reviewComment'] as String?,
        eta = json['eta'] as String?,
        ownerUpdates = json['ownerUpdates'] as String?,
        canEditGuardFields = json['canEditGuardFields'] as bool?,
        canEditLsmFields = json['canEditLsmFields'] as bool?,
        canEditOwnerFields = json['canEditOwnerFields'] as bool?,
        canEditEta = json['canEditEta'] as bool?,
        canReview = json['canReview'] as bool?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'sequenceNo': sequenceNo,
        'question': question,
        'response': response,
        'responseLabel': responseLabel,
        'isException': isException,
        'remarks': remarks,
        'ownerType': ownerType,
        'severity': severity,
        'attachments': attachments?.map((e) => e.toJson()).toList() ?? [],
        'actionOwner': actionOwner?.toJson(),
        'actionOwnerId': actionOwnerId,
        'actionOwnerName': actionOwnerName,
        'dbSponsor': dbSponsor?.toJson(),
        'dbSponsorId': dbSponsorId,
        'dbSponsorName': dbSponsorName,
        'progressStatus': progressStatus,
        'reviewStatus': reviewStatus,
        'reviewComment': reviewComment,
        'ownerUpdates': ownerUpdates,
        'eta': eta,
        'canEditGuardFields': canEditGuardFields,
        'canEditLsmFields': canEditLsmFields,
        'canEditOwnerFields': canEditOwnerFields,
        'canEditEta': canEditEta,
        'canReview': canReview,

  };
}
