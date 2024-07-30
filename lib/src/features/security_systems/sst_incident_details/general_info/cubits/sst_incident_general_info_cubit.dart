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

    List<BaseUser> locationTeamUsers = await commonServices.getBaseUsers(
        roleName: 'ATOM_Security_Team', locationId: state.model.location?.id);

    List<BaseUser> securityLeads = await commonServices.getBaseUsersByRoles(
        roleNames: 'ATOM_ROLE_Security_Lead;ATOM_Assistant_Security_Lead',
        locationId: state.model.location?.id);

    List<BaseUser> securityManagers = await commonServices.getBaseUsersByRoles(
        roleNames: 'ATOM_Security_Manager;ATOM_Senior_Security_Manager',
        locationId: state.model.location?.id);

    emit(
      state.copyWith(
        listOfEntities: entities,
        status: FormStatus.initial,
        uploadAttachments: state.model.attachments,
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
        commonServices.getUsers(),
        commonServices.getOrganisations(name: 'ATOM_VENDORS'),
        commonServices.getBaseUsersByRoles(
          roleNames: 'ATOM_ROLE_Security_Lead;ATOM_Assistant_Security_Lead',
          locationId: model.location?.id,
        ),
        commonServices.getBaseUsersByRoles(
          roleNames: 'ATOM_Security_Manager;ATOM_Senior_Security_Manager',
          locationId: model.location?.id,
        ),
        commonServices.getBaseUsers(
          roleName: 'ATOM_Security_Team',
          locationId: model.location?.id,
        ),
        commonServices.getBaseUsers(
          roleName: 'ATOM_Security_System_Manager',
          locationId: model.location?.id,
        ),
      ]);

      // Assign futures to respective variables
      final Locations getLocationsData = futures[0] as Locations;
      final User loggedInUserDetails = futures[1] as User;
      final List<Organisation> entities = futures[2] as List<Organisation>;
      final List<User> entrySecurities = futures[3] as List<User>;
      final List<Organisation> vendors = futures[4] as List<Organisation>;
      final List<BaseUser> securityLeads = futures[5] as List<BaseUser>;
      final List<BaseUser> securityManagers = futures[6] as List<BaseUser>;
      final List<BaseUser> locationTeamUsers = futures[7] as List<BaseUser>;
      final List<BaseUser> systemManagers = futures[8] as List<BaseUser>;

      model.createdDate = model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(model.createdDate ?? '0'), Constants.fulldateFormat);

      model.createdBy ??= loggedInUserDetails;

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
          systemManagers: systemManagers,
          securityLeads: securityLeads,
          securityManagers: securityManagers,
          locationTeamUsers: locationTeamUsers,
          vendors: vendors,
          entrySecurities: entrySecurities,
          listOfEntities: entities,
          getEntitiesResponse: entities,
          uploadAttachments: model.attachments,
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
          roleName: 'ATOM_Security_Team', locationId: location.id);

      securityLeads = await commonServices.getBaseUsersByRoles(
          roleNames: 'ATOM_ROLE_Security_Lead;ATOM_Assistant_Security_Lead',
          locationId: location.id);

      securityManagers = await commonServices.getBaseUsersByRoles(
          roleNames: 'ATOM_Security_Manager;ATOM_Senior_Security_Manager',
          locationId: location.id);
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

    if (systemManager != null) {
      User userDetails = User(
        name: systemManager.name,
        userId: systemManager.id,
        email: systemManager.email,
      );
      state.model.systemManager = userDetails;

      emit(
        state.copyWith(
          systemManagers: state.systemManagers,
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
          securityManagers: state.securityManagers,
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
          locationTeamUsers: state.locationTeamUsers,
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
          securityLeads: state.securityLeads,
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
}
