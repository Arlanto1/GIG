class VVIPVisitorRecordsResponseModel {
  final List<VIVPVisitorRecordModel>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  VVIPVisitorRecordsResponseModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  VVIPVisitorRecordsResponseModel.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) =>
      VIVPVisitorRecordModel.fromJson(e as Map<String, dynamic>))
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


// class VVIPVisitorsRecordListModel {
//   List<VIVPVisitorRecordModel>? vIVPVisitorRecords;
//
//   VVIPVisitorsRecordListModel({
//     this.vIVPVisitorRecords,
//   });
//
//   VVIPVisitorsRecordListModel.fromJson(Map<String, dynamic> json)
//       :
//         vIVPVisitorRecords = (json['vIVPVisitorRecords'] as List<dynamic>?)
//       ?.map(
//           (e) => vIVPVisitorRecords?.fromJson(e as Map<String, dynamic>))
//       .toList();
//
//   Map<String, dynamic> toJson() => {
//     'vIVPVisitorRecords': vIVPVisitorRecords,
//   };
// }

class VIVPVisitorRecordModel {
   int? id;
   String? name;
   String? email;
   String? designation;
   String? baseLocation;
   String? purpose;
   String? startDateVisit;
   String? endDateVisit;

  VIVPVisitorRecordModel({
    this.id,
    this.name,
    this.email,
    this.designation,
    this.baseLocation,
    this.purpose,
    this.startDateVisit,
    this.endDateVisit, required users,
  });

  VIVPVisitorRecordModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        email = json['email'] as String?,
        designation = json['designation'] as String?,
        baseLocation = json['baseLocation'] as String?,
        purpose = json['purpose'] as String?,
        startDateVisit = json['startDateVisit'] as String?,
        endDateVisit = json['endDateVisit'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'designation': designation,
        'baseLocation': baseLocation,
        'purpose': purpose,
        'startDateVisit': startDateVisit,
        'endDateVisit': endDateVisit
      };
}
