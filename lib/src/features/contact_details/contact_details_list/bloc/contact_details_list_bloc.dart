import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:db_atom/src/utils/utils_common.dart';

import '../../services/contact_details_services.dart';

part 'contact_details_list_event.dart';
part 'contact_details_list_state.dart';

class ContactDetailsListBloc
    extends Bloc<ContactDetailsListEvent, ContactDetailsListState> {
  ContactDetailsListBloc() : super(const ContactDetailsListState()) {
    on<InitializeValuesCD>(_initializeValues);
    on<FetchData>(
      _fetchContactDetails,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final ContactDetailsServices services = ContactDetailsServices();
  final CommonServices commonServices = CommonServices();

  // FutureOr<void> _initializeValues(
  //     InitializeValues event, Emitter<ContactDetailsListState> emit) async {
  //   try {
  //     dynamic responseLabels = await commonServices.getUiLabels(
  //         language: await SharedPrefs.getLanguageCode(),
  //         moduleCode: Constants.contactDetailsModuleCode);
  //     CdUiLabels labels = CdUiLabels.fromJson(responseLabels);
  //     return emit(
  //       state.copyWith(
  //         labels: labels,
  //         hasReachedMax: false,
  //       ),
  //     );
  //   } on Exception {
  //     return emit(state.copyWith(status: FormStatus.failure));
  //   }
  // }
  FutureOr<void> _initializeValues(
      InitializeValuesCD event, Emitter<ContactDetailsListState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));
      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.contactDetailsModuleCode);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.contactDetailsModuleCode);

      ExtraProperties extraProperties =
      await UtilsCommon().checkWritePermission(
        moduleCode: Constants.contactDetailsModuleCode,
        commonServices: commonServices,
      );
      CdUiLabels labels = CdUiLabels.fromJson(responseLabels);
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
          status: FormStatus.error,
        ),
      );
      return;
    }on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _refreshList(
      RefreshList event, Emitter<ContactDetailsListState> emit) async {
    try {
      ContactDetailsListResponseModel response;

      response = await services.getGcdWithFilters(
        startPosition: '${0}',
        maximumRecords: '${20}',
        // mmType: isInward ? 1 : 0,
        filters: BaseFilterModel(),
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

  // FutureOr<void> _fetchContactDetails(
  //     FetchData event, Emitter<ContactDetailsListState> emit) async {
  //   try {
  //     if (state.hasReachedMax) return;
  //
  //     if (state.status == FormStatus.initial || event.newSearch) {
  //       ContactDetailsListResponseModel response =
  //           await services.getGcdWithFilters(
  //         startPosition: '${event.startPos}',
  //         maximumRecords: '${event.maxPos}',
  //         filters: BaseFilterModel(),
  //       );
  //
  //       return emit(
  //         state.copyWith(
  //           items: response.items,
  //           hasReachedMax: false,
  //           status: FormStatus.success,
  //         ),
  //       );
  //     }
  //
  //     ContactDetailsListResponseModel response =
  //         await services.getGcdWithFilters(
  //       startPosition: '${event.startPos}',
  //       maximumRecords: '${event.maxPos}',
  //       filters: BaseFilterModel(),
  //     );
  //
  //     if (response.items?.isEmpty == true) {
  //       return emit(state.copyWith(hasReachedMax: true));
  //     }
  //     return emit(
  //       state.copyWith(
  //         items: List.of(state.items)..addAll(response.items ?? []),
  //         hasReachedMax: false,
  //       ),
  //     );
  //   } on TokenExpiredException catch (e) {
  //     emit(
  //       state.copyWith(
  //         message: e.message,
  //         status: FormStatus.sessionExpired,
  //       ),
  //     );
  //     return;
  //   } catch (e) {
  //     return emit(state.copyWith(status: FormStatus.failure));
  //   }
  // }
  FutureOr<void> _fetchContactDetails(
      FetchData event, Emitter<ContactDetailsListState> emit) async {
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
        ContactDetailsListResponseModel response;
        // response = await services.getMaterialMovements(
        //   startPosition: '${event.startPos}',
        //   maximumRecords: '${event.maxPos}',
        //   mmType: isInward ? 1 : 0,
        // );

        response = await services.getGcdWithFilters(
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

      log('-_fetchMaterialMovements------##--');
      ContactDetailsListResponseModel response;
      response = await services.getGcdWithFilters(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
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
