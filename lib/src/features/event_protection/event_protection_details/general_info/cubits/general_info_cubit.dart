import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/models/base_user.dart';
import 'package:db_atom/src/models/entity.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/models/responseModels/generic_creat_response.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';

import '../../../../../constants/constants.dart';
import '../../../../../enums/form_status.dart';
import '../../../../../models/responseModels/error_response_validation.dart';
import '../../../../../utils/util.dart';
import '../../../../createfound/models/create_found_request.dart';
import '../../../../createfound/models/get_depositor_model.dart';
import '../models/general_info_model.dart';
import '../models/requestModel/general_info_request.dart';

part 'general_info_state.dart';

class GeneralInfoCubit extends Cubit<GeneralInfoState> {
  final EventProtectionServices services;
  final String id;
  final CommonServices commonServices;

  GeneralInfoCubit({
    required this.services,
    required this.commonServices,
    required this.id,
  }) : super(
          GeneralInfoState.initial(
            model: EventProtectionGi(),
            locations: GetLocations(),
            users: const [],
            emailUsers: const [],
            errorMessage: '',
            loadAttachments: const [],
            eventId: null,
            listOfEntities: const [],
            getEntitiesResponse: null,
            departments: const [],
            loggedInUserDetails: null,
          ),
        );

  void onModelValueChange(EventProtectionGi eventProtectionGi) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: eventProtectionGi, status: FormStatus.initial));
  }

  void onCheckBoxChange(EventProtectionGi eventProtectionGi) {
    emit(state.copyWith(model: eventProtectionGi, status: FormStatus.loading));

    emit(state.copyWith(model: eventProtectionGi, status: FormStatus.initial));
    log('--eventProtectionGi---${eventProtectionGi.epOfficers}-');
  }

  Future<void> initializeValues() async {
    log('-status-1-${state.status}--');
    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    var userId = await SharedPrefs.getUserId();
    try {
      EventProtectionGi model = EventProtectionGi();
      if (id.isNotEmpty) {
        model = await services.getGI(id);
      }
      GetLocations getLocationsData =
          await commonServices.getLocations(name: 'ATOM_LOCATIONS');

      User loggedInUserDetails =
          await commonServices.getUserDetails(userId: userId);

      Analyst users =
          await commonServices.getUsersByRole(roleName: 'T1_Analyst');

      GetDepositor emailUsers =
          await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

      // Get Date of Creation
      model.inputDate = Utils().getCurrentDate();

      AddEntities entities =
          await commonServices.getEntities(name: 'ATOM_ENTITIES');

      List<User> entrySecurities = await commonServices.getUsers();

      EmployeeDepartments departments =
          await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');

      emit(
        state.copyWith(
          model: model,
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          users: users.t1Analyst,
          emailUsers: emailUsers.atomStaticUser,
          departments: departments.employeeDepartments,
          entrySecurities: entrySecurities,
          listOfEntities: entities.atomEntities,
          getEntitiesResponse: entities,
        ),
      );
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

  Future<void> updateDropdownValues({
    List<Entity>? entities,
    Organisation? location,
    // BaseUser? user,
    Organisation? vendor,
    Entity? entity,
    int? status,
    //GetUserDetails? user,
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
    Organisation? proposedVendor,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (epManager1 != null) {
      User userDetails = User(
        name: epManager1.name,
        userId: epManager1.id,
        userName: epManager1.name,
      );
      state.model.epManager1 = userDetails;
    }

    if (epManager2 != null) {
      User userDetails = User(
        name: epManager2.name,
        userId: epManager2.id,
        userName: epManager2.name,
      );
      state.model.epManager2 = userDetails;
    }

    if(proposedVendor != null) {
      state.model.proposedVendors??=[];
      state.model.proposedVendors?.add(proposedVendor);
    }
    ////Get Sl No from API
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

    state.model.requesterDepartment =
        requesterDepartment ?? state.model.requesterDepartment;

    if (bu1 != null) {
      User userDetails = User(
        name: bu1.name,
        userId: bu1.id,
        userName: bu1.name,
      );
      state.model.bu1 = userDetails;
    }

    if (bu2 != null) {
      User userDetails = User(
        name: bu2.name,
        userId: bu2.id,
        userName: bu2.name,
      );
      state.model.bu2 = userDetails;
    }
    // state.model.bu1 = bu1 ?? state.model.bu1;
    // state.model.bu2 = bu2 ?? state.model.bu2;
    state.model.bu1Dept = bu1Dept ?? state.model.bu1Dept;

    state.model.bu2Dept = bu2Dept ?? state.model.bu2Dept;

    if (subRegionalHead1 != null) {
      User userDetails = User(
          name: subRegionalHead1.name,
          userId: subRegionalHead1.id,
          userName: subRegionalHead1.name);
      state.model.srh1 = userDetails;
    }
    if (subRegionalHead2 != null) {
      User userDetails = User(
          name: subRegionalHead2.name,
          userId: subRegionalHead2.id,
          userName: subRegionalHead2.name);
      state.model.srh2 = userDetails;
    }
    if (locationSecurityManager1 != null) {
      User userDetails = User(
          name: locationSecurityManager1.name,
          userId: locationSecurityManager1.id,
          userName: locationSecurityManager1.name);
      state.model.lsm1 = userDetails;
    }
    if (locationSecurityManager2 != null) {
      User userDetails = User(
          name: locationSecurityManager2.name,
          userId: locationSecurityManager2.id,
          userName: locationSecurityManager2.name);
      state.model.lsm2 = userDetails;
    }

    log('-state.model.epManager1.name--${state.model.epManager1?.name}-------');
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void addAttachment({
    List<CreateImage>? data,
    List<CreateImage>? guardImages,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    int eventIds = math.Random.secure().nextInt(5);

    log('--guardImages---${guardImages?.length}----');
    if (guardImages != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
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

    log('--state.status--3--${state.status}----');
  }

  void showFields({
    bool? annualPowerShutdown,
  }) {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    if (annualPowerShutdown != null) {
      state.model.annualPowerShutdown = annualPowerShutdown;
    }
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

    /// Create/Update API Call
    GeneralInfoRequest request =
        GeneralInfoRequest(eventProtectionGi: state.model);

    log('--isSaveOnly----$isSaveOnly--');
    GenericCreateResponse response = GenericCreateResponse();
    try {
      if (isSaveOnly) {
        response = (await services.createEventGeneralInfo(
          body: request,
          isSubmit: false,
        ));
      } else {
        if (!state.isValid.status) {
          log('--isSaveOnly--else--if$isSaveOnly--');
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValid.message,
            ),
          );
          return;
        }
        response = (await services.createEventGeneralInfo(
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
