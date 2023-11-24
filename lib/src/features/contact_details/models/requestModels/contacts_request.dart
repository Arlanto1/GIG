import 'package:db_atom/src/features/contact_details/models/contact_info.dart';

class ContactRecordRequest {
   ContactRecord? cit;

  ContactRecordRequest({
    this.cit,
  });

  ContactRecordRequest.fromJson(Map<String, dynamic> json)
      : cit = (json['cit'] as Map<String,dynamic>?) != null ? ContactRecord.fromJson(json['cit'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'cit' : cit?.toJson()
  };
}
