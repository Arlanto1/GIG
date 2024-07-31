import 'package:json_annotation/json_annotation.dart';

import '../../../models/organisation.dart';

part 'get_locations_model.g.dart';

@JsonSerializable()
class Locations {
  @JsonKey(name: 'West')
  @Deprecated('Json Format has been changed. Please use regions')
  List<Organisation>? west;
  @JsonKey(name: 'South')
  @Deprecated('Json Format has been changed. Please use regions')
  List<Organisation>? south;
  @JsonKey(name: 'North & East')
  @Deprecated('Json Format has been changed. Please use regions')
  List<Organisation>? northEast;
  @JsonKey(name: 'Mumbai')
  @Deprecated('Json Format has been changed. Please use regions')
  List<Organisation>? mumbai;
  @JsonKey(name: 'Central')
  @Deprecated('Json Format has been changed. Please use regions')
  List<Organisation>? central;

  @JsonKey(name: 'regions')
  List<Region>? regions;

  Locations(
      {this.west,
      this.south,
      this.northEast,
      this.mumbai,
      this.central,
      this.regions});

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);

  Map<String, dynamic> toJson() => _$LocationsToJson(this);
}

class Region {
  final int? id;
  final String? name;
  final List<Organisation>? locations;

  Region({
    this.id,
    this.name,
    this.locations,
  });

  Region.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        locations = (json['locations'] as List?)
            ?.map(
                (dynamic e) => Organisation.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'locations': locations?.map((e) => e.toJson()).toList()
      };
}
