import 'package:db_atom/src/models/history.dart';

import '../../../../index.dart';

part 'transport_medical_incident_model.g.dart';

class TransportMedicalResponse {
  final List<TransportMedicalModel>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  TransportMedicalResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  TransportMedicalResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
      ?.map((dynamic e) =>
      TransportMedicalModel.fromJson(e as Map<String, dynamic>))
      .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
    'data': items?.map((e) => e.toJson()).toList(),
    'totalCount': totalCount,
    'currentPageNo': currentPageNo,
    'totalPageCount': totalPageCount
  };
}

@JsonSerializable()
class TransportMedicalModel extends BaseObject {
    int? id;
   String? slNo;
   String? inputDate;
   Organisation? location;
   Organisation? locationRegion;
   List<Organisation>? entities;
   int? status;
   int? incidentType;
   String? modifiedBy;
   List<History>? history;
   User? entrySecurity;
   String? incidentDate;
   String? shiftLoginDate;
   String? shiftLogoutDate;
   String? tripId;
   String? vehicleRegistrationNo;
   String? incidentLocation;
   String? description;
   Map? map;
   String? actionsTaken;
   String? incidentImpact;
   bool? escortDeployed;
   bool? wellnessTeamAttended;
   bool? takenToHospital;
   int? transportType;
   String? hospitalName;
   String? hospitalLocation;
   bool? dropProvided;
   bool? employeeReached;
   String? modificationHistory;
   String? cancelReason;
   String? lock;


  TransportMedicalModel({
     this.id,
     this.slNo,
     this.inputDate,
     this.location,
     this.locationRegion,
     this.entities,
     this.status,
     this.incidentType,
     this.modifiedBy,
     this.history,
     this.entrySecurity,
     this.incidentDate,
     this.shiftLoginDate,
     this.shiftLogoutDate,
     this.tripId,
     this.vehicleRegistrationNo,
     this.incidentLocation,
     this.description,
     this.map,
     this.actionsTaken,
     this.incidentImpact,
     this.escortDeployed,
     this.wellnessTeamAttended,
     this.takenToHospital,
     this.transportType,
     this.hospitalName,
     this.hospitalLocation,
     this.dropProvided,
     this.employeeReached,
     this.modificationHistory,
     this.cancelReason,
    this.lock,
  });

  factory TransportMedicalModel.fromJson(Map<String, dynamic> json) =>
      _$TransportMedicalModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TransportMedicalModelToJson(this);
}
