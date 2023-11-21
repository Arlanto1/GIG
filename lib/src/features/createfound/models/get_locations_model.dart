import 'package:json_annotation/json_annotation.dart';

import '../../../models/organisation.dart';

part 'get_locations_model.g.dart';

@JsonSerializable()
class Locations {
  @JsonKey(name: 'West')
  List<Organisation>? west;
  @JsonKey(name: 'South')
  List<Organisation>? south;
  @JsonKey(name: 'North & East')
  List<Organisation>? northEast;
  @JsonKey(name: 'Mumbai')
  List<Organisation>? mumbai;
  @JsonKey(name: 'Central')
  List<Organisation>? central;

  Locations({
    this.west,
    this.south,
    this.northEast,
    this.mumbai,
    this.central
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$GetLocationsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetLocationsToJson(this);
}
