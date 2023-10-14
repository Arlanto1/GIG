import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/features/security_systems/models/sst_incident_response.dart';
import 'package:db_atom/src/models/base_user.dart';
import 'package:db_atom/src/models/entity.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';

import '../../../../../constants/constants.dart';
import '../../../../../enums/form_status.dart';
import '../../../../../models/responseModels/error_response_validation.dart';
import '../../../../../models/responseModels/generic_creat_response.dart';
import '../../../../../utils/util.dart';
import '../../../../createfound/models/create_found_request.dart';
import '../../../../createfound/models/get_depositor_model.dart';
import '../../../models/requestModel/general_info_request.dart';
import '../../../services/sst_incident_services.dart';

part 'sst_incident_general_info_state.dart';

class SstIncidentGeneralInfoCubit extends Cubit<SstIncidentGeneralInfoState> {
  final SstIncidentServices services;
  final String id;
  final bool isInternal;
  final CommonServices commonServices;

  SstIncidentGeneralInfoCubit({
    required this.services,
    required this.commonServices,
    required this.id, required this. isInternal,
  }) : super(
          SstIncidentGeneralInfoState.initial(
            model: SstIncident(),
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

  void onModelValueChange(SstIncident model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(SstIncident model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
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
      SstIncident model = SstIncident();
      if (id.isNotEmpty) {
        model = await services.getDetails(id);
      }

      // Get Date of Creation
      model.createdDate = Utils().getCurrentDate();

      GetLocations getLocationsData =
          await commonServices.getLocations(name: 'ATOM_LOCATIONS');

      User loggedInUserDetails =
          await commonServices.getUserDetails(userId: userId);

      model.createdBy = loggedInUserDetails;
      Analyst users =
          await commonServices.getUsersByRole(roleName: 'T1_Analyst');

      GetDepositor emailUsers =
          await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

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
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }
  }

  Future<void> updateDropdownValues({
    BaseUser? asl,
    BaseUser? systemManager,
    BaseUser? lsm,
    List<Entity>? entities,
    BaseUser? locationTeam,
    Organisation? location,
    // BaseUser? user,
    Organisation? vendor,
    Entity? entity,
    int? status,
    int? incidentType,
    int? assetType,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    // state.model.ticketType =
    //     incidentType ?? state.model.incidentType;
    log('--incidentType----$incidentType--');



    if (asl != null) {
      User userDetails = User(
        name: asl.name,
        userId: asl.id,
        userName: asl.name,
      );
      state.model.asl = userDetails;
    }

    if (systemManager != null) {
      User userDetails = User(
        name: systemManager.name,
        userId: systemManager.id,
        userName: systemManager.name,
      );
      state.model.systemManager = userDetails;
    }


    if (lsm != null) {
      User userDetails = User(
        name: lsm.name,
        userId: lsm.id,
        userName: lsm.name,
      );
      state.model.lsm = userDetails;
    }


    if (locationTeam != null) {
      User userDetails = User(
        name: locationTeam.name,
        userId: locationTeam.id,
        userName: locationTeam.name,
      );
      // state.model.location = userDetails; // TODO: need json property
    }

    ////Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.incidentManagementModule,
      );

      state.model.location = location;
      state.model.slNo = slNo.serialNo ?? '';
    }

    state.model.status = status ?? state.model.status;


    // if (entities != null) {
    //   state.model.entities = entities;
    // }

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
      // state.model.annualPowerShutdown = annualPowerShutdown;
    }
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void submitForm({bool isSaveOnly = false}) async {
    log('-------');
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (state.model.status == 0 || state.model.status == null) {
      state.model.status = 1;
    }
    // Setting time in milliseconds
    state.model.createdDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    /// Create/Update API Call
    SecuritySystemTicketIncidentRequest request =
    SecuritySystemTicketIncidentRequest(sstIncident: state.model);

    log('--isSaveOnly----$isSaveOnly--');
    GenericCreateResponse response = GenericCreateResponse();
    try {
      if (isSaveOnly) {
        response = (await services.create(
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
        response = (await services.create(
          body: request,
          isSubmit: true,
        ));
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
        // message: response.message,
        status: FormStatus.success,
      ),
    );
  }
}
