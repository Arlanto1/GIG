// class AIResponseModel {
//   final int? totalCount;
//   final List<AiChatModel>? results;
//
//   AIResponseModel({
//     this.totalCount,
//     this.results,
//   });
//
//   factory AIResponseModel.fromJson(Map<String, dynamic> json) {
//     return AIResponseModel(
//       totalCount: json['totalCount'],
//       results: (json['results'] as List<dynamic>?)
//           ?.map((e) => AiChatModel.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
//
// class AiChatModel {
//   final int? id;
//   final String? createdBy;
//   final String? promptType;
//   final String? promptShortName;
//   final String? selectedLanguages;
//   final String? selectedAISystem;
//   final dynamic prePrompt;
//   final dynamic selectedPrePromptType;
//   final String? result;
//   final dynamic context;
//   final String? assistantId;
//   final String? threadId;
//   final dynamic storePrompt;
//   final int? created;
//   final dynamic expires;
//   final int? promptStatus;
//   final dynamic refinementOf;
//   final dynamic publishWorkflowTemplateId;
//   final dynamic notificationWorkflowTemplateId;
//   final dynamic container;
//   final String? updatedBy;
//   final int? updated;
//
//   AiChatModel({
//     this.id,
//     this.createdBy,
//     this.promptType,
//     this.promptShortName,
//     this.selectedLanguages,
//     this.selectedAISystem,
//     this.prePrompt,
//     this.selectedPrePromptType,
//     this.result,
//     this.context,
//     this.assistantId,
//     this.threadId,
//     this.storePrompt,
//     this.created,
//     this.expires,
//     this.promptStatus,
//     this.refinementOf,
//     this.publishWorkflowTemplateId,
//     this.notificationWorkflowTemplateId,
//     this.container,
//     this.updatedBy,
//     this.updated,
//   });
//
//   AiChatModel.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         createdBy = json['createdBy'] as String?,
//         promptType = json['promptType'] as String?,
//         promptShortName = json['promptShortName'] as String?,
//         selectedLanguages = json['selectedLanguages'] as String?,
//         selectedAISystem = json['selectedAISystem'] as String?,
//         prePrompt = json['prePrompt'],
//         selectedPrePromptType = json['selectedPrePromptType'],
//         result = json['result'] as String?,
//         context = json['context'],
//         assistantId = json['assistantId'] as String?,
//         threadId = json['threadId'] as String?,
//         storePrompt = json['storePrompt'],
//         created = json['created'] as int?,
//         expires = json['expires'],
//         promptStatus = json['promptStatus'] as int?,
//         refinementOf = json['refinementOf'],
//         publishWorkflowTemplateId = json['publishWorkflowTemplateId'],
//         notificationWorkflowTemplateId = json['notificationWorkflowTemplateId'],
//         container = json['container'],
//         updatedBy = json['updatedBy'] as String?,
//         updated = json['updated'] as int?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'createdBy' : createdBy,
//     'promptType' : promptType,
//     'promptShortName' : promptShortName,
//     'selectedLanguages' : selectedLanguages,
//     'selectedAISystem' : selectedAISystem,
//     'prePrompt' : prePrompt,
//     'selectedPrePromptType' : selectedPrePromptType,
//     'result' : result,
//     'context' : context,
//     'assistantId' : assistantId,
//     'threadId' : threadId,
//     'storePrompt' : storePrompt,
//     'created' : created,
//     'expires' : expires,
//     'promptStatus' : promptStatus,
//     'refinementOf' : refinementOf,
//     'publishWorkflowTemplateId' : publishWorkflowTemplateId,
//     'notificationWorkflowTemplat  eId' : notificationWorkflowTemplateId,
//     'container' : container,
//     'updatedBy' : updatedBy,
//     'updated' : updated
//   };
// }
class AIResponseModel {
  final int? totalCount;
  final List<AiChatModel>? results;

  AIResponseModel({
    this.totalCount,
    this.results,
  });

  factory AIResponseModel.fromJson(Map<String, dynamic> json) {
    return AIResponseModel(
      totalCount: json['totalCount'],
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => AiChatModel.fromJson(e))
          .toList(),
    );
  }
}

class AiChatModel {
  final int? id;
  final String? createdBy;
  final String? promptType;
  final String? promptShortName;
  final String? selectedLanguages;
  final String? selectedAISystem;
  final String? prePrompt;
  final String? selectedPrePromptType;
  final String? result;
  final String? context;
  final String? assistantId;
  final String? threadId;
  final String? storePrompt;
  final int? created;
  final String? expires;
  final int? promptStatus;
  final String? refinementOf;
  final String? publishWorkflowTemplateId;
  final String? notificationWorkflowTemplateId;
  final String? container;
  final String? updatedBy;
  final int? updated;

  AiChatModel({
    this.id,
    this.createdBy,
    this.promptType,
    this.promptShortName,
    this.selectedLanguages,
    this.selectedAISystem,
    this.prePrompt,
    this.selectedPrePromptType,
    this.result,
    this.context,
    this.assistantId,
    this.threadId,
    this.storePrompt,
    this.created,
    this.expires,
    this.promptStatus,
    this.refinementOf,
    this.publishWorkflowTemplateId,
    this.notificationWorkflowTemplateId,
    this.container,
    this.updatedBy,
    this.updated,
  });

  factory AiChatModel.fromJson(Map<String, dynamic> json) {
    return AiChatModel(
      id: json['id'],
      createdBy: json['createdBy'],
      promptType: json['promptType'],
      promptShortName: json['promptShortName'],
      selectedLanguages: json['selectedLanguages'],
      selectedAISystem: json['selectedAISystem'],
      prePrompt: json['prePrompt'],
      selectedPrePromptType: json['selectedPrePromptType'],
      result: json['result'],
      context: json['context'],
      assistantId: json['assistantId'],
      threadId: json['threadId'],
      storePrompt: json['storePrompt'],
      created: json['created'],
      expires: json['expires'],
      promptStatus: json['promptStatus'],
      refinementOf: json['refinementOf'],
      publishWorkflowTemplateId: json['publishWorkflowTemplateId'],
      notificationWorkflowTemplateId: json['notificationWorkflowTemplateId'],
      container: json['container'],
      updatedBy: json['updatedBy'],
      updated: json['updated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdBy': createdBy,
      'promptType': promptType,
      'promptShortName': promptShortName,
      'selectedLanguages': selectedLanguages,
      'selectedAISystem': selectedAISystem,
      'prePrompt': prePrompt,
      'selectedPrePromptType': selectedPrePromptType,
      'result': result,
      'context': context,
      'assistantId': assistantId,
      'threadId': threadId,
      'storePrompt': storePrompt,
      'created': created,
      'expires': expires,
      'promptStatus': promptStatus,
      'refinementOf': refinementOf,
      'publishWorkflowTemplateId': publishWorkflowTemplateId,
      'notificationWorkflowTemplateId': notificationWorkflowTemplateId,
      'container': container,
      'updatedBy': updatedBy,
      'updated': updated,
    };
  }
}



class AiChatResponseAnswerModel {
   final int? id;
   final String? promptShortName;
    final String? prePrompt;
    final String? result;
  AiChatResponseAnswerModel({
    this.id,
    this.prePrompt,
    this.promptShortName,
    this.result
  });

  factory AiChatResponseAnswerModel.fromJson(Map<String, dynamic> json) {
    return AiChatResponseAnswerModel(
      id: json['id'],
      promptShortName: json['promptShortName'],
      prePrompt: json['prePrompt'],
        result: json['result'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'promptShortName': promptShortName,
      'prePrompt': prePrompt,
    };
  }
}
