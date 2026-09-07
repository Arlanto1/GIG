//
// import 'dart:developer';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
// import 'package:intl/intl.dart';
//
// import '../../models/adhoc_attendance_model.dart';
//
// part 'additional_deployments_state.dart';
//
// class AdditionalDeploymentsCubit extends Cubit<AdditionalDeploymentsState> {
//   final AttendanceServices services;
//   final int attInfoId;
//   final CommonServices commonServices;
//
//   AdditionalDeploymentsCubit({
//     required this.services,
//     required this.commonServices,
//     required this.attInfoId,
//   }) : super(
//     AdditionalDeploymentsState.initial(
//       model: AttendanceModel(),
//       locations: Locations(),
//       loggedInUserDetails: User(),
//       users: const [],
//       emailUsers: const [],
//       errorMessage: '',
//       departments: const [],
//     ),
//   );
//
//   Future<dynamic> _safeCall(Future Function() call, String label) async {
//     try {
//       return await call();
//     } catch (e) {
//       log('Optional call failed: $label -> $e',
//           name: 'Additional Deployments Cubit');
//       return null;
//     }
//   }
//
//   List<Organisation> _parseOrgList(dynamic raw) {
//     if (raw == null) return const [];
//
//     if (raw is List<Organisation>) return raw;
//
//     if (raw is List) {
//       return raw
//           .whereType<Object>()
//           .map<Organisation>((e) {
//         if (e is Organisation) return e;
//         if (e is Map) {
//           return Organisation.fromJson(Map<String, dynamic>.from(e));
//         }
//         // Unknown shape - skip rather than crash.
//         return Organisation();
//       })
//           .toList();
//     }
//
//     if (raw is Map) {
//       // API returned a single object instead of a list.
//       return [Organisation.fromJson(Map<String, dynamic>.from(raw))];
//     }
//
//     // Unknown/unexpected shape - degrade gracefully instead of crashing.
//     return const [];
//   }
//
//   Future<void> initializeValues() async {
//     emit(
//       state.copyWith(
//         status: FormStatus.loading,
//       ),
//     );
//
//     AttendanceModel model = AttendanceModel();
//
//     try {
//       model = await services.getById(attInfoId);
//
//       final futures = await Future.wait([
//         _safeCall(() => services.getAdhocDesignation(), 'getAdhocDesignation'), // 0
//         _safeCall(() => services.getAdhocDutyHourList(), 'getAdhocDutyHourList'), // 1
//         _safeCall(() => services.getAdhocShiftList(), 'getAdhocShiftList'), // 2
//         commonServices.getUiLabels(
//             language: await SharedPrefs.getLanguageCode(),
//             moduleCode: Constants.attendanceModule), // 3
//         services.getAdhocAttendanceById(attInfoId: model.id), // 4
//         _safeCall(() => services.getAdhocAvailableGuards(
//           locId:  model.location!.id!,
//           vendorId: state.model.vendor!.id!
//         ), 'getAdhocAvailableGuards'),//5
//       ]);
//
//       final List<Organisation> designations = _parseOrgList(futures[0]);
//       final List<Organisation> dutyHoursList = _parseOrgList(futures[1]);
//       final List<Organisation> shifts = _parseOrgList(futures[2]);
//       final dynamic responseLabels = futures[3];
//       final AdhocAttendanceGiModel adhocModel =
//       futures[4] as AdhocAttendanceGiModel;
//       final List<Organisation> guards = _parseOrgList(futures[5]);
//
//
//       model.inputDate = model.inputDate == null
//           ? Utils().getCurrentDate()
//           : Utils.timestampToDateConversion(
//           int.tryParse(model.inputDate ?? '0'), Constants.fulldateFormat);
//
//       model.modifiedDate = model.modifiedDate == null
//           ? Utils().getCurrentDate()
//           : Utils.timestampToDateConversion(
//           int.tryParse(model.modifiedDate ?? '0'),
//           Constants.fulldateFormat);
//
//       final GmUiLabels labels = GmUiLabels.fromJson(responseLabels);
//
//       emit(
//         state.copyWith(
//           status: FormStatus.initial,
//           model: model,
//           labels: labels,
//           adhocModel: adhocModel,
//           designations: designations,
//           shifts: shifts,
//           dutyHoursList: dutyHoursList,
//             guardsList:guards
//         ),
//       );
//     } catch (e, st) {
//       log('Initialization issue',
//           error: e, stackTrace: st, name: 'Attendance Details Cubit');
//       emit(
//         state.copyWith(
//           model: model,
//           status: FormStatus.error,
//           message: Constants.errorText,
//         ),
//       );
//     }
//   }
//
//   void onModelValueChange(AttendanceModel model) {
//     log('-onModelValueChange---');
//     emit(state.copyWith(model: model, status: FormStatus.initial));
//   }
//
//   void onCheckBoxChange(AttendanceModel model) {
//     emit(state.copyWith(model: model, status: FormStatus.loading));
//     emit(state.copyWith(model: model, status: FormStatus.initial));
//   }
//
//   Future<void> updateDropdownValues({
//     Organisation? location,
//     BaseUser? user,
//     Organisation? vendor,
//     int? status,
//     int? attendanceType,
//     int? dutyType,
//   }) async {
//     emit(
//       state.copyWith(
//         status: FormStatus.loading,
//       ),
//     );
//     if (location != null) {
//       SerialNumberModel slNo = await commonServices.getSlNo(
//         locationId: location.id.toString(),
//         moduleCode: Constants.attendanceModule,
//       );
//
//       state.model.location = location;
//       state.model.slNo = slNo.serialNo;
//     }
//     state.model.dutyType = dutyType ?? state.model.dutyType;
//     state.model.vendor = vendor ?? state.model.vendor;
//     state.model.status = status ?? state.model.status;
//     emit(state.copyWith(
//       model: state.model,
//       status: FormStatus.initial,
//     ));
//   }
//
//   Future<bool> submitForm({
//     bool isSaveOnly = false,
//     bool navigateToNextScreen = false,
//   }) async {
//     emit(
//       state.copyWith(
//         status: FormStatus.loading,
//       ),
//     );
//
//     if (state.model.status == 0 || state.model.status == null) {
//       state.model.status = 0;
//     }
//
//     DateTime dateTime;
//     if (!Utils().isTimestamp(state.model.inputDate!)) {
//       dateTime =
//           DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
//       int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
//       state.model.inputDate = inputDate.toString();
//     }
//     AttendanceRequest request = AttendanceRequest(requestModel: state.model);
//
//     try {
//       GenericResponse response = GenericResponse();
//       if (isSaveOnly) {
//         if (!state.isValidDraft.status) {
//           emit(
//             state.copyWith(
//               status: FormStatus.formError,
//               message: state.isValidDraft.message,
//             ),
//           );
//           return false;
//         }
//         response = (await services.createAttendanceGi(
//             body: request, isSubmit: false));
//       } else {
//         if (!state.isValid.status) {
//           emit(
//             state.copyWith(
//               status: FormStatus.formError,
//               message: state.isValid.message,
//             ),
//           );
//           return false;
//         }
//         response =
//         (await services.createAttendanceGi(body: request, isSubmit: true));
//       }
//
//       log('---response--msg--${response.message}---');
//
//       if (response.id != null) {
//         int? id = int.tryParse(response.id!);
//         if (id != null) {
//           state.model.id = id;
//         }
//       }
//       emit(
//         state.copyWith(
//           model: state.model,
//           message: response.message,
//           status: navigateToNextScreen
//               ? FormStatus.navigateToNextScreen
//               : FormStatus.success,
//         ),
//       );
//       state.model.inputDate = state.model.inputDate == null
//           ? Utils().getCurrentDate()
//           : Utils.timestampToDateConversion(
//           int.tryParse(state.model.inputDate ?? '0'),
//           Constants.fulldateFormat);
//       return true;
//     } on GenericResponse catch (e) {
//       Utils().emitErrorState(e, emit, state);
//       state.model.inputDate = state.model.inputDate == null
//           ? Utils().getCurrentDate()
//           : Utils.timestampToDateConversion(
//           int.tryParse(state.model.inputDate ?? '0'),
//           Constants.fulldateFormat);
//       return false;
//     } on Exception catch (e) {
//       state.model.inputDate = state.model.inputDate == null
//           ? Utils().getCurrentDate()
//           : Utils.timestampToDateConversion(
//           int.tryParse(state.model.inputDate ?? '0'),
//           Constants.fulldateFormat);
//       emit(
//         state.copyWith(
//           message: e.toString(),
//           status: FormStatus.error,
//         ),
//       );
//       return false;
//     }
//   }
//
//   void updateStatus({required String id}) {
//     commonServices.updateRecordStatus(
//         id: id, module: Constants.attendanceModule);
//   }
// }

