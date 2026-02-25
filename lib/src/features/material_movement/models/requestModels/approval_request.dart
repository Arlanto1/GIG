import '../approval_model.dart';
//
// class MaterialApprovalRequest {
//    ApprovalModel? approvalModel;
//
//   MaterialApprovalRequest({
//      this.approvalModel,
//   });
//
//   factory MaterialApprovalRequest.fromJson(Map<String, dynamic> json) {
//     return MaterialApprovalRequest(
//       approvalModel: ApprovalModel.fromJson(json['data']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'data': approvalModel.toJson(),
//     };
//   }
// }
//
//
//

class MaterialApprovalRequest{
  ApprovalModel? items;

  MaterialApprovalRequest({
    this.items,
  });

  MaterialApprovalRequest.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as Map<String, dynamic>?) != null
      ? ApprovalModel.fromJson(
      json['data'] as Map<String, dynamic>)
      : null;

  Map<String, dynamic> toJson() => {'data': items?.toJson()};
}
