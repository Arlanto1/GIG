import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';

class GMRateRequest {
  final GMRate? guardingRateInfo;

  GMRateRequest({
    this.guardingRateInfo,
  });

  GMRateRequest.fromJson(Map<String, dynamic> json)
      : guardingRateInfo = (json['guardingRateInfo'] as Map<String,dynamic>?) != null ? GMRate.fromJson(json['guardingRateInfo'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'guardingRateInfo' : guardingRateInfo?.toJson()
  };
}

