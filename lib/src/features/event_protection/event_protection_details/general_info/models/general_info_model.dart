import 'package:db_atom/src/models/entity.dart';

import '../../../../../models/location.dart';
import '../../../../../models/location_region.dart';

class EventProtectionGi {
  EventProtectionGi({
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.entities,
    this.status,
    this.modifiedBy,
    this.annualPowerShutdown,
    this.id,
  });

  int? id;
  String? slNo;
  String? inputDate;
  Location? location;
  LocationRegion? locationRegion;
  List<Entity>? entities;
  int? status;
  String? modifiedBy;
  bool? annualPowerShutdown;

  EventProtectionGi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slNo = json['slNo'];
    inputDate = json['inputDate'];
    location = Location.fromJson(json['location']);
    locationRegion = LocationRegion.fromJson(json['locationRegion']);
    entities =
        List.from(json['entities']).map((e) => Entity.fromJson(e)).toList();
    status = json['status'];
    modifiedBy = json['modifiedBy'];
    annualPowerShutdown = json['annualPowerShutdown'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['slNo'] = slNo;
    _data['inputDate'] = inputDate;
    _data['location'] = location?.toJson();
    _data['locationRegion'] = locationRegion?.toJson();
    _data['entities'] = entities?.map((e) => e.toJson()).toList();
    _data['status'] = status;
    _data['modifiedBy'] = modifiedBy;
    _data['annualPowerShutdown'] = annualPowerShutdown;
    return _data;
  }
}
