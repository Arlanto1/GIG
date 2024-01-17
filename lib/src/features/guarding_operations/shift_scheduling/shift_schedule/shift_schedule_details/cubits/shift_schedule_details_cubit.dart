import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/vendors_model.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/models/gm_ui_labels.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/models/requestModel/shift_schedule_request.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/models/shift_schedule_response.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/services/shift_schedule_services.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:intl/intl.dart';

part 'shift_schedule_details_state.dart';

class ShiftScheduleDetailsCubit extends Cubit<ShiftScheduleDetailsState> {
  final ShiftScheduleServices services;

  // final ShiftScheduleModel? model;
  final CommonServices commonServices;
  final String id;

  ShiftScheduleDetailsCubit({
    required this.services,
    required this.commonServices,
    // required this.model,
    required this.id,
  }) : super(
          ShiftScheduleDetailsState.initial(
            model: ShiftScheduleModel(),
            locations: Locations(),
            loggedInUserDetails: User(),
            users: const [],
            emailUsers: const [],
            errorMessage: '',
            departments: const [],
          ),
        );

  void onModelValueChange(ShiftScheduleModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(ShiftScheduleModel model) {
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

    ShiftScheduleModel model = ShiftScheduleModel();
    if (id.isNotEmpty) {
      model = await services.getById(int.tryParse(id) ?? 0);
    }

    var userId = await SharedPrefs.getUserId();
    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getLocations(name: 'ATOM_LOCATIONS'),
        commonServices.getUserDetails(userId: userId),
        commonServices.getUsersByRole(roleName: 'T1_Analyst'),
        commonServices.getEntities(name: 'ATOM_ENTITIES'),
        commonServices.getUsers(),
        commonServices.getQualification(name: 'GUARD_QUALIFICATIONS'),
        commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER'),
        commonServices.getDepartments(name: 'ATOM_VENDORS'),
        commonServices.getVendors(name: 'ATOM_VENDORS'),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.guardingMasterModuleCode),
        SharedPrefs.getDefaultLocation(),
      ]);

      Locations getLocationsData = futures[0];
      User loggedInUserDetails = futures[1];
      Analyst users = futures[2];
      List<User> entrySecurities = futures[4];
      GetDepositor emailUsers = futures[6];
      Vendors vendors = futures[8];
      dynamic responseLabels = futures[9];
      Organisation? defaultLocation = futures[10];
      if (state.model.location == null && defaultLocation != null) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: defaultLocation.id.toString(),
          moduleCode: Constants.contactDetailsModule,
        );
        model.location = defaultLocation;
        model.slNo = slNo.serialNo;
      }
      model.entrySecurity = loggedInUserDetails;
      // Get Date of Creation
      model.inputDate = _getCurrentDate();

      // dynamic participationDates = Utils()
      //     .splitStringAfterComma(state.model.csrParticipationDates ?? '');

      GmUiLabels labels = GmUiLabels.fromJson(responseLabels);

      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: model,
          users: users.t1Analyst,
          vendors: vendors.items,
          entrySecurities: entrySecurities,
          emailUsers: emailUsers.atomStaticUser,
          labels: labels,
        ),
      );
    } catch (e) {
      log('Initialization issue',
          error: e, name: 'Guarding Master Data Details Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.error,
        ),
      );
    }
  }

  Future<void> updateDropdownValues({
    Organisation? location,
    Organisation? vendor,
    int? status,
    int? systemAccess,
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
        moduleCode: Constants.guardingMasterDataModule,
      );

      // state.model.location = location;
      state.model.slNo = slNo.serialNo;
    }

    state.model.dutyType = dutyType ?? state.model.dutyType;
    state.model.status = status ?? state.model.status;
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
    ShiftScheduleRequest request =
        ShiftScheduleRequest(shiftScheduleModel: state.model);

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
        response = (await services.createShiftSchedule(
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
        response =
            (await services.createShiftSchedule(body: request, isSubmit: true));
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