import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/models/requestModel/adhoc_attendance_request.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';

import '../../models/adhoc_attendance_model.dart';

part 'additional_deployments_state.dart';

class AdditionalDeploymentsCubit extends Cubit<AdditionalDeploymentsState> {
  final AttendanceServices services;
  final int attInfoId;
  final CommonServices commonServices;

  AdditionalDeploymentsCubit({
    required this.services,
    required this.commonServices,
    required this.attInfoId,
  }) : super(
    AdditionalDeploymentsState.initial(
      model: AttendanceModel(),
      locations: Locations(),
      loggedInUserDetails: User(),
      users: const [],
      emailUsers: const [],
      errorMessage: '',
      departments: const [],
    ),
  );

  Future<dynamic> _safeCall(Future Function() call, String label) async {
    try {
      return await call();
    } catch (e) {
      log('Optional call failed: $label -> $e',
          name: 'Additional Deployments Cubit');
      return null;
    }
  }

  List<Organisation> _parseOrgList(dynamic raw) {
    if (raw == null) return const [];

    if (raw is List<Organisation>) return raw;

    if (raw is List) {
      return raw
          .whereType<Object>()
          .map<Organisation>((e) {
        if (e is Organisation) return e;
        if (e is Map) {
          return Organisation.fromJson(Map<String, dynamic>.from(e));
        }
        // Unknown shape - skip rather than crash.
        return Organisation();
      })
          .toList();
    }

    if (raw is Map) {
      // API returned a single object instead of a list.
      return [Organisation.fromJson(Map<String, dynamic>.from(raw))];
    }

    // Unknown/unexpected shape - degrade gracefully instead of crashing.
    return const [];
  }

