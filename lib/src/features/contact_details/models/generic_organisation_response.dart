import 'package:db_atom/src/models/organisation.dart';

class GenericOrganisationResponse {
  final List<Organisation>? items;

  GenericOrganisationResponse({
    this.items,
  });

  GenericOrganisationResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)?.map((dynamic e) => Organisation.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'data' : items?.map((e) => e.toJson()).toList()
  };
}
