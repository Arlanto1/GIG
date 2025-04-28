import 'package:db_atom/src/features/material_movement/models/material_movement_model.dart';

class PassManagementRequest {
  PassManagementRequest({
    required this.passManagement,
  });

  late final MaterialMovementModel passManagement;

  PassManagementRequest.fromJson(Map<String, dynamic> json) {
    passManagement = MaterialMovementModel.fromJson(json['passManagement']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['passManagement'] = passManagement.toJson();
    return data;
  }
}
