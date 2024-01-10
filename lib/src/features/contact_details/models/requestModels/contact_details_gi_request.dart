import 'package:db_atom/src/features/contact_details/models/contact_details_list_response_model.dart';

class ContactDetailsGiRequest {
  final ContactDetailModel? cdGi;

  ContactDetailsGiRequest({
    this.cdGi,
  });

  ContactDetailsGiRequest.fromJson(Map<String, dynamic> json)
      : cdGi = (json['cdGi'] as Map<String, dynamic>?) != null
            ? ContactDetailModel.fromJson(json['cdGi'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'cdGi': cdGi?.toJson()};
}
