import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/security_systems/services/sst_incident_services.dart';
import 'package:intl/intl.dart';

part 'sst_incident_general_info_state.dart';

class SstIncidentGeneralInfoCubit extends Cubit<SstIncidentGeneralInfoState> {
  final SstIncidentServices services;
  final String id;
  final String occId;
  final bool isInternal;
  final CommonServices commonServices;
  final int occType;
  final Organisation? location;

  SstIncidentGeneralInfoCubit({
    required this.occType,
    required this.occId,
    required this.services,
    required this.commonServices,
    required this.id,
    required this.isInternal,
    this.location,
  }) : super(
          SstIncidentGeneralInfoState.initial(
            model: SstIncident(),
            locations: Locations(),
            users: const [],
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
    Vendors vendors = await commonServices.getVendors(name: 'ATOM_VENDORS');

    List<BaseUser> systemManagerUsers = await commonServices.getBaseUsers(
        isDbUser: true,
        roleName: ConstantUserRoles.atomSecuritySystemManagerUser,
        locationId: state.model.location!.id!);

    List<BaseUser> locationTeamUsers = await commonServices.getBaseUsers(
        roleName: ConstantUserRoles.atomSecurityTeamUser,
        locationId: state.model.location!.id!);

    List<BaseUser> securityLeads = await commonServices.getBaseUsersByRoles(
        isDbUser: true,
        roleNames:
            ConstantUserRoles.atomSecurityLeadAndAssistantSecurityLeadUser,
        locationId: state.model.location!.id!);

    List<BaseUser> securityManagers = await commonServices.getBaseUsersByRoles(
      isDbUser: true,
        roleNames: ConstantUserRoles.atomSecurityAndSeniorSecurityManagerUser,
        locationId: state.model.location!.id!);

    emit(
      state.copyWith(
        listOfEntities: entities,
        status: FormStatus.initial,
        uploadAttachments: state.model.attachments,
        additionalAttachments: state.model.additionalDocs,
        dataLossAttachments: state.model.dataLossDocs,
        vendors: vendors.items,
        systemManagers: systemManagerUsers,
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

      if (location == null && model.location == null) {
        Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();
        if (defaultLocation != null) {
          SerialNumberModel slNo = await commonServices.getSlNo(
            locationId: defaultLocation.id.toString(),
            moduleCode: Constants.securitySystemModule,
          );
          model.location = defaultLocation;
          model.slNo = slNo.serialNo;
        }
      } else if (location != null) {
        /// it is getting redirected from Shift Occurrence
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: location!.id.toString(),
          moduleCode: Constants.securitySystemModule,
        );
        model.location = location;
        model.slNo = slNo.serialNo;
      }

      final futures = await Future.wait([
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),
        commonServices.getUserDetails(userId: userId),
        commonServices.getOrganisations(name: 'ATOM_ENTITIES'),
        // commonServices.getUsers(),
        commonServices.getOrganisations(name: 'ATOM_VENDORS'),
        commonServices.getBaseUsersByRoles(
          isDbUser: true,
          roleNames:
              ConstantUserRoles.atomSecurityLeadAndAssistantSecurityLeadUser,
          locationId: model.location!.id!,
        ),
        commonServices.getBaseUsersByRoles(
          roleNames: ConstantUserRoles.atomSecurityAndSeniorSecurityManagerUser,
          isDbUser: true,
          locationId: model.location!.id!,
        ),
        commonServices.getBaseUsers(
          roleName: ConstantUserRoles.atomSecurityTeamUser,
          locationId: model.location!.id!,
          isDbUser: true,
        ),
        commonServices.getBaseUsers(
          roleName: ConstantUserRoles.atomSecuritySystemManagerUser,
          isDbUser: true,
          locationId: model.location!.id!,
        ),
      ]);

      // Assign futures to respective variables
      final Locations getLocationsData = futures[0] as Locations;
      final User loggedInUserDetails = futures[1] as User;
      final List<Organisation> entities = futures[2] as List<Organisation>;
      // final List<User> entrySecurities = futures[3] as List<User>;
      final List<Organisation> vendors = futures[3] as List<Organisation>;
      final List<BaseUser> securityLeads = futures[4] as List<BaseUser>;
      final List<BaseUser> securityManagers = futures[5] as List<BaseUser>;
      final List<BaseUser> locationTeamUsers = futures[6] as List<BaseUser>;
      final List<BaseUser> systemManagers = futures[7] as List<BaseUser>;

      model.createdDate = model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(model.createdDate ?? '0'), Constants.fulldateFormat);
model.modifiedDate = model.modifiedDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(model.modifiedDate ?? '0'), Constants.fulldateFormat);

      model.createdBy ??= loggedInUserDetails;

      // if (isInternal == true) {
      state.model.staffType = 1;
      state.model.ticketType = 1;
      // }
      // else {
      //   state.model.staffType = 2;
      //   state.model.ticketType = 1;
      // }
      state.model.status = 1;

      emit(
        state.copyWith(
          model: model,
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          systemManagers: systemManagers,
          securityLeads: securityLeads,
          securityManagers: securityManagers,
          locationTeamUsers: locationTeamUsers,
          vendors: vendors,
          // entrySecurities: entrySecurities,
          listOfEntities: entities,
          getEntitiesResponse: entities,
          uploadAttachments: model.attachments,
          additionalAttachments: model.additionalDocs,
          dataLossAttachments: model.dataLossDocs,
        ),
      );
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
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

