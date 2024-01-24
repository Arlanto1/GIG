import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/models/attendance_model.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/models/requestModel/duty_post_name_master_request.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/models/duty_post_name_master_model.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/models/requestModel/duty_post_name_master_request.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/services/duty_post_name_master_services.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:intl/intl.dart';

part 'attendance_details_state.dart';

class AttendanceDetailsCubit
    extends Cubit<AttendanceDetailsState> {
  final AttendanceServices services;
  final String id;
  final CommonServices commonServices;

  AttendanceDetailsCubit({
    required this.services,
    required this.commonServices,
    required this.id,
  }) : super(
          AttendanceDetailsState.initial(
            model: AttendanceModel(),
            locations: Locations(),
            loggedInUserDetails: User(),
            users: const [],
            emailUsers: const [],
            errorMessage: '',
          ),
        );

  void onModelValueChange(AttendanceModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(AttendanceModel model) {
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

    AttendanceModel model = AttendanceModel();
    if (id.isNotEmpty) {
      model = await services.getById(int.tryParse(id) ?? 0);
    }

    var userId = await SharedPrefs.getUserId();
    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getLocations(name: 'ATOM_LOCATIONS'), // 0
        commonServices.getUserDetails(userId: userId), // 1
        commonServices.getUsersByRole(roleName: 'T1_Analyst'), // 2
        commonServices.getEntities(name: 'ATOM_ENTITIES'), // 3
        commonServices.getUsers(), // 3
        // services.getDutyPostsById(id: model.id),
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
      List<DutyPostModel> dutyPosts = futures[5];
      GetDepositor emailUsers = futures[6];
      Vendors vendors = futures[8];
      dynamic responseLabels = futures[9];
      Organisation? defaultLocation = futures[10];
      if (state.model.location == null && defaultLocation != null) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: defaultLocation.id.toString(),
          moduleCode: Constants.shiftScheduleModule,
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
          vendors: vendors.items,
          users: users.t1Analyst,
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
    AttendanceRequest request =
    AttendanceRequest(requestModel: state.model); // TODO: state.model

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
