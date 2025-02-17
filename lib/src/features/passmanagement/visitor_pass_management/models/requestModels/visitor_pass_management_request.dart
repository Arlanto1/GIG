
import 'package:db_atom/src/features/passmanagement/day_pass_mangement/models/day_pass_management_model.dart';

class VisitorPassManagementRequest {
  VisitorPassManagementRequest({
    required this.passManagement,
  });

  late final DayPassManagementModel passManagement;

  VisitorPassManagementRequest.fromJson(Map<String, dynamic> json) {
    passManagement = DayPassManagementModel.fromJson(json['passManagement']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['passManagement'] = passManagement.toJson();
    return data;
  }
}