    List<BaseUser> locationTeamUsers = [];
    List<BaseUser> securityLeads = [];
    List<BaseUser> securityManagers = [];
    ////Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.securitySystemModule,
      );

      state.model.location = location;
      state.model.slNo = slNo.serialNo ?? '';

      locationTeamUsers = await commonServices.getBaseUsers(
          isDbUser: true,
          roleName: ConstantUserRoles.atomSecurityTeamUser,
          locationId: location.id!);

      securityLeads = await commonServices.getBaseUsersByRoles(
          isDbUser: true,
          roleNames:
              ConstantUserRoles.atomSecurityLeadAndAssistantSecurityLeadUser,
          locationId: location.id!);

      securityManagers = await commonServices.getBaseUsersByRoles(
          isDbUser: true,
          roleNames: ConstantUserRoles.atomSecurityAndSeniorSecurityManagerUser,
          locationId: location.id!);
    }

    state.model.asl = null;
    state.model.lsm = null;
    state.model.lt = null;
    state.model.systemManager = null;

    emit(state.copyWith(
      model: state.model,
      securityLeads: securityLeads,
      securityManagers: securityManagers,
      locationTeamUsers: locationTeamUsers,
      status: FormStatus.initial,
    ));
  }

  Future<void> updateDropdownValues({
    BaseUser? asl,
    BaseUser? systemManager,
    BaseUser? lt,
    Organisation? vendor,
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

    state.model.status = status ?? state.model.status;

    // if (entities != null) {
    //   state.model.entities = entities;
    // }

    emit(state.copyWith(
      model: state.model,
      uploadAttachments: state.model.attachments,
      additionalAttachments: state.model.additionalDocs,
      status: FormStatus.initial,
    ));
  }

  Future<void> updateEmailsValue({
    BaseUser? systemManager,
    BaseUser? securityManager,
    BaseUser? securityLead,
    BaseUser? locationTeam,
    BaseUser? emailUser,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (systemManager != null) {
      User userDetails = User(
        name: systemManager.name,
        userId: systemManager.id,
        userName: systemManager.name,
      );
      state.model.systemManager = userDetails;
      state.securityManagers?.remove(systemManager);
      state.securityLeads?.remove(systemManager);
      state.locationTeamUsers?.remove(systemManager);
      emit(state.copyWith(
        model: state.model,
        securityManagers: state.securityManagers,
        securityLeads: state.securityLeads,
        locationTeamUsers: state.locationTeamUsers,
        status: FormStatus.initial,
      ));
    }

    if (securityManager != null) {
      User userDetails = User(
        name: securityManager.name,
        userId: securityManager.id,
        userName: securityManager.name,
      );
      state.model.lsm = userDetails;
      state.systemManagers?.remove(securityManager);
      state.securityLeads?.remove(securityManager);
      state.locationTeamUsers?.remove(securityManager);

      emit(state.copyWith(
        model: state.model,
        systemManagers: state.systemManagers,
        securityLeads: state.securityLeads,
        locationTeamUsers: state.locationTeamUsers,
        status: FormStatus.initial,
      ));
    }

    if (securityLead != null) {
      User userDetails = User(
        name: securityLead.name,
        userId: securityLead.id,
        userName: securityLead.name,
      );
      state.model.asl = userDetails;
      state.systemManagers?.remove(securityLead);
      state.securityManagers?.remove(securityLead);
      state.locationTeamUsers?.remove(securityLead);
      emit(state.copyWith(
        model: state.model,
        systemManagers: state.systemManagers,
        securityManagers: state.securityManagers,
        locationTeamUsers: state.locationTeamUsers,
        status: FormStatus.initial,
      ));
    }

    if (locationTeam != null) {
      User userDetails = User(
        name: locationTeam.name,
        userId: locationTeam.id,
        userName: locationTeam.name,
      );
      state.model.lt = userDetails;
      state.systemManagers?.remove(locationTeam);
      state.securityManagers?.remove(locationTeam);
      state.securityLeads?.remove(locationTeam);
    }
    emit(state.copyWith(
      model: state.model,
      systemManagers: state.systemManagers,
      securityManagers: state.securityManagers,
      securityLeads: state.securityLeads,
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

  void submitForm({
    required bool isSaveOnly,
    required bool isReworkOnly,
    required bool isSubmitOnly,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    state.model.status ??= 1;

    // if (isInternal == true) {
    state.model.staffType = 1;
    state.model.ticketType = 1;
    // }

    if (state.model.workFlowId != null) {
      state.model.workFlowId = state.model.workFlowId;
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
        response = await services.createTicketLifeCycle(
          body: request,
          isSubmit: false,
          isRework: 0,
        );
      }
      if (isSubmitOnly) {
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
        response = await services.createTicketLifeCycle(
          body: request,
          isSubmit: true,
          isRework: 0,
        );
      }
      if (isReworkOnly) {
        // if (!state.isValid.status) {
        //   log('--isSaveOnly--else--if$isSaveOnly--');
        //   emit(
        //     state.copyWith(
        //       status: FormStatus.formError,
        //       message: state.isValid.message,
        //     ),
        //   );
        //   return;
        // }
        response = await services.createTicketLifeCycle(
          body: request,
          isSubmit: true,
          isRework: 1,
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
      state.model.createdDate = state.model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.createdDate ?? '0'),
              Constants.fulldateFormat);
      return UtilsCommon().exceptionHandling(e, emit, state);
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

  void onAddComment(String comment) {
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.loading,
    ));

    state.model.rejectionComment = comment;
    emit(state.copyWith(
      model: state.model,
      rejectionComment: comment,
      status: FormStatus.initial,
    ));
  }

  void onAddActivityNotes(String activityNotes) {
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.loading,
    ));

    state.model.closedActivityNotes = activityNotes;
    emit(state.copyWith(
      model: state.model,
      activityNotes: activityNotes,
      status: FormStatus.initial,
    ));
  }
}
