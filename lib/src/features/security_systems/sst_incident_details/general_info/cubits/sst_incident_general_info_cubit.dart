import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/security_systems/models/ssla_ui_labels.dart';
import 'package:db_atom/src/features/security_systems/models/sst_incident_response.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:intl/intl.dart';

import '../../../models/requestModel/general_info_request.dart';
import '../../../services/sst_incident_services.dart';

part 'sst_incident_general_info_state.dart';

class SstIncidentGeneralInfoCubit extends Cubit<SstIncidentGeneralInfoState> {
  final SstIncidentServices services;
  final String id;
  final String occId;
  final bool isInternal;
  final CommonServices commonServices;
  final int occType;

  SstIncidentGeneralInfoCubit({
    required this.occType,
    required this.occId,
    required this.services,
    required this.commonServices,
    required this.id,
    required this.isInternal,
  }) : super(
          SstIncidentGeneralInfoState.initial(
            model: SstIncident(),
            locations: Locations(),
            users: const [],
            emailUsers: const [],
            errorMessage: '',
            loadAttachments: const [],
            eventId: null,
            listOfEntities: const [],
            getEntitiesResponse: null,
            // departments: const [],
            vendors: const [],
            loggedInUserDetails: User(),
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

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    List<Organisation>? entities =
        await commonServices.getOrganisations(name: 'ATOM_ENTITIES');
    Analyst users = await commonServices.getUsersByRole(roleName: 'T1_Analyst');
    Vendors vendors = await commonServices.getVendors(name: 'ATOM_VENDORS');
    GetDepositor emailUsers =
        await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

    List<BaseUser> locationTeamUsers =
        await commonServices.getBaseUsers(roleName: 'ATOM_Security_Team');

    List<BaseUser> securityLeads = await commonServices.getBaseUsersByRoles(
        roleNames: 'ATOM_ROLE_Security_Lead;ATOM_Assistant_Security_Lead');

    List<BaseUser> securityManagers = await commonServices.getBaseUsersByRoles(
        roleNames: 'ATOM_Security_Manager;ATOM_Senior_Security_Manager');

    emit(
      state.copyWith(
        listOfEntities: entities,
        status: FormStatus.initial,
        users: users.t1Analyst,
        uploadAttachments: state.model.attachments,
        emailUsers: emailUsers.atomStaticUser,
        vendors: vendors.items,
        securityLeads: securityLeads,
        securityManagers: securityManagers,
        locationTeamUsers: locationTeamUsers,
      ),
    );
  }

  Future<void> initializeValues() async {
    log('initializeValues--sst-incidentGeneralCubit-occId---$occId--');
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
      // model.createdDate = Utils().getCurrentDate();
      // model.createdDate = model.createdDate == null
      //     ? Utils().getCurrentDate()
      //     : Utils().formatUnixTimestamp(model.createdDate ?? '');

      model.createdDate = model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(model.createdDate ?? '0'), Constants.fulldateFormat);

      Locations getLocationsData =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      User loggedInUserDetails =
          await commonServices.getUserDetails(userId: userId);

      model.createdBy ??= loggedInUserDetails;
      List<BaseUser> users =
          await commonServices.getBaseUsers(roleName: 'T1_Analyst');

      List<Organisation> entities =
          await commonServices.getOrganisations(name: 'ATOM_ENTITIES');
      List<User> entrySecurities = await commonServices.getUsers();
      List<Organisation> vendors =
          await commonServices.getOrganisations(name: 'ATOM_VENDORS');

      if (state.model.location == null) {
        Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();
        if (defaultLocation != null) {
          SerialNumberModel slNo = await commonServices.getSlNo(
            locationId: defaultLocation.id.toString(),
            moduleCode: Constants.securitySystemModule,
          );
          model.location = defaultLocation;
          model.slNo = slNo.serialNo;
        }
      }

      List<BaseUser> securityLeads = await commonServices.getBaseUsersByRoles(
          roleNames: 'ATOM_ROLE_Security_Lead;ATOM_Assistant_Security_Lead');

      List<BaseUser> securityManagers =
          await commonServices.getBaseUsersByRoles(
              roleNames: 'ATOM_Security_Manager;ATOM_Senior_Security_Manager');

      List<BaseUser> locationTeamUsers =
          await commonServices.getBaseUsers(roleName: 'ATOM_Security_Team');

      List<BaseUser> systemManagers = await commonServices.getBaseUsers(
          roleName: 'ATOM_Security_System_Manager');

      List<BaseUser>? emailUsers =
          await commonServices.getBaseUsers(roleName: 'ATOM_STATIC_USER');

      if (isInternal == true) {
        state.model.staffType = 1;
        state.model.ticketType = 1;
      } else {
        state.model.staffType = 2;
        state.model.ticketType = 1;
      }
      state.model.status = 1;

      emit(
        state.copyWith(
          model: model,
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          users: users,
          systemManagers: systemManagers,
          securityLeads: securityLeads,
          securityManagers: securityManagers,
          locationTeamUsers: locationTeamUsers,
          emailUsers: emailUsers,
          vendors: vendors,
          entrySecurities: entrySecurities,
          listOfEntities: entities,
          getEntitiesResponse: entities,
          uploadAttachments: model.attachments,
        ),
      );
    } catch (e) {
      log('initialization issue',
          error: e, name: 'SstIncidentGeneralInfoCubit');
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
    BaseUser? lt,
    Organisation? vendor,
    Organisation? location,
    BaseUser? lsm,
    Organisation? entity,
    int? status,
    int? incidentType,
    int? systemSLA,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    // state.model.ticketType =
    //     incidentType ?? state.model.incidentType;
    log('--incidentType----$incidentType--');

    state.model.systemSLA = systemSLA ?? state.model.systemSLA;

    if (vendor != null) {
      state.model.vendor = vendor;

      List<String>? emails = vendor.keyName?.split(',');
      log('--emails.stringx-${emails.toString()}-');

      state.model.vendorPoc = '';
      state.model.escalation1Poc = '';
      if (!emails.isEmptyOrNull) {
        log('--emails?[0]-${emails?[0]}-');
        state.model.vendorPoc = emails?[0].trim();
        if (!emails.isEmptyOrNull &&
            emails!.length > 1 &&
            !emails[1].isEmptyOrNull) {
          state.model.escalation1Poc =
              !emails[1].isEmptyOrNull ? emails[1].trim() : '';
        }

        log('--emails.length-${emails?.length}-');

        if (emails!.length >= 3) {
          state.model.escalation2Poc =
              !emails[2].isEmptyOrNull ? emails[2].trim() : '';
        }
        if (emails.length >= 4) {
          state.model.escalation3Poc =
              !emails[3].isEmptyOrNull ? emails[3].trim() : '';
        }
      }

      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
        ),
      );
    }

    if (systemManager != null) {
      User userDetails = User(
        name: systemManager.name,
        userId: systemManager.id,
        email: systemManager.email,
      );
      state.model.systemManager = userDetails;

      emit(
        state.copyWith(
          systemManagers: state.emailUsers,
        ),
      );
    }
    if (lsm != null) {
      User userDetails = User(
        name: lsm.name,
        userId: lsm.id,
        email: lsm.email,
      );
      state.model.lsm = userDetails;

      emit(
        state.copyWith(
          securityManagers: state.emailUsers,
        ),
      );
    }
    if (lt != null) {
      User userDetails = User(
        name: lt.name,
        userId: lt.id,
        email: lt.email,
      );
      state.model.lt = userDetails;

      emit(
        state.copyWith(
          locationTeamUsers: state.emailUsers,
        ),
      );
    }
    if (asl != null) {
      User userDetails = User(
        name: asl.name,
        userId: asl.id,
        email: asl.email,
      );
      state.model.asl = userDetails;

      emit(
        state.copyWith(
          securityLeads: state.emailUsers,
        ),
      );
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
        image.type = 1;
      }
      log('--data----${data.length}----');

      state.model.attachments = data;
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          uploadAttachments: data,
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
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    state.model.status ??= 1;

    if (isInternal == true) {
      state.model.staffType = 1;
      state.model.ticketType = 1;
    } else {
      state.model.staffType = 2;
      state.model.ticketType = 1;
    }
    // Setting time in milliseconds
    // state.model.createdDate =
    //     (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.createdDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.createdDate!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.createdDate = inputDate.toString();
    }

    state.model.occurrence ??= OccurrenceModel();
    state.model.occurrence?.id = occId.toIntOrNull();
    state.model.occType = occType;

    /// Create/Update API Call
    SecuritySystemTicketIncidentRequest request =
        SecuritySystemTicketIncidentRequest(sstIncident: state.model);
    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        response = await services.create(
          body: request,
          isSubmit: false,
        );
      } else {
        if (!state.isValid.status) {
          log('--isSaveOnly--else--if$isSaveOnly--');
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return;
        }
        response = await services.create(
          body: request,
          isSubmit: true,
        );
      }
      state.model.createdDate = state.model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.createdDate ?? '0'),
              Constants.fulldateFormat);
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      state.model.createdDate = state.model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.createdDate ?? '0'),
              Constants.fulldateFormat);
      return;
    } on Exception catch (e) {
      log('--e.message-Exception-${e.toString()}---');
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
      state.model.createdDate = state.model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.createdDate ?? '0'),
              Constants.fulldateFormat);
      return;
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
    commonServices.updateRecordStatus(
        id: id, module: Constants.securitySystemModule);
  }
}
