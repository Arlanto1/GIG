
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/models/duty_post_master_model.dart';

class DutyPostMasterRequest {
  DutyPostMasterRequest({
    required this.dutyPostMaster,
  });

  late final DutyPostMasterModel dutyPostMaster;

  DutyPostMasterRequest.fromJson(Map<String, dynamic> json) {
    dutyPostMaster =
        DutyPostMasterModel.fromJson(json['dutyPostMaster']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['dutyPostMaster'] = dutyPostMaster.toJson();
    return data;
  }
}
