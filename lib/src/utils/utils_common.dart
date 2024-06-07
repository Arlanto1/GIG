import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/models/responseModels/permission_error.dart';
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

  void exceptionHandling(Exception e, dynamic emit, dynamic state) {
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
      copyWith = state.copyWith(
        message: e.message,
        status: FormStatus.sessionExpired,
      );
    }
    return copyWith;
  }

  Widget showNoRecordWidget(
      {required dynamic state, required double height, required List items}) {
    log('----showNoRecordWidget---');
    if (items.isEmptyOrNull &&
        state.status != FormStatus.loading &&
        state.status != FormStatus.initial) {
      log('----showNoRecordWidget--ifff-');
      return Column(
        children: [
          CommonWidgets.verticalSpacerWidget(height * 0.1),
          const NoRecordFoundWidget(),
        ],
      );
    } else if (items.isEmptyOrNull && state.status == FormStatus.initial){
      return Column(
        children: [
          CommonWidgets.verticalSpacerWidget(height * 0.1),
          const NoRecordFoundWidget(),
        ],
      );

    }
    log('----showNoRecordWidget--else-');
    return const SizedBox();
  }
}
