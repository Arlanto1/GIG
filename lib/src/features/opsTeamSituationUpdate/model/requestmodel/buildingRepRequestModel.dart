import '../opsTeamSitutationModel.dart';

class BuildingRepModelRequest{
  LsmOccupancyReport? items;

  BuildingRepModelRequest({
    this.items,
  });

  BuildingRepModelRequest.fromJson(Map<String, dynamic> json)
      : items = (json['lsmOccupancyReport'] as Map<String, dynamic>?) != null
      ? LsmOccupancyReport.fromJson(
      json['lsmOccupancyReport'] as Map<String, dynamic>)
      : null;

  Map<String, dynamic> toJson() => {'lsmOccupancyReport': items?.toJson()};
}

