import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/features/passmanagement/models/pm_ui_labels.dart';
import 'package:db_atom/src/features/passmanagement/vendor_pass_management/models/vendor_pass_management_model.dart';
import 'package:db_atom/src/features/passmanagement/vendor_pass_management/services/vendor_pass_management_service.dart';
import 'package:db_atom/src/models/base_filter_model.dart';
import 'package:db_atom/src/models/extra_properties.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/models/responseModels/generic_response.dart';
import 'package:db_atom/src/models/responseModels/token_expired.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:db_atom/src/utils/utils_common.dart';
import 'package:equatable/equatable.dart';

part 'vendor_pass_management_list_event.dart';
part 'vendor_pass_management_list_state.dart';

class VendorPassManagementListBloc
    extends Bloc<VendorPassManagementListEvent, VendorPassManagementListState> {
  final int passId;

  VendorPassManagementListBloc({required this.passId})
      : super(const VendorPassManagementListState()) {
    on<InitializeVendorPassValues>(_initializeValues);
    on<FetchVendorPassData>(
      _fetchDayPassManagements,
      transformer: droppable(),
    );
    on<RefreshVendorPassList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final VendorPassManagementServices services = VendorPassManagementServices();

  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeVendorPassValues event, Emitter<VendorPassManagementListState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
      await UtilsCommon().checkWritePermission(
        moduleCode: Constants.passManagementRolesModuleCode,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.passManagementModuleCode);

      List<Organisation> regions =
      await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
      CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
      await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.passManagementRolesModuleCode);

      PMUiLabels labels = PMUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          statuses: statuses,
          commonFilters: commonFilters,
          hasReachedMax: false,
          status: FormStatus.initial,
          labels: labels,
          extraProperties: extraProperties,
        ),
      );
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.formError,
        ),
      );
      return;
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

  FutureOr<void> _refreshList(
      RefreshVendorPassList event, Emitter<VendorPassManagementListState> emit) async {
    try {
      VendorPassManagementResponse response;

      response = await services.getVendorPassManagementList(
        startPosition: '0',
        maximumRecords: '20',
        passType: 2,
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

  FutureOr<void> _fetchDayPassManagements(
      FetchVendorPassData event, Emitter<VendorPassManagementListState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {

      if (state.status == FormStatus.initial || event.newSearch) {
        VendorPassManagementResponse response;

        response = await services.getVendorPassManagementList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          passType: 2,
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

      VendorPassManagementResponse response;

      response = await services.getVendorPassManagementList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        passType: 2,
        filters: event.filters,
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
