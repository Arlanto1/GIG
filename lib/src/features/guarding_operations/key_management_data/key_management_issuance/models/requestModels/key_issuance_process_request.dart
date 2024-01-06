import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/key_issuance_process_model.dart';

class KeyIssuanceProcessRecordRequest {
  KeyIssuanceProcessRecord? vp;

  KeyIssuanceProcessRecordRequest({
    this.vp,
  });

  KeyIssuanceProcessRecordRequest.fromJson(Map<String, dynamic> json)
      : vp = (json['vp'] as Map<String, dynamic>?) != null
            ? KeyIssuanceProcessRecord.fromJson(
                json['vp'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'vp': vp?.toJson()};
}
