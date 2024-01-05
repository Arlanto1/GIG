import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/key_management_master_model.dart';

class KeyHistoryRecordRequest {
  KeyManagementMasterModel? keyLossGi;

  KeyHistoryRecordRequest({
    this.keyLossGi,
  });

  KeyHistoryRecordRequest.fromJson(Map<String, dynamic> json)
      : keyLossGi = (json['keyLossGi'] as Map<String, dynamic>?) != null
            ? KeyManagementMasterModel.fromJson(
                json['cit'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'keyLossGi': keyLossGi?.toJson()};
}
