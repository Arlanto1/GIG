import '../annual_power_shutdown_list_model.dart';

class AnnualPowerShutdownListRequest {
  AnnualPowerShutdownListRequest({
    required this.annualPowerShutdown,
  });

  late final AnnualPowerShutdownListModel annualPowerShutdown;

  AnnualPowerShutdownListRequest.fromJson(Map<String, dynamic> json) {
    annualPowerShutdown = AnnualPowerShutdownListModel.fromJson(json['epGi']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['epGi'] = annualPowerShutdown.toJson();
    return data;
  }
}
