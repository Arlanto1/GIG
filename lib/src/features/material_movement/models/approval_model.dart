class ApprovalModel {
  int? apStepId;
  int? decision;
  String? reasonForRejection;
  bool? canSubmitDecision;
  String? location;
  String? gatePassApprovers;
  String? requestor;
  String? objectId;

  ApprovalModel({
    this.apStepId,
    this.decision,
    this.reasonForRejection,
    this.canSubmitDecision,
    this.location,
    this.gatePassApprovers,
    this.requestor,
    this.objectId,
  });

  ApprovalModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;

    apStepId = data?['apStepId'] as int?;

    final decisionValue = data?['decision'];
    decision = decisionValue is int
        ? decisionValue
        : int.tryParse(decisionValue?.toString() ?? '');

    reasonForRejection = data?['reasonForRejection'] as String?;
    canSubmitDecision = data?['canSubmitDecision'] as bool?;
    location = data?['location'] as String?;
    gatePassApprovers = data?['gatePassApprovers'] as String?;
    requestor = data?['requestor'] as String?;
    objectId = data?['objectId']?.toString();
  }

  Map<String, dynamic> toJson() => {
        'apStepId': apStepId,
        'decision': decision,
        'reasonForRejection': reasonForRejection,
        'canSubmitDecision': canSubmitDecision,
        'location': location,
        'gatePassApprovers': gatePassApprovers,
        'requestor': requestor,
        'objectId': objectId,
      };
}
