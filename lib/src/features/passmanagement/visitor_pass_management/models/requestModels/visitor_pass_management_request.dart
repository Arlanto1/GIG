
import 'package:db_atom/src/features/passmanagement/visitor_pass_management/models/visitor_pass_management_model.dart';

class VisitorPassManagementRequest {
  VisitorPassManagementRequest({
    required this.passManagement,
  });

  late final VisitorPassManagementModel passManagement;

  VisitorPassManagementRequest.fromJson(Map<String, dynamic> json) {
    passManagement = VisitorPassManagementModel.fromJson(json['passManagement']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['passManagement'] = passManagement.toJson();
    return data;
  }
}
