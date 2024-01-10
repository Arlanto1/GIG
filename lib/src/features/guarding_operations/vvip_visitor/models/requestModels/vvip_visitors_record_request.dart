import '../vvip_visitor_record_model.dart';

class VVIPVisitorRecordRequest {
  VIVPVisitorRecordModel? vipVisitors;

  VVIPVisitorRecordRequest({
    this.vipVisitors,
  });

  VVIPVisitorRecordRequest.fromJson(Map<String, dynamic> json)
      : vipVisitors = (json['vipVisitors'] as Map<String, dynamic>?) != null
            ? VIVPVisitorRecordModel.fromJson(
                json['vipVisitors'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'vipVisitors': vipVisitors?.toJson()};
}
