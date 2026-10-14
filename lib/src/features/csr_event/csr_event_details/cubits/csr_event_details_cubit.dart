import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/csr_event/models/csr_event_model.dart';
import 'package:db_atom/src/features/csr_event/services/csr_event_services.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/general_info/models/ep_ui_labels.dart';

import '../../../../models/location_Type_Model.dart';

part 'csr_event_details_state.dart';

class CSRGeneralInfoCubit extends Cubit<CSRGeneralInfoState> {
  final CSREventServices services;
  final int id;
  final CommonServices commonServices;
final bool? isCSREvent;
  CSRGeneralInfoCubit({
    required this.services,
    required this.commonServices,
    required this.id,
    required this.isCSREvent,

  }) : super(
    CSRGeneralInfoState.initial(
      model: CSREventGiModel(),
      locations: Locations(),
      users: const [],
      emailUsers: const [],
      errorMessage: '',
      loadAttachments: const [],
      eventId: null,
      listOfEntities: const [],
      getEntitiesResponse: null,
      departments: const [],
      vendors: const [],
      loggedInUserDetails: null,
      getLocationType: GetLocationType(),
    ),
  );

  void onModelValueChange(CSREventGiModel csrEventGi) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: csrEventGi, status: FormStatus.initial));
  }

  void onCheckBoxChange(CSREventGiModel csrEventGi) {
    emit(state.copyWith(model: csrEventGi, status: FormStatus.loading));

    emit(state.copyWith(model: csrEventGi, status: FormStatus.initial));
  }

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    List<Organisation>? entities =
    await commonServices.getOrganisations(name: 'ATOM_ENTITIES');
    EmployeeDepartments departments =
    await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');
    List<BaseUser> emailUsers = await commonServices.getBaseUsers(
        isDbUser: true,
        roleName: 'ATOM_STATIC_USER', locationId: state.model.location?.id);
    List<BaseUser> epm = await commonServices.getBaseUsersByRoles(
        isDbUser: true,
        roleNames: 'ATOM_Sub_Regional_Head',
        locationId: state.model.location!.id!);
    List<BaseUser> lsm = await commonServices.getBaseUsersByRoles(
        isDbUser: true,
        roleNames: ConstantUserRoles.atomSecurityAndSeniorSecurityManagerUser,
        locationId: state.model.location!.id!);

    emit(
      state.copyWith(
        getEntitiesResponse: entities,
        listOfEntities: entities,
        status: FormStatus.initial,
        epm: epm,
        lsm: lsm,
        emailUsers: emailUsers,
        departments: departments.employeeDepartments,
      ),
    );
  }

  Future<void> initializeValues() async {
    log('-status-1-${state.status}--');
    // Show Loader and emit loading state
    emit(state.copyWith(status: FormStatus.loading));

    var userId = await SharedPrefs.getUserId();

    // Initialize model outside of Future.wait
    CSREventGiModel model =
    await services.getGI(id);
    debugPrint('ID12345');

    final Locations locations =
    await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');
    final int? locationId =  state.model.location?.id;

    try {
      // Perform multiple asynchronous operations concurrently
      final List<dynamic> results = await Future.wait([
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),
        SharedPrefs.getDefaultLocation(),
        commonServices.getUserDetails(userId: userId),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.eventProtectionModuleCode),
        // commonServices.getUsersByRole(roleName: 'T1_Analyst'),
        commonServices.getBaseUsers(
            isDbUser: true,
            roleName: 'ATOM_STATIC_USER', locationId: model.location?.id),
        commonServices.getOrganisations(name: 'ATOM_ENTITIES'),
        commonServices.getVendors(name: 'ATOM_VENDORS'),
        // commonServices.getUsers(),
        commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS'),
        commonServices.getBaseUsersByRoles(
            isDbUser: true,
            roleNames: 'ATOM_Sub_Regional_Head',
            locationId: model.location!.id!),
        commonServices.getBaseUsersByRoles(
            isDbUser: true,
            roleNames:
            ConstantUserRoles.atomSecurityAndSeniorSecurityManagerUser,
            locationId: model.location!.id!),
        commonServices.getLocationType(locId: locationId!),
      ]);

      // Assign results to variables with explicit data types
      Locations getLocationsData = results[0];
      Organisation? defaultLocation = results[1];
      User loggedInUserDetails = results[2];
      dynamic responseLabels = results[3];
      // Analyst users = results[4];
      List<BaseUser>? emailUsers = results[4];
      List<Organisation>? entities = results[5];
      Vendors vendors = results[6];
      // List<User> entrySecurities = results[7];
      EmployeeDepartments departments = results[7];
      List<BaseUser>? epm = results[8];
      List<BaseUser>? lsm = results[9];
      GetLocationType? getLocationType = results[10];

      log('input date ---${model.inputDate}');
      // model.inputDate =
      //     DateFormat(Constants.fulldateFormat).format(DateTime.now());
      // model.inputDate = model.inputDate == null
      //     ? Utils().getCurrentDate()
      //     : Utils().formatUnixTimestamp(model.inputDate ?? '');

      model.inputDate = model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(model.inputDate ?? '0'), Constants.fulldateFormat);

      log('-loggedInUserDetails-${loggedInUserDetails.name}----');
      model.createdBy ??= loggedInUserDetails;

      if (model.location == null && defaultLocation != null) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: defaultLocation.id.toString(),
          moduleCode: Constants.eventProtectionModuleCode,
        );
        model.location = defaultLocation;
        model.slNo = slNo.serialNo;
      }

      // Update the model and emit the updated state
      emit(state.copyWith(
        model: model,
        locations: getLocationsData,
        loggedInUserDetails: loggedInUserDetails,
        status: FormStatus.initial,
        // users: users.t1Analyst,
        epm: epm,
        lsm: lsm,
        emailUsers: emailUsers,
        epOfficers: emailUsers,
        departments: departments.employeeDepartments,
        vendors: vendors.items,
        // entrySecurities: entrySecurities,
        listOfEntities: entities,
        getEntitiesResponse: entities,
        // labels: EpUiLabels.fromJson(responseLabels),
        getLocationType: getLocationType,
      ));
    } catch (e) {
      log('initialization issue', error: e, name: 'General Information Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
          // TODO: error message should be dynamic
          status: FormStatus.error,
        ),
      );
    }
  }

  Future<void> updateLocationDropdownValue({
    Organisation? location,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    List<BaseUser>? emailUsers = [];
    List<BaseUser> epm = [];
    List<BaseUser> lsm = [];
    GetLocationType? locType = state.getLocationType;

    /// Get Sl No from API
    if (location != null) {
      log('Update Location');
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.annualPowerShutDownModuleCode,
      );
      final int? locationId = location.id;

      state.model.location = location;
      state.model.slNo = slNo.serialNo ?? '';
      emailUsers = await commonServices.getBaseUsers(
          isDbUser: true,
          roleName: ConstantUserRoles.atomStaticUser, locationId: location.id!);
      epm = await commonServices.getBaseUsers(
          isDbUser: true,
          roleName: ConstantUserRoles.atomSubRegionalHeadUser,
          locationId: location.id!);
      lsm = await commonServices.getBaseUsers(
          isDbUser: true,
          roleName: ConstantUserRoles.atomSecurityAndSeniorSecurityManagerUser,
          locationId: location.id!);
      locType = await commonServices.getLocationType(locId: locationId!);

    }

    state.model.epManager1 = null;
    state.model.epManager2 = null;
    state.model.lsm1 = null;
    state.model.lsm2 = null;
    state.model.bu1 = null;
    state.model.bu2 = null;

    emit(state.copyWith(
      model: state.model,
      // users: users,
      epm: epm,
      lsm: lsm,
      emailUsers: emailUsers,
      status: FormStatus.initial,
      getLocationType: locType,
    ));
  }

  Future<void> updateDropdownValues({
    List<Organisation>? entities,
    Organisation? location,
    BaseUser? user,
    Organisation? entity,
    int? status,
    Organisation? requesterDepartment,
    BaseUser? bu1,
    BaseUser? bu2,
    Organisation? bu1Dept,
    Organisation? bu2Dept,
    BaseUser? subRegionalHead1,
    BaseUser? subRegionalHead2,
    BaseUser? epManager1,
    BaseUser? epManager2,
    BaseUser? locationSecurityManager1,
    BaseUser? locationSecurityManager2,
    BaseUser? epOfficers,
    List<Organisation>? vendors,
    Organisation? locationType,

  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    if (vendors != null) {
      state.model.proposedVendors = vendors;
    }

    /// Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.eventProtectionModule,
      );

      state.model.location = location;
      state.model.slNo = slNo.serialNo ?? '';
    }

    state.model.status = status ?? state.model.status;

    if (entities != null) {
      state.model.entities = entities;
    }

    if (locationType != null) {
      state.model.locationType = locationType;
    }
    state.model.requesterDepartment =
        requesterDepartment ?? state.model.requesterDepartment;

    if (epManager1 != null) {
      state.epm?.remove(epManager1);
      User userDetails = User(
        name: epManager1.name,
        userId: epManager1.id,
        userName: epManager1.name,
      );
      state.model.epManager1 = userDetails;
    }

    if (epManager2 != null) {
      state.epm?.remove(epManager2);
      User userDetails = User(
        name: epManager2.name,
        userId: epManager2.id,
        userName: epManager2.name,
      );
      state.model.epManager2 = userDetails;
    }
    if (bu1 != null) {
      state.emailUsers?.remove(bu1);
      User userDetails = User(
        name: bu1.name,
        userId: bu1.id,
        userName: bu1.name,
      );
      state.model.bu1 = userDetails;
    }

    if (bu2 != null) {
      state.emailUsers?.remove(bu2);
      User userDetails = User(
        name: bu2.name,
        userId: bu2.id,
        userName: bu2.name,
      );
      state.model.bu2 = userDetails;
    }

    state.model.bu1Dept = bu1Dept ?? state.model.bu1Dept;
    state.model.bu2Dept = bu2Dept ?? state.model.bu2Dept;

    if (subRegionalHead1 != null) {
      state.emailUsers?.remove(subRegionalHead1);
      User userDetails = User(
          name: subRegionalHead1.name,
          userId: subRegionalHead1.id,
          userName: subRegionalHead1.name);
      state.model.srh1 = userDetails;
    }
    if (subRegionalHead2 != null) {
      state.emailUsers?.remove(subRegionalHead2);
      User userDetails = User(
          name: subRegionalHead2.name,
          userId: subRegionalHead2.id,
          userName: subRegionalHead2.name);
      state.model.srh2 = userDetails;
    }
    if (locationSecurityManager1 != null) {
      state.lsm?.remove(locationSecurityManager1);
      User userDetails = User(
          name: locationSecurityManager1.name,
          userId: locationSecurityManager1.id,
          userName: locationSecurityManager1.name);
      state.model.lsm1 = userDetails;
    }
    if (locationSecurityManager2 != null) {
      state.lsm?.remove(locationSecurityManager2);
      User userDetails = User(
          name: locationSecurityManager2.name,
          userId: locationSecurityManager2.id,
          userName: locationSecurityManager2.name);
      state.model.lsm2 = userDetails;
    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void addAttachment({
    List<ImageContent>? data,
    List<ImageContent>? images,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    int eventIds = math.Random.secure().nextInt(5);
    if (data != null) {
      for (ImageContent image in data) {
        image.type = 6;
      }
      log('--data----${data.length}----');

      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          loadAttachments: data,
          status: FormStatus.initial,
        ),
      );
    }

    emit(
      state.copyWith(
        eventId: eventIds,
        model: state.model,
        status: FormStatus.initial,
      ),
    );

  }



  // void submitForm({bool isSaveOnly = false}) async {
  //   emit(
  //     state.copyWith(
  //       status: FormStatus.loading,
  //     ),
  //   );
  //
  //   if (state.model.status == 0 || state.model.status == null) {
  //     state.model.status = 0;
  //   }
  //   // Setting time in milliseconds
  //   // state.model.inputDate =
  //   //     (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
  //
  //   DateTime dateTime;
  //   if (!Utils().isTimestamp(state.model.inputDate!)) {
  //     dateTime =
  //         DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
  //     int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  //     state.model.inputDate = inputDate.toString();
  //   }
  //
  //   /// Create/Update API Call
  //   CSRGeneralInfoRequest request =
  //   CSRGeneralInfoRequest(csrEventGi: state.model);
  //
  //   log('--isSaveOnly----$isSaveOnly--');
  //   GenericResponse response = GenericResponse();
  //   try {
  //     if (isSaveOnly) {
  //       if (!state.isValidDraft.status) {
  //         emit(
  //           state.copyWith(
  //             status: FormStatus.formError,
  //             message: state.isValidDraft.message,
  //           ),
  //         );
  //         return;
  //       }
  //       response = (await services.createEventGeneralInfo(
  //         body: request,
  //         isSubmit: false,
  //       ));
  //     } else {
  //       if (!state.isValid.status) {
  //         log('--isSaveOnly--else--if$isSaveOnly--');
  //         emit(
  //           state.copyWith(
  //             status: FormStatus.formError,
  //             message: state.isValid.message,
  //           ),
  //         );
  //         return;
  //       }
  //       response = (await services.createEventGeneralInfo(
  //           body: request, isSubmit: true));
  //     }
  //     state.model.inputDate = state.model.inputDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(state.model.inputDate ?? '0'),
  //         Constants.fulldateFormat);
  //   } on GenericResponse catch (e) {
  //     Utils().emitErrorState(e, emit, state);
  //     state.model.inputDate = state.model.inputDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(state.model.inputDate ?? '0'),
  //         Constants.fulldateFormat);
  //     return;
  //   } on Exception catch (e) {
  //     emit(
  //       state.copyWith(
  //         message: e.toString(),
  //         status: FormStatus.error,
  //       ),
  //     );
  //   }
  //
  //   log('---response--msg--${response.message}---');
  //   state.model.inputDate = state.model.inputDate == null
  //       ? Utils().getCurrentDate()
  //       : Utils.timestampToDateConversion(
  //       int.tryParse(state.model.inputDate ?? '0'),
  //       Constants.fulldateFormat);
  //   emit(
  //     state.copyWith(
  //       message: response.message,
  //       status: FormStatus.success,
  //     ),
  //   );
  // }

  void updateStatus({required String id}) {
    commonServices.updateRecordStatus(
        id: id, module: Constants.eventProtectionModule, aps: 0);
  }
}
