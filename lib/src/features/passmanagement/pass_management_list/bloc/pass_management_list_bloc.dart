import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:db_atom/src/features/contact_details/models/cd_ui_labels.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/services/day_passlist_services.dart';
import 'package:db_atom/src/models/base_filter_model.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/models/responseModels/token_expired.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';

import '../../daypassmgmt/passmgmtlist/models/day_passlist_model.dart';

part 'pass_management_list_event.dart';

part 'pass_management_list_state.dart';

class PassManagementListBloc
    extends Bloc<PassManagementListEvent, PassManagementListState> {
  final int passId;

  PassManagementListBloc({required this.passId})
      : super(const PassManagementListState()) {
    on<InitializeValuesMM>(_initializeValues);
    on<FetchData>(
      _fetchMaterialMovements,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final DayPassListServices services = DayPassListServices();

  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValuesMM event, Emitter<PassManagementListState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));
      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.materialMovementModuleCode);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.contactDetailsModuleCode);
      CdUiLabels labels = CdUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          statuses: statuses,
          commonFilters: commonFilters,
          hasReachedMax: false,
          status: FormStatus.initial,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _refreshList(
      RefreshList event, Emitter<PassManagementListState> emit) async {
    try {
      DayPassListResponse response;

      response = await services.getList(
        startPosition: '${0}',
        maximumRecords: '${20}',
        passType: passId.toString(),
        // filters: BaseFilterModel(),
      );

      return emit(
        state.copyWith(
          items: response.items,
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _fetchMaterialMovements(
      FetchData event, Emitter<PassManagementListState> emit) async {
    log('-_fetchMaterialMovements--');

    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      // if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial || event.newSearch) {
        log('-_fetchMaterialMovements--initial--');
        DayPassListResponse response;

        response = await services.getList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          passType: passId.toString(),
          // filters: BaseFilterModel(),
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );

        // response = await services.getMaterialMovementsWithFilters(
        //   startPosition: '${event.startPos}',
        //   maximumRecords: '${event.maxPos}',
        //   mmType: passId ? 1 : 0,
        //   filters: event.filters,
        // );
        //
        // return emit(
        //   state.copyWith(
        //     items: response.items,
        //     hasReachedMax: false,
        //     status: FormStatus.success,
        //   ),
        // );
      }

      log('-_fetchMaterialMovements------##--');
      DayPassListResponse response;

      response = await services.getList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        passType: passId.toString(),
        // filters: BaseFilterModel(),
      );

      if (response.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
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