  Future<void> initializeValues() async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    AttendanceModel model = AttendanceModel();

    try {
      model = await services.getById(attInfoId);

      final futures = await Future.wait([
        _safeCall(() => services.getAdhocDesignation(), 'getAdhocDesignation'), // 0
        _safeCall(() => services.getAdhocDutyHourList(), 'getAdhocDutyHourList'), // 1
        _safeCall(() => services.getAdhocShiftList(), 'getAdhocShiftList'), // 2
        _safeCall(() => services.getAdhocDutyPost(id: model.id), 'getAdhocShiftList'), // 3

        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.attendanceModule), // 4
        services.getAdhocAttendanceById(attInfoId: model.id), // 5
        _safeCall(() {
          final int? locId = model.location?.id;
          final int? vendorId = model.vendor?.id;
          if (locId == null || vendorId == null) {
            log(
              'Skipping getAdhocAvailableGuards: locId=$locId vendorId=$vendorId',
              name: 'Additional Deployments Cubit',
            );
            return Future.value(null);
          }
          return services.getAdhocAvailableGuards(
            locId: locId,
            vendorId: vendorId,
          );
        }, 'getAdhocAvailableGuards'), // 6
      ]);

      final List<Organisation> designations = _parseOrgList(futures[0]);
      final List<Organisation> dutyHoursList = _parseOrgList(futures[1]);
      final List<Organisation> shifts = _parseOrgList(futures[2]);
      final List<Organisation> dutyPost = _parseOrgList(futures[3]);
      final dynamic responseLabels = futures[4];
      final AdhocAttendanceGiModel adhocModel =
      futures[5] as AdhocAttendanceGiModel;
      final List<Organisation> guards = _parseOrgList(futures[6]);


