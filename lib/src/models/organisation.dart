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
  int? notReturned;

  /// Duty Post Name
  String? dutyPostName;
  bool? transportShift;

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
    this.notReturned,
    this.dutyPostName,
    this.transportShift,
    this.isSelected = false,
  });

  // factory Organisation.fromJson(Map<String, dynamic> json) => _$OrganisationFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$OrganisationToJson(this);

  Organisation.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] ?? json['keyDescription']?? json['dutyPostName'] as String?,
        description = json['description'] as String?,
        keyDescription = json['keyDescription'] as String?,
        noKeys = json['noKeys'] as int?,
        noKeysIssued = json['noKeysIssued'] as int?,
        notReturned = json['notReturned'] as int?,
        dutyPostName = json['dutyPostName'] ?? json['dutyPostName'] as String?,
        transportShift =
            json['transportShift'] ?? json['transportShift'] as bool?,
        keyName = json['keyname'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'keyDescription': keyDescription,
        'noKeys': noKeys,
        'noKeysIssued': noKeysIssued,
        'dutyPostName': dutyPostName,
        'transportShift': transportShift,
        'keyname': keyName,
      };
}
