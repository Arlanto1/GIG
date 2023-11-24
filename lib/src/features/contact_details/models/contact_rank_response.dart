import 'package:db_atom/src/models/organisation.dart';

class ContactRankResponse {
  final List<Organisation>? ranks;

  ContactRankResponse({
    this.ranks,
  });

  ContactRankResponse.fromJson(Map<String, dynamic> json)
      : ranks = (json['CONTACT_GENERAL_RANK'] as List?)?.map((dynamic e) => Organisation.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'CONTACT_GENERAL_RANK' : ranks?.map((e) => e.toJson()).toList()
  };
}
