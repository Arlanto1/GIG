import 'package:json_annotation/json_annotation.dart';

// part 'organisation.g.dart';

// @JsonSerializable()
class Organisation {
  int? id;
  String? name;
  @JsonKey(name: 'keyname')
  String? keyName;
  String? description;

  /// Key Description fields
  String? keyDescription;
  int? noKeys;
  int? noKeysIssued;

  /// For Dropdown
  bool? isSelected;

  Organisation({
    this.id,
    this.name,
    this.keyName,
    this.description,
    this.keyDescription,
    this.noKeys,
    this.noKeysIssued,
    this.isSelected = false,
  });

  // factory Organisation.fromJson(Map<String, dynamic> json) => _$OrganisationFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$OrganisationToJson(this);

  Organisation.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] ?? json['keyDescription'] as String?,
        description = json['description'] as String?,
        keyDescription = json['keyDescription'] as String?,
        noKeys = json['noKeys'] as int?,
        noKeysIssued = json['noKeysIssued'] as int?,
        keyName = json['keyname'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'keyDescription': keyDescription,
        'noKeys': noKeys,
        'noKeysIssued': noKeysIssued,
        'keyname': keyName,
      };
}
