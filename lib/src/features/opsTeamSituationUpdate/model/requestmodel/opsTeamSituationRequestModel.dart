import 'package:db_atom/src/features/material_movement/models/material_movement_model.dart';

import '../opsTeamSitutationModel.dart';

class LsmSituationModelRequest {
  LsmSituationModelRequest({
    required this.lsmSituationalModel,
  });

  late final LsmSituationalModel lsmSituationalModel;

  LsmSituationModelRequest.fromJson(Map<String, dynamic> json) {
    lsmSituationalModel = LsmSituationalModel.fromJson(json['lsmSituationalUpdateGi']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lsmSituationalUpdateGi'] = lsmSituationalModel.toJson();
    return data;
  }
}
