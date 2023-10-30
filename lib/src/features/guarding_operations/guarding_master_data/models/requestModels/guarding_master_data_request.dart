import '../guarding_master_data_model.dart';

class GuardingMasterDataRequest {
  GuardingMasterDataRequest({
    required this.guardingMasterData,
  });

  late final GuardingMastersDataModel guardingMasterData;

  GuardingMasterDataRequest.fromJson(Map<String, dynamic> json) {
    guardingMasterData =
        GuardingMastersDataModel.fromJson(json['guardingMaster']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['guardingMaster'] = guardingMasterData.toJson();
    return data;
  }
}
