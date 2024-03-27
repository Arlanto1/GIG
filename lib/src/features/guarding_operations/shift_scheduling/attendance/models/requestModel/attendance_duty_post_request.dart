
import 'package:db_atom/index.dart';

class AttendanceShiftDutyPostRequest {
  AttendanceShiftDutyPostRequest({
    required this.requestModel,
  });

  DutyPostModel? requestModel;

  AttendanceShiftDutyPostRequest.fromJson(Map<String, dynamic> json) {
    requestModel =
        DutyPostModel.fromJson(json['shiftDutyPost']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['shiftDutyPost'] = requestModel?.toJson();
    return data;
  }
}
