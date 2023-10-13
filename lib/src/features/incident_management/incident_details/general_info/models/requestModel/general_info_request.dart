


import '../../../../models/incidents_response.dart';

class IncidentGeneralInfoRequest {
  final Incident? incidentManagement;

  IncidentGeneralInfoRequest({
    this.incidentManagement,
  });

  IncidentGeneralInfoRequest.fromJson(Map<String, dynamic> json)
      : incidentManagement = (json['imGi'] as Map<String,dynamic>?) != null ? Incident.fromJson(json['imGi'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'incidentManagement' : incidentManagement?.toJson(),
    'occurrence' : incidentManagement?.toJson(),
    'securitySystemSLA' : incidentManagement?.toJson()
  };
}

