
import '../vvip_visitor_records_model.dart';

class VVIPVisitorRecordRequest {
  final VIVPVisitorRecords? vipVisitors;

  VVIPVisitorRecordRequest({
    this.vipVisitors,
  });

  VVIPVisitorRecordRequest.fromJson(Map<String, dynamic> json)
      : vipVisitors = (json['vipVisitors'] as Map<String, dynamic>?) != null
      ? VIVPVisitorRecords.fromJson(json['vipVisitors'] as Map<String, dynamic>)
      : null;

  Map<String, dynamic> toJson() => {'vipVisitors': vipVisitors?.toJson()};
}
