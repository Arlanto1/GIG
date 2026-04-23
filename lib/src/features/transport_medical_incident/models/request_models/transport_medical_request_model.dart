
import 'package:db_atom/src/features/transport_medical_incident/models/transport_medical_incident_model.dart';

class TransportMedicalRequest {
  TransportMedicalRequest({
    required this.transportModel,
  });

  late final TransportMedicalModel transportModel;

  TransportMedicalRequest.fromJson(Map<String, dynamic> json) {
    transportModel = TransportMedicalModel.fromJson(json['patrolling']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['patrolling'] = transportModel.toJson();
    return data;
  }
}
