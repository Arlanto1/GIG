import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/src/features/annual_power_shutdown_list/models/annual_power_shutdown_list_model.dart';
import 'package:db_atom/src/features/annual_power_shutdown_list/models/requestModel/annual_power_shutdown_list_request.dart';
import 'package:db_atom/src/features/annual_power_shutdown_list/services/annual_power_shutdown_services.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/vendors_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:intl/intl.dart';

import '../../../../../../index.dart';

part 'annual_power_shutsown_list_details_state.dart';

class AnnualPowerShutdownListDetailsCubit
    extends Cubit<AnnualPowerShutdownListDetailsState> {
  final AnnualPowerShutdownListServices services;
  final String id;
  final CommonServices commonServices;

  AnnualPowerShutdownListDetailsCubit({
    required this.services,
    required this.commonServices,
    required this.id,
  }) : super(
          AnnualPowerShutdownListDetailsState.initial(
            model: AnnualPowerShutdownListModel(),
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
          ),
        );

  void onModelValueChange(AnnualPowerShutdownListModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(AnnualPowerShutdownListModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
    log('--eventProtectionGi---${model.epOfficers}-');
  }

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    List<Organisation>? entities =
    await commonServices.getOrganisations(name: 'ATOM_ENTITIES');

    Analyst users = await commonServices.getUsersByRole(roleName: 'T1_Analyst');
    EmployeeDepartments departments =
    await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');
    GetDepositor emailUsers =
    await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

    emit(
      state.copyWith(
        getEntitiesResponse: entities,
        listOfEntities: entities,
        status: FormStatus.initial,
        users: users.t1Analyst,
        emailUsers: emailUsers.atomStaticUser,
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
    AnnualPowerShutdownListModel model = id.isNotEmpty
        ? await services.getById(id)
        : AnnualPowerShutdownListModel();

    try {
      // Perform multiple asynchronous operations concurrently
      final List<dynamic> results = await Future.wait([
        commonServices.getLocations(name: 'ATOM_LOCATIONS'),
        SharedPrefs.getDefaultLocation(),
        commonServices.getUserDetails(userId: userId),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.eventProtectionModuleCode),
        commonServices.getUsersByRole(roleName: 'T1_Analyst'),
        commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER'),
        commonServices.getOrganisations(name: 'ATOM_ENTITIES'),
        commonServices.getVendors(name: 'ATOM_VENDORS'),
        commonServices.getUsers(),
        commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS'),
      ]);

      // Assign results to variables with explicit data types
      Locations getLocationsData = results[0];
      Organisation? defaultLocation = results[1];
      User loggedInUserDetails = results[2];
      dynamic responseLabels = results[3];
      Analyst users = results[4];
      GetDepositor emailUsers = results[5];
      List<Organisation>? entities = results[6];
      Vendors vendors = results[7];
      List<User> entrySecurities = results[8];
      EmployeeDepartments departments = results[9];

      model.inputDate =
          DateFormat(Constants.fulldateFormat).format(DateTime.now());

      if (model.location == null && defaultLocation != null) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: defaultLocation.id.toString(),
          moduleCode: Constants.eventProtectionModuleCode,
        );
        model.location = defaultLocation;
        model.slNo = slNo.serialNo;
      }
      model.createdBy ??= loggedInUserDetails;

      // Update the model and emit the updated state
      emit(state.copyWith(
        model: model,
        locations: getLocationsData,
        loggedInUserDetails: loggedInUserDetails,
        status: FormStatus.initial,
        users: users.t1Analyst,
        emailUsers: emailUsers.atomStaticUser,
        epOfficers: emailUsers.atomStaticUser,
        departments: departments.employeeDepartments,
        vendors: vendors.items,
        entrySecurities: entrySecurities,
        listOfEntities: entities,
        getEntitiesResponse: entities,
        // labels: EpUiLabels.fromJson(responseLabels),
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

  Future<void> updateDropdownValues({
    List<Organisation>? entities,
    Organisation? location,
    // BaseUser? user,
    Organisation? entity,
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
    List<Organisation>? vendors,
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
    // if (epOfficers != null) {
    //   User userDetails = User(
    //     name: epOfficers.name,
    //     userId: epOfficers.id,
    //     userName: epOfficers.name,
    //   );
    //   state.epOfficers.add(userDetails.email??'');
    // }

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
      state.emailUsers?.remove(locationSecurityManager1);
      User userDetails = User(
          name: locationSecurityManager1.name,
          userId: locationSecurityManager1.id,
          userName: locationSecurityManager1.name);
      state.model.lsm1 = userDetails;
    }
    if (locationSecurityManager2 != null) {
      state.emailUsers?.remove(locationSecurityManager2);
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
    List<ImageContent>? data,
    List<ImageContent>? guardImages,
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
    AnnualPowerShutdownListRequest request =
        AnnualPowerShutdownListRequest(annualPowerShutdown: state.model);

    log('--isSaveOnly----$isSaveOnly--');
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
        response = (await services.createAnnualPowerShutdownList(
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
        response = (await services.createAnnualPowerShutdownList(
            body: request, isSubmit: true));
      }
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
  void updateStatus({required String id}) {
    commonServices.updateRecordStatus(
        id: id, module: Constants.eventProtectionModule);
  }
}
