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
  int? available;

  /// Duty Post Name
  String? dutyPostName;
  bool? transportShift;

  ///
  String? activityNotes;
  String? submittedDate;
  bool? submitted;
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
    this.available,
    this.dutyPostName,
    this.transportShift,
    this.isSelected = false,
    this.activityNotes,
    this.submitted,
    this.submittedDate,
  });

  // factory Organisation.fromJson(Map<String, dynamic> json) => _$OrganisationFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$OrganisationToJson(this);

  Organisation.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] ??
            json['keyDescription'] ??
            json['dutyPostName'] as String?,
        description = json['description'] as String?,
        keyDescription = json['keyDescription'] as String?,
        noKeys = json['noKeys'] as int?,
        noKeysIssued = json['noKeysIssued'] as int?,
        available = json['available'] as int?,
        dutyPostName = json['dutyPostName'] ?? json['dutyPostName'] as String?,
        transportShift =
            json['transportShift'] ?? json['transportShift'] as bool?,
        keyName = json['keyname'] as String?,
  activityNotes = json['activityNotes'] as String?,
        submitted = json['submitted'] as bool?,
        submittedDate = json['submittedDate'] as String?;


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
    'activityNotes':activityNotes,
    'submitted':submitted,
    'submittedDate':submittedDate,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Organisation &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          keyName == other.keyName &&
          description == other.description &&
          keyDescription == other.keyDescription &&
          noKeys == other.noKeys &&
          noKeysIssued == other.noKeysIssued &&
          available == other.available &&
          dutyPostName == other.dutyPostName &&
          transportShift == other.transportShift &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      keyName.hashCode ^
      description.hashCode ^
      keyDescription.hashCode ^
      noKeys.hashCode ^
      noKeysIssued.hashCode ^
      available.hashCode ^
      dutyPostName.hashCode ^
      transportShift.hashCode ^
      isSelected.hashCode;
}
