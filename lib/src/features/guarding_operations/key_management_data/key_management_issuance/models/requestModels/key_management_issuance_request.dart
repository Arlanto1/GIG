

import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/key_management_issuance_model.dart';

class KeyManagementIssuanceRequest {
  final KeyManagementIssuanceModel? svpGi;

  KeyManagementIssuanceRequest({
    this.svpGi,
  });

  KeyManagementIssuanceRequest.fromJson(Map<String, dynamic> json)
      : svpGi = (json['svpGi'] as Map<String, dynamic>?) != null
      ? KeyManagementIssuanceModel.fromJson(json['sla'] as Map<String, dynamic>)
      : null;

  Map<String, dynamic> toJson() => {'svpGi': svpGi?.toJson()};
}
