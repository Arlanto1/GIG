
import '../vvip_visitor_records_response.dart';
import '../vvip_visitor_response_model.dart';

class VVIPVisitorRecordRequest {
  final VIVPVisitorRecordModel? vipVisitors;

  VVIPVisitorRecordRequest({
    this.vipVisitors,
  });

  VVIPVisitorRecordRequest.fromJson(Map<String, dynamic> json)
      : vipVisitors = (json['vipVisitors'] as Map<String, dynamic>?) != null
      ? VIVPVisitorRecordModel.fromJson(json['vipVisitors'] as Map<String, dynamic>)
      : null;

  Map<String, dynamic> toJson() => {'vipVisitors': vipVisitors?.toJson()};
}
