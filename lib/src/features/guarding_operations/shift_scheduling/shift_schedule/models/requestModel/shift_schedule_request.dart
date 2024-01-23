
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/models/shift_schedule_response.dart';

class ShiftScheduleRequest {
  ShiftScheduleRequest({
    required this.shiftScheduleModel,
  });

  late final ShiftScheduleModel shiftScheduleModel;

  ShiftScheduleRequest.fromJson(Map<String, dynamic> json) {
    shiftScheduleModel =
        ShiftScheduleModel.fromJson(json['ssGi']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ssGi'] = shiftScheduleModel.toJson();
    return data;
  }
}
