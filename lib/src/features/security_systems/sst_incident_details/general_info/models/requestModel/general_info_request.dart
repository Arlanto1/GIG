import 'package:db_atom/src/features/incident_management/incident_managements/models/incidents_response.dart';

class IncidentGeneralInfoRequest {
  final Incident? incident;

  IncidentGeneralInfoRequest({
    this.incident,
  });

  IncidentGeneralInfoRequest.fromJson(Map<String, dynamic> json)
      : incident = (json['imGi'] as Map<String,dynamic>?) != null ? Incident.fromJson(json['imGi'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'imGi' : incident?.toJson()
  };
}

