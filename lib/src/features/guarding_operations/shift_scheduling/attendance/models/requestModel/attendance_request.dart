import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/models/attendance_model.dart';

class AttendanceRequest {
  AttendanceRequest({
    required this.requestModel,
  });

  late final AttendanceModel requestModel;

  AttendanceRequest.fromJson(Map<String, dynamic> json) {
    requestModel = AttendanceModel.fromJson(json['attdInfoGi']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['attdInfoGi'] = requestModel.toJson();
    return data;
  }
}
