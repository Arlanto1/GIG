import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/key_issuance_process_model.dart';

class KeyIssuanceProcessRecordRequest {
  KeyIssuanceProcessRecord? model;

  KeyIssuanceProcessRecordRequest({
    this.model,
  });

  KeyIssuanceProcessRecordRequest.fromJson(Map<String, dynamic> json)
      : model = (json['kiProcess'] as Map<String, dynamic>?) != null
            ? KeyIssuanceProcessRecord.fromJson(
                json['kiProcess'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'kiProcess': model?.toJson()};
}
