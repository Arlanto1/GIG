import 'package:json_annotation/json_annotation.dart';

// part 'organisation.g.dart';

// @JsonSerializable()
class Organisation {
  int? id;
  String? name;
  @JsonKey(name: 'keyname')
  String? keyName;
  bool? isSelected;

  Organisation({
    this.id,
    this.name,
    this.keyName,
    this.isSelected = false,
  });

  // factory Organisation.fromJson(Map<String, dynamic> json) => _$OrganisationFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$OrganisationToJson(this);

  Organisation.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String,
        keyName = json['keyname'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'keyname': keyName,
      };
}
