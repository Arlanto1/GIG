// class SelfPacedTrainingModuleResponseModel {
//   List<SelfPacedTrainingModel>? items;
//   int? totalCount;
//   int? currentPageNo;
//   int? totalPageCount;
//
//   SelfPacedTrainingModuleResponseModel({
//     this.items,
//     this.totalCount,
//     this.currentPageNo,
//     this.totalPageCount,
//   });
//
//   SelfPacedTrainingModuleResponseModel.fromJson(Map<String, dynamic> json)
//       : items = (json['list'] as List?)
//       ?.map((dynamic e) =>
//       SelfPacedTrainingModel.fromJson(e as Map<String, dynamic>))
//       .toList(),
//         totalCount = json['totalCount'] as int?,
//         currentPageNo = json['currentPageNo'] as int?,
//         totalPageCount = json['totalPageCount'] as int?;
//
//   Map<String, dynamic> toJson() => {
//     'list': items?.map((e) => e.toJson()).toList(),
//     'totalCount': totalCount,
//     'currentPageNo': currentPageNo,
//     'totalPageCount': totalPageCount
//   };
// }
//
// class SelfPacedTrainingModel {
//    int? id;
//    String? title;
//    String? description;
//    String? trainingMaterial;
//    String? trainingMaterialContentType;
//    Null trainingMaterialContent;
//    String? assessmentLink;
//    int? assessmentId;
//    String? launchDate;
//    String? dueDate;
//    int? passingScore;
//    String? status;
//    String? creatorName;
//    String? creatorEmail;
//    String? creationDate;
//    String? modificatorName;
//    String? modificationDate;
//    List<TrainingGroups>? trainingGroups;
//    List<Recipients>? recipients;
//    List<MisRows>? misRows;
//    String? questionnaireName;
//    String? groupSummary;
//    int? learnerCount;
//    int? averageScore;
//    int? passRate;
//    List<int>? selectedGroupIds;
//    List<dynamic>? selectedGroups;
//
//   SelfPacedTrainingModel({
//      this.id,
//      this.title,
//      this.description,
//      this.trainingMaterial,
//      this.trainingMaterialContentType,
//     this.trainingMaterialContent,
//      this.assessmentLink,
//     this.assessmentId,
//      this.launchDate,
//      this.dueDate,
//      this.passingScore,
//      this.status,
//      this.creatorName,
//      this.creatorEmail,
//      this.creationDate,
//      this.modificatorName,
//      this.modificationDate,
//      this.trainingGroups,
//      this.recipients,
//      this.misRows,
//      this.questionnaireName,
//      this.groupSummary,
//      this.learnerCount,
//      this.averageScore,
//      this.passRate,
//      this.selectedGroupIds,
//      this.selectedGroups,
//   });
//
//   SelfPacedTrainingModel.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//    title = json['title'] as String?,
//    description = json['description'] as String?,
//    trainingMaterial = json['trainingMaterial'] as String?,
//    trainingMaterialContentType = json['trainingMaterialContentType'] as String?,
//    trainingMaterialContent = json['trainingMaterialContent'] as Null,
//    assessmentLink = json['assessmentLink'] as String?,
//    assessmentId = json['assessmentId'] as int?,
//    launchDate = json['launchDate'] as String?,
//    dueDate = json['dueDate'] as String?,
//    passingScore = json['passingScore'] as int?,
//    status = json['status'] as String?,
//    creatorName = json['creatorName'] as String?,
//    creatorEmail = json['creatorEmail'] as String?,
//    creationDate = json['creationDate'] as String?,
//    modificatorName = json['modificatorName'] as String?,
//    modificationDate = json['modificationDate'] as String?,
//    trainingGroups = (json['trainingGroups'] as List<dynamic>?)
//        ?.map((x) => TrainingGroups.fromJson(x as Map<String, dynamic>))
//        .toList(),
//    recipients = (json['recipients'] as List<dynamic>?)
//        ?.map((x) => Recipients.fromJson(x as Map<String, dynamic>))
//        .toList(),
//    misRows = (json['misRows'] as List<dynamic>?)
//        ?.map((x) => MisRows.fromJson(x as Map<String, dynamic>))
//        .toList(),
//    questionnaireName = json['questionnaireName'] as String?,
//    groupSummary = json['groupSummary'] as String?,
//    learnerCount = json['learnerCount'] as int?,
//    averageScore = json['averageScore'] as int?,
//    passRate = json['passRate'] as int?,
//    selectedGroupIds = (json['selectedGroupIds'] as List<dynamic>?)
//        ?.map((x) => x as int)
//        .toList(),
//         selectedGroups = (json['selectedGroups'] as List<dynamic>?)
//             ?.map((x) => x as int)
//             .toList();
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'title' : title,
//     'description' : description,
//     'trainingMaterial' : trainingMaterial,
//     'trainingMaterialContentType' : trainingMaterialContentType,
//     'trainingMaterialContent' : trainingMaterialContent,
//     'assessmentLink' : assessmentLink,
//     'assessmentId' : assessmentId,
//     'launchDate' : launchDate,
//     'dueDate' : dueDate,
//     'passingScore' : passingScore,
//     'status' : status,
//     'creatorName' : creatorName,
//     'creatorEmail' : creatorEmail,
//     'creationDate' : creationDate,
//     'modificatorName' : modificatorName,
//     'modificationDate' : modificationDate,
//     'trainingGroups' : trainingGroups?.map((x) => x.toJson()).toList(),
//     'recipients' : recipients?.map((x) => x.toJson()).toList(),
//     'misRows' : misRows?.map((x) => x.toJson()).toList(),
//     'questionnaireName' : questionnaireName,
//     'groupSummary' : groupSummary,
//     'learnerCount' : learnerCount,
//     'averageScore' : averageScore,
//     'passRate' : passRate,
//     'selectedGroupIds' : selectedGroupIds,
//     'selectedGroups' : selectedGroups,
//   };
// }
//
//
//
//
// class TrainingGroups {
//   TrainingGroups({
//      this.id,
//      this.groupId,
//      this.groupName,
//   });
//    int? id;
//    int? groupId;
//    String? groupName;
//
//   TrainingGroups.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     groupId = json['groupId'];
//     groupName = json['groupName'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['groupId'] = groupId;
//     _data['groupName'] = groupName;
//     return _data;
//   }
// }
//
// class Recipients {
//   Recipients({
//      this.id,
//      this.groupId,
//      this.userId,
//      this.employeeId,
//      this.name,
//      this.email,
//      this.region,
//      this.location,
//      this.inviteeId,
//      this.assessmentAnswerId,
//      this.accessCode,
//      this.mailId,
//     this.mailSentOn,
//     this.submittedOn,
//     this.scorePercent,
//      this.feedbackText,
//      this.resultStatus,
//      this.completionStatus,
//      this.creationDate,
//      this.modificatorName,
//      this.modificationDate,
//   });
//    int? id;
//    int? groupId;
//    int? userId;
//    String? employeeId;
//    String? name;
//    String? email;
//    String? region;
//    String? location;
//    int? inviteeId;
//    int? assessmentAnswerId;
//    String? accessCode;
//    int? mailId;
//    int? mailSentOn;
//    int? submittedOn;
//    int? scorePercent;
//    String? feedbackText;
//    String? resultStatus;
//    String? completionStatus;
//    int? creationDate;
//    String? modificatorName;
//    int? modificationDate;
//
//   Recipients.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     groupId = json['groupId'];
//     userId = json['userId'];
//     employeeId = json['employeeId'];
//     name = json['name'];
//     email = json['email'];
//     region = json['region'];
//     location = json['location'];
//     inviteeId = json['inviteeId'];
//     assessmentAnswerId = json['assessmentAnswerId'];
//     accessCode = json['accessCode'];
//     mailId = json['mailId'];
//     mailSentOn = null;
//     submittedOn = null;
//     scorePercent = null;
//     feedbackText = json['feedbackText'];
//     resultStatus = json['resultStatus'];
//     completionStatus = json['completionStatus'];
//     creationDate = json['creationDate'];
//     modificatorName = json['modificatorName'];
//     modificationDate = json['modificationDate'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['groupId'] = groupId;
//     _data['userId'] = userId;
//     _data['employeeId'] = employeeId;
//     _data['name'] = name;
//     _data['email'] = email;
//     _data['region'] = region;
//     _data['location'] = location;
//     _data['inviteeId'] = inviteeId;
//     _data['assessmentAnswerId'] = assessmentAnswerId;
//     _data['accessCode'] = accessCode;
//     _data['mailId'] = mailId;
//     _data['mailSentOn'] = mailSentOn;
//     _data['submittedOn'] = submittedOn;
//     _data['scorePercent'] = scorePercent;
//     _data['feedbackText'] = feedbackText;
//     _data['resultStatus'] = resultStatus;
//     _data['completionStatus'] = completionStatus;
//     _data['creationDate'] = creationDate;
//     _data['modificatorName'] = modificatorName;
//     _data['modificationDate'] = modificationDate;
//     return _data;
//   }
// }
//
// class MisRows {
//   MisRows({
//      this.id,
//      this.recipientId,
//      this.userId,
//      this.name,
//      this.region,
//      this.location,
//      this.assessmentId,
//      this.assessmentAnswerId,
//      this.accessCode,
//     this.scorePercent,
//     this.retakeThreshold,
//     this.maxAttempts,
//     this.attemptsUsed,
//      this.feedbackText,
//      this.feedbackRatingLabel,
//      this.feedbackComments,
//      this.resultStatus,
//     this.submittedOn,
//     this.lastSyncedOn,
//     this.creationDate,
//      this.modificatorName,
//     this.modificationDate,
//   });
//    int? id;
//    int? recipientId;
//    int? userId;
//    String? name;
//    String? region;
//    String? location;
//    int? assessmentId;
//    int? assessmentAnswerId;
//    String? accessCode;
//    int? scorePercent;
//    int? retakeThreshold;
//    int? maxAttempts;
//    int? attemptsUsed;
//    String? feedbackText;
//    String? feedbackRatingLabel;
//    String? feedbackComments;
//    String? resultStatus;
//    int? submittedOn;
//    int? lastSyncedOn;
//    int? creationDate;
//    String? modificatorName;
//    int? modificationDate;
//
//   MisRows.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     recipientId = json['recipientId'];
//     userId = json['userId'];
//     name = json['name'];
//     region = json['region'];
//     location = json['location'];
//     assessmentId = json['assessmentId'];
//     assessmentAnswerId = json['assessmentAnswerId'];
//     accessCode = json['accessCode'];
//     scorePercent = null;
//     retakeThreshold = null;
//     maxAttempts = null;
//     attemptsUsed = null;
//     feedbackText = json['feedbackText'];
//     feedbackRatingLabel = json['feedbackRatingLabel'];
//     feedbackComments = json['feedbackComments'];
//     resultStatus = json['resultStatus'];
//     submittedOn = null;
//     lastSyncedOn = null;
//     creationDate = null;
//     modificatorName = json['modificatorName'];
//     modificationDate = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['recipientId'] = recipientId;
//     _data['userId'] = userId;
//     _data['name'] = name;
//     _data['region'] = region;
//     _data['location'] = location;
//     _data['assessmentId'] = assessmentId;
//     _data['assessmentAnswerId'] = assessmentAnswerId;
//     _data['accessCode'] = accessCode;
//     _data['scorePercent'] = scorePercent;
//     _data['retakeThreshold'] = retakeThreshold;
//     _data['maxAttempts'] = maxAttempts;
//     _data['attemptsUsed'] = attemptsUsed;
//     _data['feedbackText'] = feedbackText;
//     _data['feedbackRatingLabel'] = feedbackRatingLabel;
//     _data['feedbackComments'] = feedbackComments;
//     _data['resultStatus'] = resultStatus;
//     _data['submittedOn'] = submittedOn;
//     _data['lastSyncedOn'] = lastSyncedOn;
//     _data['creationDate'] = creationDate;
//     _data['modificatorName'] = modificatorName;
//     _data['modificationDate'] = modificationDate;
//     return _data;
//   }
// }


