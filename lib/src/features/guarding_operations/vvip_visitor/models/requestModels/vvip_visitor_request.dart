import '../vvip_visitor_response_model.dart';

class VVIPVisitorRequest {
  final VIVPVisitorModel? vvip;

  VVIPVisitorRequest({
    this.vvip,
  });

  VVIPVisitorRequest.fromJson(Map<String, dynamic> json)
      : vvip = (json['vvip'] as Map<String, dynamic>?) != null
            ? VIVPVisitorModel.fromJson(json['vvip'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'vvip': vvip?.toJson()};
}
