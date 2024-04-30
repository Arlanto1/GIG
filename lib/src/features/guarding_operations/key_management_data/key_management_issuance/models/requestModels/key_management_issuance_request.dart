import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/key_management_issuance_model.dart';

class KeyManagementIssuanceRequest {
  final KeyManagementIssuanceModel? keyIssuanceGi;

  KeyManagementIssuanceRequest({
    this.keyIssuanceGi,
  });

  KeyManagementIssuanceRequest.fromJson(Map<String, dynamic> json)
      : keyIssuanceGi = (json['keyIssuanceGi'] as Map<String, dynamic>?) != null
            ? KeyManagementIssuanceModel.fromJson(
                json['keyIssuanceGi'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'keyIssuanceGi': keyIssuanceGi?.toJson()};
}