class SelfPacedTrainingModuleResponseModel {
  SelfPacedTrainingModuleResponseModel({
     this.list,
     this.data,
     this.totalCount,
     this.currentPageNo,
     this.totalPageCount,
  });

  final List<SelfPacedTrainingModel>? list;
  final List<dynamic>? data;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  factory SelfPacedTrainingModuleResponseModel.fromJson(Map<String, dynamic> json) {
    return SelfPacedTrainingModuleResponseModel(
      list: (json['list'] as List<dynamic>? ?? [])
          .map((e) => SelfPacedTrainingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: List<dynamic>.from(json['data'] ?? []),
      totalCount: json['totalCount'] ?? 0,
      currentPageNo: json['currentPageNo'] ?? 0,
      totalPageCount: json['totalPageCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'list': list?.map((e) => e.toJson()).toList(),
    'data': data,
    'totalCount': totalCount,
    'currentPageNo': currentPageNo,
    'totalPageCount': totalPageCount,
  };
}

class SelfPacedTrainingModel {
  SelfPacedTrainingModel({
     this.id,
     this.title,
     this.description,
     this.trainingMaterial,
     this.trainingMaterialContentType,
    this.trainingMaterialContent,
     this.assessmentLink,
    this.assessmentId,
     this.launchDate,
     this.dueDate,
     this.passingScore,
     this.status,
     this.creatorName,
     this.creatorEmail,
     this.creationDate,
     this.modificatorName,
     this.modificationDate,
     this.trainingGroups,
     this.recipients,
     this.misRows,
     this.questionnaireName,
     this.groupSummary,
     this.learnerCount,
     this.averageScore,
     this.passRate,
     this.selectedGroupIds,
     this.selectedGroups,
  });

   int? id;
   String? title;
   String? description;
   String? trainingMaterial;
   String? trainingMaterialContentType;
   dynamic trainingMaterialContent;
   String? assessmentLink;
   int? assessmentId;
   String? launchDate;
   String? dueDate;
   num? passingScore;
   String? status;
   String? creatorName;
   String? creatorEmail;
   String? creationDate;
   String? modificatorName;
   String? modificationDate;
   List<TrainingGroups>? trainingGroups;
   List<Recipients>? recipients;
   List<MisRows>? misRows;
   String? questionnaireName;
   String? groupSummary;
   int? learnerCount;
   num? averageScore;
   num? passRate;
   List<int>? selectedGroupIds;
   List<dynamic>? selectedGroups;

  factory SelfPacedTrainingModel.fromJson(Map<String, dynamic> json) {
    return SelfPacedTrainingModel(
      id: json['id'] as int,
      title: json['title'] as String?,
      description: json['description'] as String?,
      trainingMaterial: json['trainingMaterial'] as String?,
      trainingMaterialContentType: json['trainingMaterialContentType'] as String?,
      trainingMaterialContent: json['trainingMaterialContent'],
      assessmentLink: json['assessmentLink'] as String?,
      assessmentId: json['assessmentId'] as int?,
      launchDate: json['launchDate'] as String?,
      dueDate: json['dueDate'] as String?,
      passingScore: json['passingScore'] as num?,
      status: json['status'] as String?,
      creatorName: json['creatorName'] as String?,
      creatorEmail: json['creatorEmail'] as String?,
      creationDate: json['creationDate'] as String?,
      modificatorName: json['modificatorName'] as String?,
      modificationDate: json['modificationDate'] as String?,
      trainingGroups: (json['trainingGroups'] as List<dynamic>? ?? [])
          .map((e) => TrainingGroups.fromJson(e as Map<String, dynamic>))
          .toList(),
      recipients: (json['recipients'] as List<dynamic>? ?? [])
          .map((e) => Recipients.fromJson(e as Map<String, dynamic>))
          .toList(),
      misRows: (json['misRows'] as List<dynamic>? ?? [])
          .map((e) => MisRows.fromJson(e as Map<String, dynamic>))
          .toList(),
      questionnaireName: json['questionnaireName'] as String?,
      groupSummary: json['groupSummary'] as String?,
      learnerCount: json['learnerCount'] as int?,
      averageScore: json['averageScore'] as num?,
      passRate: json['passRate'] as num?,
      selectedGroupIds: (json['selectedGroupIds'] as List<dynamic>? ?? [])
          .map((e) => e as int)
          .toList(),
      selectedGroups: json['selectedGroups'] as List<dynamic>? ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'trainingMaterial': trainingMaterial,
    'trainingMaterialContentType': trainingMaterialContentType,
    'trainingMaterialContent': trainingMaterialContent,
    'assessmentLink': assessmentLink,
    'assessmentId': assessmentId,
    'launchDate': launchDate,
    'dueDate': dueDate,
    'passingScore': passingScore,
    'status': status,
    'creatorName': creatorName,
    'creatorEmail': creatorEmail,
    'creationDate': creationDate,
    'modificatorName': modificatorName,
    'modificationDate': modificationDate,
    'trainingGroups': trainingGroups?.map((e) => e.toJson()).toList(),
    'recipients': recipients?.map((e) => e.toJson()).toList(),
    'misRows': misRows?.map((e) => e.toJson()).toList(),
    'questionnaireName': questionnaireName,
    'groupSummary': groupSummary,
    'learnerCount': learnerCount,
    'averageScore': averageScore,
    'passRate': passRate,
    'selectedGroupIds': selectedGroupIds,
    'selectedGroups': selectedGroups,
  };
}


class TrainingGroups {
  TrainingGroups({
     this.id,
     this.groupId,
     this.groupName,
  });
  late final int? id;
  late final int? groupId;
  late final String? groupName;

  TrainingGroups.fromJson(Map<String, dynamic> json){
    id = json['id'];
    groupId = json['groupId'];
    groupName = json['groupName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['groupId'] = groupId;
    _data['groupName'] = groupName;
    return _data;
  }
}

class Recipients {
  Recipients({
     this.id,
     this.groupId,
     this.userId,
     this.employeeId,
     this.name,
     this.email,
     this.region,
     this.location,
     this.inviteeId,
     this.assessmentAnswerId,
     this.accessCode,
     this.mailId,
    this.mailSentOn,
    this.submittedOn,
    this.scorePercent,
     this.feedbackText,
     this.resultStatus,
     this.completionStatus,
     this.creationDate,
     this.modificatorName,
     this.modificationDate,
  });
  late final int? id;
  late final int?groupId;
  late final int? userId;
  late final String? employeeId;
  late final String? name;
  late final String? email;
  late final String? region;
  late final String? location;
  late final int? inviteeId;
  late final int? assessmentAnswerId;
  late final String? accessCode;
  late final int? mailId;
  late final int? mailSentOn;
  late final int? submittedOn;
  late final int? scorePercent;
  late final String? feedbackText;
  late final String? resultStatus;
  late final String? completionStatus;
  late final int? creationDate;
  late final String? modificatorName;
  late final int? modificationDate;

  Recipients.fromJson(Map<String, dynamic> json){
    id = json['id'];
    groupId = json['groupId'];
    userId = json['userId'];
    employeeId = json['employeeId'];
    name = json['name'];
    email = json['email'];
    region = json['region'];
    location = json['location'];
    inviteeId = json['inviteeId'];
    assessmentAnswerId = json['assessmentAnswerId'];
    accessCode = json['accessCode'];
    mailId = json['mailId'];
    mailSentOn = null;
    submittedOn = null;
    scorePercent = null;
    feedbackText = json['feedbackText'];
    resultStatus = json['resultStatus'];
    completionStatus = json['completionStatus'];
    creationDate = json['creationDate'];
    modificatorName = json['modificatorName'];
    modificationDate = json['modificationDate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['groupId'] = groupId;
    _data['userId'] = userId;
    _data['employeeId'] = employeeId;
    _data['name'] = name;
    _data['email'] = email;
    _data['region'] = region;
    _data['location'] = location;
    _data['inviteeId'] = inviteeId;
    _data['assessmentAnswerId'] = assessmentAnswerId;
    _data['accessCode'] = accessCode;
    _data['mailId'] = mailId;
    _data['mailSentOn'] = mailSentOn;
    _data['submittedOn'] = submittedOn;
    _data['scorePercent'] = scorePercent;
    _data['feedbackText'] = feedbackText;
    _data['resultStatus'] = resultStatus;
    _data['completionStatus'] = completionStatus;
    _data['creationDate'] = creationDate;
    _data['modificatorName'] = modificatorName;
    _data['modificationDate'] = modificationDate;
    return _data;
  }
}

class MisRows {
  MisRows({
     this.id,
     this.recipientId,
     this.userId,
     this.name,
     this.region,
     this.location,
     this.assessmentId,
     this.assessmentAnswerId,
     this.accessCode,
    this.scorePercent,
    this.retakeThreshold,
    this.maxAttempts,
    this.attemptsUsed,
     this.feedbackText,
     this.feedbackRatingLabel,
     this.feedbackComments,
     this.resultStatus,
    this.submittedOn,
    this.lastSyncedOn,
    this.creationDate,
     this.modificatorName,
    this.modificationDate,
  });
  late final int? id;
  late final int? recipientId;
  late final int? userId;
  late final String? name;
  late final String? region;
  late final String? location;
  late final int? assessmentId;
  late final int? assessmentAnswerId;
  late final String? accessCode;
  late final int? scorePercent;
  late final int? retakeThreshold;
  late final int? maxAttempts;
  late final int? attemptsUsed;
  late final String? feedbackText;
  late final String? feedbackRatingLabel;
  late final String? feedbackComments;
  late final String? resultStatus;
  late final int? submittedOn;
  late final int? lastSyncedOn;
  late final int? creationDate;
  late final String? modificatorName;
  late final int? modificationDate;

  MisRows.fromJson(Map<String, dynamic> json){
    id = json['id'];
    recipientId = json['recipientId'];
    userId = json['userId'];
    name = json['name'];
    region = json['region'];
    location = json['location'];
    assessmentId = json['assessmentId'];
    assessmentAnswerId = json['assessmentAnswerId'];
    accessCode = json['accessCode'];
    scorePercent = null;
    retakeThreshold = null;
    maxAttempts = null;
    attemptsUsed = null;
    feedbackText = json['feedbackText'];
    feedbackRatingLabel = json['feedbackRatingLabel'];
    feedbackComments = json['feedbackComments'];
    resultStatus = json['resultStatus'];
    submittedOn = null;
    lastSyncedOn = null;
    creationDate = null;
    modificatorName = json['modificatorName'];
    modificationDate = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['recipientId'] = recipientId;
    _data['userId'] = userId;
    _data['name'] = name;
    _data['region'] = region;
    _data['location'] = location;
    _data['assessmentId'] = assessmentId;
    _data['assessmentAnswerId'] = assessmentAnswerId;
    _data['accessCode'] = accessCode;
    _data['scorePercent'] = scorePercent;
    _data['retakeThreshold'] = retakeThreshold;
    _data['maxAttempts'] = maxAttempts;
    _data['attemptsUsed'] = attemptsUsed;
    _data['feedbackText'] = feedbackText;
    _data['feedbackRatingLabel'] = feedbackRatingLabel;
    _data['feedbackComments'] = feedbackComments;
    _data['resultStatus'] = resultStatus;
    _data['submittedOn'] = submittedOn;
    _data['lastSyncedOn'] = lastSyncedOn;
    _data['creationDate'] = creationDate;
    _data['modificatorName'] = modificatorName;
    _data['modificationDate'] = modificationDate;
    return _data;
  }
}