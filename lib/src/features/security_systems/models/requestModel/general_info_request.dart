import '../sst_incident_response.dart';

class SecuritySystemTicketIncidentRequest {
  final SstIncident? sstIncident;

  SecuritySystemTicketIncidentRequest({
    this.sstIncident,
  });

  SecuritySystemTicketIncidentRequest.fromJson(Map<String, dynamic> json)
      : sstIncident = (json['securitySystemSLA'] as Map<String,dynamic>?) != null ? SstIncident.fromJson(json['securitySystemSLA'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'securitySystemSLA' : sstIncident?.toJson()
  };
}

