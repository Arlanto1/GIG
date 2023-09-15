import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/models/base_user.dart';
import 'package:db_atom/src/models/department.dart';
import 'package:db_atom/src/models/entity.dart';
import 'package:db_atom/src/models/location.dart';
import 'package:db_atom/src/models/responseModels/generic_creat_response.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';

import '../../../../../constants/constants.dart';
import '../../../../../enums/form_status.dart';
import '../../../../../models/entry_security.dart';
import '../../../../../models/responseModels/error_response_validation.dart';
import '../../../../../utils/util.dart';
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
              departments: const [], loggedInUserDetails: null,
              ),
        );

  void onModelValueChange(EventProtectionGi eventProtectionGi) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: eventProtectionGi, status: FormStatus.initial));
  }

  void onCheckBoxChange(EventProtectionGi eventProtectionGi) {
    emit(state.copyWith(model: eventProtectionGi, status: FormStatus.loading));

    emit(state.copyWith(model: eventProtectionGi, status: FormStatus.initial));
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
      EventProtectionGi eventProtectionGi = EventProtectionGi();
      if(id.isNotEmpty) {
        eventProtectionGi = await services.getGI(id);
      }
      GetLocations getLocationsData =
          await commonServices.getLocations(name: 'ATOM_LOCATIONS');

      EntrySecurity loggedInUserDetails =
          await commonServices.getUserDetails(userId: userId);

      Analyst users =
          await commonServices.getUsersByRole(roleName: 'T1_Analyst');

      // Get Date of Creation
      state.model.inputDate = Utils().getCurrentDate() ;

      AddEntities entities =
          await commonServices.getEntities(name: 'ATOM_ENTITIES');

      List<GetUserDetails> entrySecurities = await commonServices.getUsers();

      EmployeeDepartments departments =
          await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');

      emit(
        state.copyWith(
          model: eventProtectionGi,
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          users: users.t1Analyst,
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
    Location? location,
    BaseUser? user,
    Department? vendor,
    Entity? entity,
    int? status,
    // GetUserDetails? user,
    Department? requesterDepartment,
    GetUserDetails? bu1,
    GetUserDetails? bu2,
    Department? bu1Dept,
    Department? bu2Dept,
    GetUserDetails? subRegionalHead1,
    GetUserDetails? subRegionalHead2,
    GetUserDetails? epManager1,
    GetUserDetails? epManager2,
    GetUserDetails? locationSecurityManager1,
    GetUserDetails? locationSecurityManager2,
    BaseUser? epOfficers,
    List<Department>? proposedVendors,

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

      state.model.location = location;
      state.model.slNo = slNo.serialNo ?? '';
    }

    state.model.status = status ?? state.model.status;

    if (entities != null) {
      state.model.entities = entities;
    }

    state.model.bu1 = bu1 ?? state.model.bu1;
    state.model.bu2 = bu2 ?? state.model.bu2;
    //   state.model.requesterDepartment =
    //     requesterDepartment ?? state.model.requesterDepartment;

    // if (entities != null) {
    //   state.model.entities = entities;
    // }

    if (subRegionalHead1 != null) {
      state.model.srh1?.email = subRegionalHead1.email;
    }
    if (subRegionalHead2 != null) {
      state.model.srh2?.name = subRegionalHead2.name;
    }
    if (locationSecurityManager1 != null) {
      state.model.lsm1?.email= locationSecurityManager1.email ;
    }
    if (locationSecurityManager2 != null) {
      state.model.lsm2?.email = locationSecurityManager2.email ;
    }

    if (bu1 != null) {
      state.model.bu1?.email = bu1.email ;
    }
    if (bu2 != null) {
      state.model.bu2?.email = bu2.email;
    }

    if (epManager1 != null) {
      state.model.epManager1?.email = epManager1.email;
    }

    if (epManager2 != null) {
      state.model.epManager2?.email = epManager2.email;
    }

    if (epOfficers != null) {
      state.model.epOfficers = epOfficers.email;
    }

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
    GeneralInfoRequest(eventProtectionGi:state.model);

    GenericCreateResponse response = GenericCreateResponse();
    try {
      if (isSaveOnly) {
        response = (await services.createEventGeneralInfo(
           body: request, isSubmit: false, ));
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
