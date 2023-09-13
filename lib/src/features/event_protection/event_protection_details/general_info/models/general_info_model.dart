import '../../../../../models/entity.dart';
import '../../../../../models/location.dart';
import '../../../../../models/location_region.dart';

class GeneralInfoModel {
  GeneralInfoModel({
    this.id,
    this.status,
    this.location,
    this.locationRegion,
    this.inputDate,
    this.slNo,
    this.annualPowerShutdown,
    this.entities,
    this.eventStartDate,
    this.eventEndDate,
  });

  int? id;
  int? status;
  Location? location;
  LocationRegion? locationRegion;
  String? inputDate;
  String? slNo;
  bool? annualPowerShutdown;
  List<Entity>? entities;
  String? eventStartDate;
  String? eventEndDate;

  GeneralInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    location = Location.fromJson(json['location']);
    locationRegion = LocationRegion.fromJson(json['locationRegion']);
    inputDate = json['inputDate'];
    slNo = json['slNo'];
    annualPowerShutdown = json['annualPowerShutdown'];
    entities =
        List.from(json['entities']).map((e) => Entity.fromJson(e)).toList();
    eventStartDate = json['eventStartDate'];
    eventEndDate = json['eventEndDate'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['location'] = location?.toJson();
    data['locationRegion'] = locationRegion?.toJson();
    data['inputDate'] = inputDate;
    data['slNo'] = slNo;
    data['annualPowerShutdown'] = annualPowerShutdown;
    data['entities'] = entities?.map((e) => e.toJson()).toList();
    data['eventStartDate'] = eventStartDate;
    data['eventEndDate'] = eventEndDate;
    return data;
  }
}
