import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';

class PayRateRequest {
  PayRate? guardingRate;

  PayRateRequest({
    this.guardingRate,
  });

  PayRateRequest.fromJson(Map<String, dynamic> json)
      : guardingRate = (json['guardingRate'] as Map<String,dynamic>?) != null ? PayRate.fromJson(json['guardingRate'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'guardingRate' : guardingRate?.toJson()
  };
}