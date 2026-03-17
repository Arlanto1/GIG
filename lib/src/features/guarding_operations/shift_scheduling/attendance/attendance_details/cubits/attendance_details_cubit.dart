import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
import 'package:intl/intl.dart';

part 'attendance_details_state.dart';

class AttendanceDetailsCubit extends Cubit<AttendanceDetailsState> {
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
            departments: const [],
          ),
        );

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
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'), // 0
        commonServices.getUserDetails(userId: userId), // 1
        // commonServices.getUsersByRole(roleName: 'T1_Analyst'), // 2
        // commonServices.getUsers(), // 3
        // commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER'), // 3
        commonServices.getVendors(name: 'ATOM_VENDORS'), // 4
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.attendanceModule), // 5
        SharedPrefs.getDefaultLocation(), // 6
        services.getDutyPostsById(id: model.id), // 7
      ]);

      Locations getLocationsData = futures[0];
      User loggedInUserDetails = futures[1];
      // Analyst users = futures[2];
      // List<User> entrySecurities = futures[3];
      // GetDepositor emailUsers = futures[3];
      Vendors vendors = futures[2];
      dynamic responseLabels = futures[3];
      Organisation? defaultLocation = futures[4];
      List<DutyPostModel> dutyPosts = futures[5];

      if (model.location == null && defaultLocation != null) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: defaultLocation.id.toString(),
          moduleCode: Constants.attendanceModule,
        );
        model.location = defaultLocation;
        model.slNo = slNo.serialNo;
      }
      // model.entrySecurity = loggedInUserDetails;
      // Get Date of Creation
      // model.inputDate = _getCurrentDate();
      // model.inputDate = model.inputDate == null
      //     ? Utils().getCurrentDate()
      //     : Utils().formatUnixTimestamp(model.inputDate ?? '');

      model.inputDate = model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(model.inputDate ?? '0'), Constants.fulldateFormat);

      model.modifiedDate = model.modifiedDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(model.modifiedDate ?? '0'), Constants.fulldateFormat);

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
          // users: users.t1Analyst,
          // entrySecurities: entrySecurities,
          // emailUsers: emailUsers.atomStaticUser,
          dutyPosts: dutyPosts,
          labels: labels,
        ),
      );
    } catch (e) {
      log('Initialization issue', error: e, name: 'Attendance Details Cubit');
      emit(
        state.copyWith(
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

  Future<void> updateDropdownValues({
    Organisation? location,
    BaseUser? user,
    Organisation? vendor,
    int? status,
    int? attendanceType,
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
        moduleCode: Constants.attendanceModule,
      );

      state.model.location = location;
      state.model.slNo = slNo.serialNo;
    }
    state.model.attendanceType = attendanceType ?? state.model.attendanceType;
    state.model.dutyType = dutyType ?? state.model.dutyType;
    state.model.vendor = vendor ?? state.model.vendor;
    state.model.status = status ?? state.model.status;
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  Future<bool> submitForm({
    bool isSaveOnly = false,
    bool navigateToNextScreen = false,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (state.model.status == 0 || state.model.status == null) {
      state.model.status = 0;
    }
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
    AttendanceRequest request = AttendanceRequest(requestModel: state.model);

    try {
      GenericResponse response = GenericResponse();
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValidDraft.message,
            ),
          );
          return false;
        }
        response =
        (await services.createAttendanceGi(body: request, isSubmit: false));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return false;
        }
        response =
        (await services.createAttendanceGi(body: request, isSubmit: true));
      }

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
          status: navigateToNextScreen
              ? FormStatus.navigateToNextScreen
              : FormStatus.success,
        ),
      );
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      return true;
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      return false;
    } on Exception catch (e) {
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
      return false;
    }
  }
  Future<void> navigateToNextScreen({
    required int dutyPostNameId,
    required DutyPostModel dutyPostModel,
  }) async {
    log('-navigateToNextScreen----attInfoId----${state.model.id}----dutyPostNameId---$dutyPostNameId-----');
    emit(state.copyWith(status: FormStatus.loading));
    emit(state.copyWith(
      status: FormStatus.navigateToNextScreen,
      parentId: state.model.id,
      selectedDutyPostNameId: dutyPostNameId,
      selectedDutyPostModel: dutyPostModel,
    ));
  }

  void updateStatus({required String id}) {
    commonServices.updateRecordStatus(
        id: id, module: Constants.attendanceModule);
  }
}
