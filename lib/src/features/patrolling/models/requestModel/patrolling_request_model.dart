
import 'package:db_atom/src/features/patrolling/models/patrolling_model.dart';

class PatrollingRequestModel{
  PatrollingRequestModel({
    required this.patrollingModel,
  });

  late final PatrollingModel patrollingModel;

  PatrollingRequestModel.fromJson(Map<String, dynamic> json) {
    patrollingModel = PatrollingModel.fromJson(json['patrolling']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['patrolling'] = patrollingModel.toJson();
    return data;
  }
}
