
// import 'package:db_atom/src/features/selfPacedTraining/models/selfPacedTrainingModel.dart';
// class SelfPacedTrainingResponse {
//   final List<SelfPacedTrainingModel>? items;
//   final int? totalCount;
//   final int? currentPageNo;
//   final int? totalPageCount;
//
//   SelfPacedTrainingResponse({
//     this.items,
//     this.totalCount,
//     this.currentPageNo,
//     this.totalPageCount,
//   });
//
//   SelfPacedTrainingResponse.fromJson(Map<String, dynamic> json)
//       : items = (json['list'] as List?)?.map((dynamic e) => SelfPacedTrainingModel.fromJson(e as Map<String,dynamic>)).toList(),
//         totalCount = json['totalCount'] as int?,
//         currentPageNo = json['currentPageNo'] as int?,
//         totalPageCount = json['totalPageCount'] as int?;
//
//   Map<String, dynamic> toJson() => {
//     'list' : items?.map((e) => e.toJson()).toList(),
//     'totalCount' : totalCount,
//     'currentPageNo' : currentPageNo,
//     'totalPageCount' : totalPageCount
//   };
// }
