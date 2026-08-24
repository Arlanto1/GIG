import 'package:db_atom/src/features/ticketing_system/models/ticketing_system_model.dart';

class TicketingSystemListResponse {
  final List<TicketingSystemModel>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  TicketingSystemListResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  TicketingSystemListResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)?.map((dynamic e) => TicketingSystemModel.fromJson(e as Map<String,dynamic>)).toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
    'data' : items?.map((e) => e.toJson()).toList(),
    'totalCount' : totalCount,
    'currentPageNo' : currentPageNo,
    'totalPageCount' : totalPageCount
  };
}
