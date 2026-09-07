
import '../adhoc_attendance_model.dart';

class AdhocAttendanceRequest {
  AdhocAttendanceRequest({
    required this.requestModel,
  });

  AdhocAttendanceGiModel? requestModel;

  AdhocAttendanceRequest.fromJson(Map<String, dynamic> json) {
    requestModel = AdhocAttendanceGiModel.fromJson(json['adhocAttendanceGi']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['adhocAttendanceGi'] = requestModel?.toJson();
    return data;
  }
}
