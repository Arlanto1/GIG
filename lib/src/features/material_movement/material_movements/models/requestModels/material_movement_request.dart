import 'package:db_atom/src/features/material_movement/material_movements/models/material_movements_model.dart';

class MaterialMovementRequest {
  MaterialMovementRequest({
    required this.materialMovement,
  });
  late final MaterialMovementModel materialMovement;

  MaterialMovementRequest.fromJson(Map<String, dynamic> json){
    materialMovement = MaterialMovementModel.fromJson(json['materialMovement']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['materialMovement'] = materialMovement.toJson();
    return _data;
  }
}

