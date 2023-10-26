import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';

class MaterialMovementRequest {
  MaterialMovementRequest({
    required this.materialMovement,
  });
  late final MaterialMovementModel materialMovement;

  MaterialMovementRequest.fromJson(Map<String, dynamic> json){
    materialMovement = MaterialMovementModel.fromJson(json['materialMovement']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['materialMovement'] = materialMovement.toJson();
    return data;
  }
}

