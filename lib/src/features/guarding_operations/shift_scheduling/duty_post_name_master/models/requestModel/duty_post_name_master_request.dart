
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/models/duty_post_name_master_model.dart';

class DutyPostNameMasterRequest {
  DutyPostNameMasterRequest({
    required this.dutyPostNameMaster,
  });

  late final DutyPostNameMasterModel dutyPostNameMaster;

  DutyPostNameMasterRequest.fromJson(Map<String, dynamic> json) {
    dutyPostNameMaster =
        DutyPostNameMasterModel.fromJson(json['guardingMaster']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['guardingMaster'] = dutyPostNameMaster.toJson();
    return data;
  }
}
