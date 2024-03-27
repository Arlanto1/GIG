import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/key_history_model.dart';

class KeyHistoryRecordRequest {
  KeyHistoryModel? keyLossGi;

  KeyHistoryRecordRequest({
    this.keyLossGi,
  });

  KeyHistoryRecordRequest.fromJson(Map<String, dynamic> json)
      : keyLossGi = (json['keyLossGi'] as Map<String, dynamic>?) != null
            ? KeyHistoryModel.fromJson(
                json['keyLossGi'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'keyLossGi': keyLossGi?.toJson()};
}