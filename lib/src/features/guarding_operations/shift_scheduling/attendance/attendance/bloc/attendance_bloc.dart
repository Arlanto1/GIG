import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';

part 'attendance_event.dart';

part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(const AttendanceState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchAttendanceList>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final AttendanceServices _services = AttendanceServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _refreshList(
      RefreshList event, Emitter<AttendanceState> emit) async {
    try {
      AttendanceResponse response;

      response = await _services.getList(
        startPosition: '${0}',
        maximumRecords: '${20}',
        filters: BaseFilterModel(),
      );

      return emit(
        state.copyWith(
          items: response.items,
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<AttendanceState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
          await UtilsCommon().checkWritePermission(
        moduleCode: Constants.attendanceModuleCode,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.attendanceModuleCode);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.attendanceModuleCode);

      SSUiLabels labels = SSUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          labels: labels,
          statuses: statuses,
          commonFilters: commonFilters,
          hasReachedMax: false,
          status: FormStatus.initial,
          extraProperties: extraProperties,
        ),
      );
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
        ),
      );
      return;
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

//   FutureOr<void> _fetchList(FetchAttendanceList event,
//       Emitter<AttendanceState> emit) async {
//     try {
//       if (state.hasReachedMax) return;
//
//       if (state.status == FormStatus.initial) {
//         AttendanceResponse getAttendanceLists =
//         await _services.getList(
//           startPosition: '${event.startPos}',
//           maximumRecords: '${event.maxPos}',
//         );
//         return emit(
//           state.copyWith(
//             items: getAttendanceLists.items,
//             hasReachedMax: false,
//             status: FormStatus.success,
//           ),
//         );
//       }
//
//       AttendanceResponse getAttendanceList =
//       await _services.getList(
//         startPosition: '${event.startPos}',
//         maximumRecords: '${event.maxPos}',
//       );
//
//       if (getAttendanceList.items?.isEmpty == true) {
//         return emit(state.copyWith(hasReachedMax: true));
//       }
//       return emit(
//         state.copyWith(
//           items: List.of(state.items)
//             ..addAll(getAttendanceList.items?.toList() ?? []),
//           hasReachedMax: false,
//         ),
//       );
//     }
//     // on TokenExpiredException catch (e) {
//     //   emit(
//     //     state.copyWith(
//     //       message: e.message,
//     //       status: FormStatus.sessionExpired,
//     //     ),
//     //   );
//     //   return;
//     // }
//     catch (e) {
//       return emit(state.copyWith(status: FormStatus.failure));
//     }
//   }
// }
  FutureOr<void> _fetchList(
      FetchAttendanceList event, Emitter<AttendanceState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      // if (state.hasReachedMax) return;
      log('---state.status-${state.status}--');
      log('---event.newSearch-${event.newSearch}--');

      if (state.status == FormStatus.initial || event.newSearch) {
        AttendanceResponse response;
        response = await _services.getList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          filters: event.filters,
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      AttendanceResponse response;
      response = await _services.getList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        filters: event.filters,
      );

      if (response.items?.isEmpty == true) {
        return emit(state.copyWith(
          hasReachedMax: true,
          status: FormStatus.success,
        ));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items)..addAll(response.items ?? []),
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on TokenExpiredException catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.sessionExpired,
        ),
      );
      return;
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
