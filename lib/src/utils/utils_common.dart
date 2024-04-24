import 'package:db_atom/index.dart';
import 'package:db_atom/src/services/common_services.dart';

class UtilsCommon {
  Future<ExtraProperties> checkWritePermission({
    required String moduleCode,
    required CommonServices commonServices,
  }) async {
    bool hasWritePermission = await commonServices.getModuleAccessByUserRole(
      moduleCode: moduleCode,
    );
    ExtraProperties extraProperties =
        ExtraProperties(hasWritePermission: hasWritePermission);
    return extraProperties;
  }
}