      model.inputDate = model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(model.inputDate ?? '0'), Constants.fulldateFormat);

      model.modifiedDate = model.modifiedDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(model.modifiedDate ?? '0'),
          Constants.fulldateFormat);

      final GmUiLabels labels = GmUiLabels.fromJson(responseLabels);

      emit(
        state.copyWith(
            status: FormStatus.initial,
            model: model,
            labels: labels,
            adhocModel: adhocModel,
            designations: designations,
            shifts: shifts,
            dutyHoursList: dutyHoursList,
            guardsList:guards,
            dutyPostList:dutyPost,
        ),
      );
    } catch (e, st) {
      log('Initialization issue',
          error: e, stackTrace: st, name: 'Attendance Details Cubit');
      emit(
        state.copyWith(
          model: model,
          status: FormStatus.error,
          message: Constants.errorText,
        ),
      );
    }
  }

  void onModelValueChange(AttendanceModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(AttendanceModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  // additional_deployments_cubit.dart

  void mergeDraftDeployments(List<Deployments> newDeployments) {
    if (newDeployments.isEmpty) return;

    final current = state.adhocModel;
    if (current == null) return;

    final updatedDeployments = <Deployments>[
      ...?current.deployments,
      ...newDeployments,
    ];

    final updatedAdhocModel = current.copyWith(deployments: updatedDeployments);

    emit(state.copyWith(adhocModel: updatedAdhocModel));
  }

  // Future<bool> submitForm({
  //   bool isSaveOnly = false,
  //   bool navigateToNextScreen = false,
  // }) async {
  //   emit(
  //     state.copyWith(
  //       status: FormStatus.loading,
  //     ),
  //   );
  //
  //   AdhocAttendanceRequest request = AdhocAttendanceRequest(requestModel: state.adhocModel);
  //
  //   try {
  //     GenericResponse response = GenericResponse();
  //     if (isSaveOnly) {
  //       if (!state.isValidDraft.status) {
  //         emit(
  //           state.copyWith(
  //             status: FormStatus.formError,
  //             message: state.isValidDraft.message,
  //           ),
  //         );
  //         return false;
  //       }
  //       response = (await services.createAdhocAttendance(
  //           body: request, isSubmit: false));
  //     } else {
  //       if (!state.isValid.status) {
  //         emit(
  //           state.copyWith(
  //             status: FormStatus.formError,
  //             message: state.isValid.message,
  //           ),
  //         );
  //         return false;
  //       }
  //       response =
  //       (await services.createAdhocAttendance(body: request, isSubmit: true));
  //     }
  //
  //     log('---response--msg--${response.message}---');
  //
  //     if (response.id != null) {
  //       int? id = int.tryParse(response.id!);
  //       if (id != null) {
  //         state.model.id = id;
  //       }
  //     }
  //     emit(
  //       state.copyWith(
  //         model: state.model,
  //         message: response.message,
  //         status: navigateToNextScreen
  //             ? FormStatus.navigateToNextScreen
  //             : FormStatus.success,
  //       ),
  //     );
  //     return true;
  //   } on GenericResponse catch (e) {
  //     Utils().emitErrorState(e, emit, state);
  //     return false;
  //   } on Exception catch (e) {
  //     emit(
  //       state.copyWith(
  //         message: e.toString(),
  //         status: FormStatus.error,
  //       ),
  //     );
  //     return false;
  //   }
  // }
  //
  Future<bool> submitForm({
    bool isSaveOnly = false,
    bool? isApprovedStatus,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    AdhocAttendanceRequest request =
    AdhocAttendanceRequest(requestModel: state.adhocModel);

    try {
      final GenericResponse response = await services.createAdhocAttendance(
        body: request,
        isSubmit: !isSaveOnly, // <-- was hardcoded `true`; now derives from isSaveOnly
        isApprovedStatus: isApprovedStatus,
        // comment: comment,
      );

      log('---response--msg--${response.message}---');

      if (response.id != null) {
        int? id = int.tryParse(response.id!);
        if (id != null) {
          state.model.id = id;
        }
      }

      emit(
        state.copyWith(
          model: state.model,
          message: response.message,
          status: FormStatus.success,
        ),
      );
      return true;
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      return false;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
      return false;
    }
  }
}