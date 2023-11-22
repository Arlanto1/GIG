import 'package:db_atom/src/features/contact_details/models/contacts_list_response_model.dart';

class ContactsRequest {
  final Contact? cd;

  ContactsRequest({
    this.cd,
  });

  ContactsRequest.fromJson(Map<String, dynamic> json)
      : cd = (json['cd'] as Map<String, dynamic>?) != null
            ? Contact.fromJson(json['cd'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'cd': cd?.toJson()};
}
