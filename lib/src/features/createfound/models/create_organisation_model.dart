import 'dart:convert';

CreateOrganisation createOrganisationFromJson(String str) =>
    CreateOrganisation.fromJson(json.decode(str));

String createOrganisationToJson(CreateOrganisation data) => json.encode(data.toJson());

class CreateOrganisation {
  int? id;
  String? name;

  CreateOrganisation({
    this.id,
    this.name,
  });

  factory CreateOrganisation.fromJson(Map<String, dynamic> json) => CreateOrganisation(
        id: json["Id"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
