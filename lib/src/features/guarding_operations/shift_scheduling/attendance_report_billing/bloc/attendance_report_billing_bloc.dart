import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
import 'package:db_atom/src/services/common_services.dart';

part 'attendance_report_billing_event.dart';
part 'attendance_report_billing_state.dart';

class AttendanceReportBillingBloc
    extends Bloc<AttendanceReportBillingEvent, AttendanceReportBillingState> {
  AttendanceReportBillingBloc() : super(const AttendanceReportBillingState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchAttendanceList>(
      _fetchList,
      transformer: droppable(),
    );
  }

  final AttendanceServices _services =
  AttendanceServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<AttendanceReportBillingState> emit) async {
    try {
      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.guardingMasterModuleCode);
      // GmUiLabels labels = GmUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          //labels: labels,
          hasReachedMax: false,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _fetchList(FetchAttendanceList event,
      Emitter<AttendanceReportBillingState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        AttendanceResponse getAttendanceLists =
        await _services.getList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
        );
        return emit(
          state.copyWith(
            items: getAttendanceLists.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      AttendanceResponse getAttendanceList =
      await _services.getList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
      );

      if (getAttendanceList.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items)
            ..addAll(getAttendanceList.items?.toList() ?? []),
          hasReachedMax: false,
        ),
      );
    }
    // on TokenExpiredException catch (e) {
    //   emit(
    //     state.copyWith(
    //       message: e.message,
    //       status: FormStatus.sessionExpired,
    //     ),
    //   );
    //   return;
    // }
    catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
