

import 'package:db_atom/src/features/patrolling/models/patrolling_other_model.dart';

class PatrollingOtherRequestModel{
  PatrollingOtherRequestModel({
    required this.patrollingOtherModel,
  });

  late final PatrollingOtherModel patrollingOtherModel;

  PatrollingOtherRequestModel.fromJson(Map<String, dynamic> json) {
    patrollingOtherModel = PatrollingOtherModel.fromJson(json['patrolling']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['patrolling'] = patrollingOtherModel.toJson();
    return data;
  }
}
