
import '../general_info_model.dart';

class IncidentGeneralInfoRequest {
  final IncidentManagement? incidentManagement;

  IncidentGeneralInfoRequest({
    this.incidentManagement,
  });

  IncidentGeneralInfoRequest.fromJson(Map<String, dynamic> json)
      : incidentManagement = (json['imGi'] as Map<String,dynamic>?) != null ? IncidentManagement.fromJson(json['imGi'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'incidentManagement' : incidentManagement?.toJson(),
    'occurrence' : incidentManagement?.toJson(),
    'securitySystemSLA' : incidentManagement?.toJson()
  };
}

