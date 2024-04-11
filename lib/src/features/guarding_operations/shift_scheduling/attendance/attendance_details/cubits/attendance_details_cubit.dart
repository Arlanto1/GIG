import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
import 'package:db_atom/src/services/common_services.dart';
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
        commonServices.getUsersByRole(roleName: 'T1_Analyst'), // 2
        commonServices.getUsers(), // 3
        commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER'), // 4
        commonServices.getVendors(name: 'ATOM_VENDORS'), // 5
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.attendanceModule), // 6
        SharedPrefs.getDefaultLocation(), // 7
        services.getDutyPostsById(id: model.id), // 8
      ]);

      Locations getLocationsData = futures[0];
      User loggedInUserDetails = futures[1];
      Analyst users = futures[2];
      List<User> entrySecurities = futures[3];
      GetDepositor emailUsers = futures[4];
      Vendors vendors = futures[5];
      dynamic responseLabels = futures[6];
      Organisation? defaultLocation = futures[7];
      List<DutyPostModel> dutyPosts = futures[8];

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
              int.tryParse(model?.inputDate ?? '0'), Constants.fulldateFormat);

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
    // state.model.inputDate =
    //     (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    DateTime dateTime =
        DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
    int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
    state.model.inputDate = inputDate.toString();
    // Create/Update API Call
    AttendanceRequest request = AttendanceRequest(requestModel: state.model);

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
        response = (await services.create(body: request, isSubmit: false));
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
        response = (await services.create(body: request, isSubmit: true));
      }
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model?.inputDate ?? '0'),
              Constants.fulldateFormat);
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
        ),
      );
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

  Future<void> navigateToNextScreen({required int dutyPostNameId}) async {
    log('-navigateToNextScreen----attInfoId----${state.model.id}----dutyPostNameId---$dutyPostNameId-----');
    emit(state.copyWith(status: FormStatus.loading));
    emit(state.copyWith(
        status: FormStatus.navigateToNextScreen,
        parentId: state.model.id,
        selectedDutyPostNameId: dutyPostNameId));
  }

  void updateStatus({required String id}) {
    commonServices.updateRecordStatus(
        id: id, module: Constants.attendanceModule);
  }
}
