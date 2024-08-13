import 'package:db_atom/index.dart';

class AttendanceShiftDutyPostRequest {
  AttendanceShiftDutyPostRequest({
    required this.requestModel,
  });

  ShiftModel? requestModel;

  AttendanceShiftDutyPostRequest.fromJson(Map<String, dynamic> json) {
    requestModel = ShiftModel.fromJson(json['shiftDutyPost']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['shiftDutyPost'] = requestModel?.toJson();
    return data;
  }
}
