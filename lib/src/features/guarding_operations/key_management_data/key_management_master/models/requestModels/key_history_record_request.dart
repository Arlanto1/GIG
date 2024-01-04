import 'package:db_atom/src/features/contact_details/models/contact_info.dart';

class KeyHistoryRecordRequest {
  ContactRecord? keyLossGi;

  KeyHistoryRecordRequest({
    this.keyLossGi,
  });

  KeyHistoryRecordRequest.fromJson(Map<String, dynamic> json)
      : keyLossGi = (json['keyLossGi'] as Map<String,dynamic>?) != null ? ContactRecord.fromJson(json['cit'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'keyLossGi' : keyLossGi?.toJson()
  };
}
