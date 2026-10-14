import 'package:db_atom/index.dart';

class PatrollingGenInfoModel {
  User? lsm;
  int? shift;
  int? submittedDate;
  int? inputDate;
  User? entrySecurity;
  int? verifiedDate;
  int? closedDate;
  User? securitySupervisor;
  Organisation? locationRegion;
  Organisation? location;
  Organisation? locationType;
  String? cancelReason;
  Organisation? entity;
  int? status;

  PatrollingGenInfoModel({
    this.lsm,
    this.shift,
    this.submittedDate,
    this.inputDate,
    this.entrySecurity,
    this.verifiedDate,
    this.closedDate,
    this.securitySupervisor,
    this.locationRegion,
    this.location,
    this.cancelReason,
    this.entity,
    this.status,
    this.locationType,
  });

  PatrollingGenInfoModel.fromJson(Map<String, dynamic> json)
      : lsm = (json['lsm'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['lsm'] as Map<String, dynamic>)
            : null,
        shift = json['shift'] as int?,
        inputDate = json['inputDate'] as int?,
        submittedDate = json['submittedDate'] as int?,
        entrySecurity = (json['entrySecurity'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['entrySecurity'] as Map<String, dynamic>)
            : null,
        verifiedDate = json['verifiedDate'] as int?,
        closedDate = json['closedDate'] as int?,
        securitySupervisor = (json['securitySupervisor']
                    as Map<String, dynamic>?) !=
                null
            ? User.fromJson(json['securitySupervisor'] as Map<String, dynamic>)
            : null,
        locationRegion =
            (json['locationRegion'] as Map<String, dynamic>?) != null
                ? Organisation.fromJson(
                    json['locationRegion'] as Map<String, dynamic>)
                : null,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        locationType = (json['locationType'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['locationType'] as Map<String, dynamic>)
            : null,
        cancelReason = json['cancelReason'] as String?,
        entity = (json['entity'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['entity'] as Map<String, dynamic>)
            : null,
        status = json['status'] as int;

  Map<String, dynamic> toJson() => {
        'lsm': lsm,
        'shift': shift,
        'inputDate': inputDate,
        'locationRegion': locationRegion?.toJson(),
        'submittedDate': submittedDate,
        'entrySecurity': entrySecurity?.toJson(),
        'verifiedDate': verifiedDate,
        'closedDate': closedDate,
        'securitySupervisor': securitySupervisor?.toJson(),
        'location': location?.toJson(),
    'locationType':locationType?.toJson(),
        'cancelReason': cancelReason,
        'entity': entity?.toJson(),
        'status': status,
      };
}
