import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/key_management_master_model.dart';

class KeyManagementMasterRequest {
  final KeyManagementMasterModel? keyMgmtGi;

  KeyManagementMasterRequest({
    this.keyMgmtGi,
  });

  KeyManagementMasterRequest.fromJson(Map<String, dynamic> json)
      : keyMgmtGi = (json['keyMgmtGi'] as Map<String, dynamic>?) != null
      ? KeyManagementMasterModel.fromJson(json['keyMgmtGi'] as Map<String, dynamic>)
      : null;

  Map<String, dynamic> toJson() => {'keyMgmtGi': keyMgmtGi?.toJson()};
}
