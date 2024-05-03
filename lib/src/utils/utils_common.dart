import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/services/common_services.dart';

import 'package:db_atom/src/models/responseModels/permission_error.dart';

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

  void eHandling(Exception e, dynamic emit, dynamic state) {
    dynamic copyWith;
    copyWith = UtilsCommon().genericExceptionHandling(e, copyWith, state);
    emit(copyWith);
  }

  genericExceptionHandling(Exception e, copyWith, dynamic state) {
    log('-e----${e.runtimeType}-');
    log('-e----${e.toString()}-');
    if (e is PermissionError) {
      log('-e---PermissionError----#---${e.toString()}-');

      copyWith = state.copyWith(
        message: e.message,
        status: FormStatus.permissionLocationError,
      );
    }
    if (e is TokenExpiredException) {
      copyWith =state.copyWith(
        message: e.message,
        status: FormStatus.sessionExpired,
      );
    }
    return copyWith;
  }
}
