import 'package:db_atom/src/features/passmanagement/sez_pass_management/models/sez_pass_management_model.dart';

class SezPassManagementRequest {
  SezPassManagementRequest({
    required this.passManagement,
  });

  late final SezPassManagementModel passManagement;

  SezPassManagementRequest.fromJson(Map<String, dynamic> json) {
    passManagement = SezPassManagementModel.fromJson(json['passManagement']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['passManagement'] = passManagement.toJson();
    return data;
  }
}
