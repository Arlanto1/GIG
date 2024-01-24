import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/models/duty_post_name_master_model.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/models/requestModel/duty_post_name_master_request.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/services/duty_post_name_master_services.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:intl/intl.dart';

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

  String _getCurrentDate() {
    return DateFormat(Constants.fulldateFormat).format(DateTime.now());
  }

  Future<void> initializeValues() async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    var userId = await SharedPrefs.getUserId();
    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getLocations(name: 'ATOM_LOCATIONS'),
        commonServices.getUserDetails(userId: userId),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.guardingMasterModuleCode),
        SharedPrefs.getDefaultLocation(),
      ]);

      Locations getLocationsData = futures[0];
      User loggedInUserDetails = futures[1];
      dynamic responseLabels = futures[2];
      Organisation? defaultLocation = futures[3];
      if (state.model.location == null && defaultLocation != null) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: defaultLocation.id.toString(),
          moduleCode: Constants.dutyPostNameMasterModule,
        );
        state.model.location = defaultLocation;
        state.model.slNo = slNo.serialNo;
      }

      state.model.entrySecurity = loggedInUserDetails;
      // Get Date of Creation
      state.model.inputDate = _getCurrentDate();

      GmUiLabels labels = GmUiLabels.fromJson(responseLabels);

      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          locationNames: state.model.locationNames,
          labels: labels,
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

  void onAddDutyPostLocationName(String locationName) {
    log('-locationNames---$locationName-');

    emit(state.copyWith(
      model: model,
      status: FormStatus.loading,
    ));

    // state.model??=DutyPostNameMasterModel();
    log('-state.locationNames---before-1--${model?.locationNames}----');
    model?.locationNames??=[];
    model?.locationNames?.add(locationName);
    log('-state.locationNames---after-2--${model?.locationNames}----');

    emit(state.copyWith(
      model: model,
      status: FormStatus.initial,
    ));
  }

  Future<void> updateDropdownValues({
    Organisation? location,
    BaseUser? user,
    Organisation? vendor,
    int? status,
    int? guardRank,
    int? dutyType,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    ////Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.dutyPostNameMasterModule,
      );

      state.model.location = location;
      state.model.slNo = slNo.serialNo;
    }

    state.model.status = status ?? state.model.status;
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void submitForm({bool isSaveOnly = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (state.model.status == 0 || state.model.status == null) {
      state.model.status = 1;
    }
    // Setting time in milliseconds
    state.model.inputDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    // Create/Update API Call
    DutyPostNameMasterRequest request =
        DutyPostNameMasterRequest(dutyPostNameMaster: state.model);

    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValidDraft.message,
            ),
          );
          return;
        }
        response = (await services.create(
            body: request, isSubmit: false));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValid.message,
            ),
          );
          return;
        }
        response = (await services.create(
            body: request, isSubmit: true));
      }
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
}
