
import 'package:db_atom/src/features/passmanagement/day_pass_mangement/models/day_pass_management_model.dart';
import 'package:db_atom/src/features/passmanagement/vendor_pass_management/models/vendor_pass_management_model.dart';

class VendorPassManagementRequest {
  VendorPassManagementRequest({
    required this.passManagement,
  });

  late final VendorPassManagementModel passManagement;

  VendorPassManagementRequest.fromJson(Map<String, dynamic> json) {
    passManagement = VendorPassManagementModel.fromJson(json['passManagement']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['passManagement'] = passManagement.toJson();
    return data;
  }
}
