
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/models/key_loss_destruction_list_model.dart';

class KeyLossDestructionRequest {
  final KeyLossDestructionListModel? keyLossGi;

  KeyLossDestructionRequest({
    this.keyLossGi,
  });

  KeyLossDestructionRequest.fromJson(Map<String, dynamic> json)
      : keyLossGi = (json['keyLossGi'] as Map<String, dynamic>?) != null
      ? KeyLossDestructionListModel.fromJson(json['keyLossGi'] as Map<String, dynamic>)
      : null;

  Map<String, dynamic> toJson() => {'keyLossGi': keyLossGi?.toJson()};
}
