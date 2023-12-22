
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/key_management_master_model.dart';

class KeyManagementMasterRequest {
  KeyManagementMasterRequest({
    required this.keyManagementMaster,
  });

  late final KeyManagementMasterModel keyManagementMaster;

  KeyManagementMasterRequest.fromJson(Map<String, dynamic> json) {
    keyManagementMaster =
        KeyManagementMasterModel.fromJson(json['guardingMaster']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['guardingMaster'] = keyManagementMaster.toJson();
    return data;
  }
}
