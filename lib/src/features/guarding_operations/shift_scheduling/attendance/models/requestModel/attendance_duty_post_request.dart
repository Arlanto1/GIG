import 'package:db_atom/index.dart';

import '../dutyPost_attendance_model.dart';

class AttendanceShiftDutyPostRequest {
  AttendanceShiftDutyPostRequest({
    required this.requestModel,
  });

  DutyPostAttendanceModel? requestModel;

  AttendanceShiftDutyPostRequest.fromJson(Map<String, dynamic> json) {
    requestModel = DutyPostAttendanceModel.fromJson(json['attdInfoGi']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['attdInfoGi'] = requestModel?.toJson();
    return data;
  }
}
