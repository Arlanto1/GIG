import 'package:db_atom/src/features/guarding_operations/vvip_visitor/models/vvip_visitor_records_model.dart';

import '../../../../../index.dart';

part 'vvip_visitor_records_response.g.dart';

class VVIPVisitorRecordsResponseModel extends BaseObject {
  final List<VVIPVisitorsRecordListModel>? items;
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
                VVIPVisitorsRecordListModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
        '': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

@JsonSerializable()
class VVIPVisitorsRecordListModel extends BaseObject {
  final List<VIVPVisitorRecords>? vvipVisitorsRecord;

  VVIPVisitorsRecordListModel({
    this.vvipVisitorsRecord,
  });

  factory VVIPVisitorsRecordListModel.fromJson(Map<String, dynamic> json) =>
      _$VVIPVisitorsRecordListModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VVIPVisitorsRecordListModelToJson(this);
}
