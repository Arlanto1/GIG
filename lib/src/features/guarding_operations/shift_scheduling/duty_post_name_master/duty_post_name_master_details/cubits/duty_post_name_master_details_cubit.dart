import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/models/dpn_ui_labels.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/services/duty_post_name_master_services.dart';
import 'package:intl/intl.dart';

import '../../../../../../models/location_Type_Model.dart';

part 'duty_post_name_master_details_state.dart';

class DutyPostNameMasterDetailsCubit
    extends Cubit<DutyPostNameMasterDetailsState> {
  final DutyPostNameMasterServices services;
  final DutyPostNameMasterModel? model;
  final CommonServices commonServices;

  DutyPostNameMasterDetailsCubit({
    required this.services,
    required this.commonServices,
    required this.model,
  }) : super(
          DutyPostNameMasterDetailsState.initial(
            model: model ?? DutyPostNameMasterModel(),
            locations: Locations(),
            loggedInUserDetails: User(),
            users: const [],
            emailUsers: const [],
            errorMessage: '',
            getLocationType: GetLocationType(),
          ),
        );

  void onModelValueChange(DutyPostNameMasterModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(DutyPostNameMasterModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  /// Finds the region id that contains the given location id.
  int? _getRegionIdForLocation(Locations? locations, int? locationId) {
    if (locations == null || locationId == null) return null;

    for (final region in locations.regions ?? []) {
      final bool found =
          region.locations?.any((loc) => loc.id == locationId) ?? false;
      if (found) return region.id;
    }
    return null;
  }
  Future<void> initializeValues() async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    var userId = await SharedPrefs.getUserId();
    final Locations locations =
    await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');
    final int? regionId =
    _getRegionIdForLocation(locations, state.model.location?.id);

    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),//0
        commonServices.getUserDetails(userId: userId),//1
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.guardingMasterModuleCode),//2
        //SharedPrefs.getDefaultLocation(),
        commonServices.getLocationType(locId: regionId!),

      ]);

      Locations getLocationsData = futures[0];
      User loggedInUserDetails = futures[1];
      dynamic responseLabels = futures[2];
      GetLocationType? getLocationType = futures[3];
      //Organisation? defaultLocation = futures[3];
      // if (state.model.location == null && defaultLocation != null) {
      //   SerialNumberModel slNo = await commonServices.getSlNo(
      //     locationId: defaultLocation.id.toString(),
      //     moduleCode: Constants.dutyPostNameMasterModule,
      //   );
      //   state.model.location = defaultLocation;
      //   state.model.slNo = slNo.serialNo;
      // }
      log('input Date ${state.model.inputDate}');
      state.model.entrySecurity ??= loggedInUserDetails;

      // state.model?.inputDate = state.model?.inputDate != null
      //     ? Utils().formatUnixTimestamp(state.model?.inputDate ?? '') : Utils().getCurrentDate();

      // state.model.inputDate = state.model.inputDate == null
      //     ? Utils().getCurrentDate()
      //     : Utils().formatUnixTimestamp(state.model.inputDate ?? '');
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);

      state.model.modifiedDate = state.model.modifiedDate == null
          ? Utils().getCurrentDate()
          : Utils().formatUnixTimestamp(state.model.modifiedDate ?? '');
      // Get Date of Creation
      // state.model?.inputDate =
      //     DateFormat(Constants.fulldateFormat).format(DateTime.now());
      // state.model?.modifiedDate =
      //     DateFormat(Constants.fulldateFormat).format(DateTime.now());
      DPNUiLabels labels = DPNUiLabels.fromJson(responseLabels);

      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          locationNames: state.model.dpName,
          labels: labels,
          getLocationType: getLocationType,
        ),
      );
    } catch (e) {
      log('Initialization issue',
          error: e, name: 'Duty Post Name Master Details Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.error,
        ),
      );
    }
  }

  void onAddDutyPostLocationName(DpName locationName) {
    log('-locationNames---$locationName-');

    emit(state.copyWith(
      model: model,
      status: FormStatus.loading,
    ));

    // state.model??=DutyPostNameMasterModel();
    model?.dpName ??= [];
    model?.dpName?.add(locationName);

    emit(state.copyWith(
      model: model,
      status: FormStatus.initial,
    ));
  }

  Future<void> updateLocationDropdownValue({
    Organisation? location,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    GetLocationType? locType = state.getLocationType;

    // Get Sl No from API
    if (location != null) {
      state.model.location = location;
      final int? locationId = location.id;
      final int? regionId =
      _getRegionIdForLocation(state.locations, locationId);
      locType = await commonServices.getLocationType(locId: regionId!);
    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
      getLocationType: locType,
    ));
  }
  Future<void> updateDropdownValues({
    Organisation? location,
    BaseUser? user,
    Organisation? vendor,
    int? status,
    int? guardRank,
    int? dutyType,
    Organisation? locationType,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );


    GetLocationType? locType = state.getLocationType;

    /// Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.dutyPostNameMasterModule,
      );
      final int? locationId = location.id;
      final int? regionId =
      _getRegionIdForLocation(state.locations, locationId);
      locType = await commonServices.getLocationType(locId: regionId!);


      state.model.location = location;
      state.model.slNo = slNo.serialNo;

      try {
        await services.checkDutyPostNameExists(locationId: location.id!);
      } on GenericResponse catch (e) {
        state.model.location = null;
        state.model.slNo = null;

        log('----GenericResponse---');
        emit(
          state.copyWith(
            model: state.model,
            message: e.message,
            status: FormStatus.formError,
          ),
        );
      } on Exception catch (e) {
        state.model.location = null;
        state.model.slNo = null;
        emit(
          state.copyWith(
            model: state.model,
            message: e.toString(),
            status: FormStatus.formError,
          ),
        );
        return;
      }
    }

    if (locationType != null) {
      state.model.locationType = locationType;
    }

    state.model.status = status ?? state.model.status;
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
      getLocationType: locType,
    ));
  }

  void submitForm({bool isSaveOnly = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    state.model.status = !isSaveOnly ? 1 : (state.model.status ?? 0);
    //state.model.status ??= 0;
    // Setting time in milliseconds
    // state.model.inputDate =
    //     (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.inputDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.inputDate = inputDate.toString();
    }

    // Create/Update API Call
    DutyPostNameMasterRequest request =
        DutyPostNameMasterRequest(dutyPostNameMaster: state.model);

    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValidDraft.message,
            ),
          );
          return;
        }
        response = (await services.create(body: request, isSubmit: false));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return;
        }
        response = (await services.create(body: request, isSubmit: true));
      }
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
      return;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }

    log('---response--msg--${response.message}---');

    emit(
      state.copyWith(
        message: response.message,
        status: FormStatus.success,
      ),
    );
  }

  void updateStatus({required String id}) {
    log('-updateStatus-$id--');

    commonServices.updateRecordStatus(
        id: id, module: Constants.dutyPostNameMasterModule);
  }
}
