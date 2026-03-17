// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_medical_incident_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransportMedicalModel _$TransportMedicalModelFromJson(
        Map<String, dynamic> json) =>
    TransportMedicalModel(
      id: (json['id'] as num?)?.toInt(),
      slNo: json['slNo'] as String?,
      inputDate: json['inputDate'] as String?,
      location: json['location'] == null
          ? null
          : Organisation.fromJson(json['location'] as Map<String, dynamic>),
      locationRegion: json['locationRegion'] == null
          ? null
          : Organisation.fromJson(
              json['locationRegion'] as Map<String, dynamic>),
      entities: (json['entities'] as List<dynamic>?)
          ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: (json['status'] as num?)?.toInt(),
      incidentType: (json['incidentType'] as num?)?.toInt(),
      modifiedBy: json['modifiedBy'] as String?,
      history: (json['history'] as List<dynamic>?)
          ?.map((e) => History.fromJson(e as Map<String, dynamic>))
          .toList(),
      entrySecurity: json['entrySecurity'] == null
          ? null
          : User.fromJson(json['entrySecurity'] as Map<String, dynamic>),
      incidentDate: json['incidentDate'] as String?,
      shiftLoginDate: json['shiftLoginDate'] as String?,
      shiftLogoutDate: json['shiftLogoutDate'] as String?,
      tripId: json['tripId'] as String?,
      vehicleRegistrationNo: json['vehicleRegistrationNo'] as String?,
      incidentLocation: json['incidentLocation'] as String?,
      description: json['description'] as String?,
      map: json['map'] as Map<String, dynamic>?,
      actionsTaken: json['actionsTaken'] as String?,
      incidentImpact: json['incidentImpact'] as String?,
      escortDeployed: json['escortDeployed'] as bool?,
      wellnessTeamAttended: json['wellnessTeamAttended'] as bool?,
      takenToHospital: json['takenToHospital'] as bool?,
      transportType: (json['transportType'] as num?)?.toInt(),
      hospitalName: json['hospitalName'] as String?,
      hospitalLocation: json['hospitalLocation'] as String?,
      dropProvided: json['dropProvided'] as bool?,
      employeeReached: json['employeeReached'] as bool?,
      modificationHistory: json['modificationHistory'] as String?,
      cancelReason: json['cancelReason'] as String?,
      lock: json['lock'] as String?,
    );

Map<String, dynamic> _$TransportMedicalModelToJson(
        TransportMedicalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slNo': instance.slNo,
      'inputDate': instance.inputDate,
      'location': instance.location,
      'locationRegion': instance.locationRegion,
      'entities': instance.entities,
      'status': instance.status,
      'incidentType': instance.incidentType,
      'modifiedBy': instance.modifiedBy,
      'history': instance.history,
      'entrySecurity': instance.entrySecurity,
      'incidentDate': instance.incidentDate,
      'shiftLoginDate': instance.shiftLoginDate,
      'shiftLogoutDate': instance.shiftLogoutDate,
      'tripId': instance.tripId,
      'vehicleRegistrationNo': instance.vehicleRegistrationNo,
      'incidentLocation': instance.incidentLocation,
      'description': instance.description,
      'map': instance.map,
      'actionsTaken': instance.actionsTaken,
      'incidentImpact': instance.incidentImpact,
      'escortDeployed': instance.escortDeployed,
      'wellnessTeamAttended': instance.wellnessTeamAttended,
      'takenToHospital': instance.takenToHospital,
      'transportType': instance.transportType,
      'hospitalName': instance.hospitalName,
      'hospitalLocation': instance.hospitalLocation,
      'dropProvided': instance.dropProvided,
      'employeeReached': instance.employeeReached,
      'modificationHistory': instance.modificationHistory,
      'cancelReason': instance.cancelReason,
      'lock': instance.lock,
    };
