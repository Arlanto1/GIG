import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/models/responseModels/permission_error.dart';

class UtilsCommon {

  Future<void> logCustomEvent({required String msg, required String customKey}) async {
    FirebaseCrashlytics.instance.log(msg);
    FirebaseCrashlytics.instance.setUserIdentifier(await SharedPrefs.getUserId());
    FirebaseCrashlytics.instance.setCustomKey(customKey, msg);

    // await FirebaseCrashlytics.instance.recordError(
    //   error,
    //   stackTrace,
    //   reason: 'a non-fatal error',
    //   information: ['further diagnostic information about the error', 'version 2.0'],
    // );
  }

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
    copyWith = genericExceptionHandling(e, copyWith, state);
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
      log('---e is TokenExpiredException--');
      InactivityFunctions().logoutUser(navigatorKey);
      copyWith = state.copyWith(
        message: e.message,
        status: FormStatus.sessionExpired,
      );
    }
    return copyWith;
  }

  Widget showNoRecordWidget({
    required dynamic state,
    required double height,
    required List items,
  }) {
    // if (items.isEmptyOrNull &&
    //     state.status != FormStatus.loading &&
    //     state.status != FormStatus.initial) {
    //   log('----showNoRecordWidget--ifff-');
    //   return Column(
    //     children: [
    //       CommonWidgets.verticalSpacerWidget(height * 0.1),
    //       const NoRecordFoundWidget(),
    //     ],
    //   );
    // } else
    if (items.isEmptyOrNull &&
        state.status != FormStatus.loading &&
        (state.status == FormStatus.initial ||
            state.status == FormStatus.success)) {
      return Column(
        children: [
          CommonWidgets.verticalSpacerWidget(height * 0.1),
          const NoRecordFoundWidget(),
        ],
      );
    }
    return const SizedBox();
  }
}
