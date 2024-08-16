import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/annual_power_shutdown_list/models/aps_ui_labels.dart';
import 'package:db_atom/src/features/annual_power_shutdown_list/services/annual_power_shutdown_services.dart';
import 'package:intl/intl.dart';

part 'annual_power_shutdown_list_details_state.dart';

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

    EmployeeDepartments departments =
        await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');
    List<BaseUser>? emailUsers = await commonServices.getBaseUsers(
        roleName: ConstantUserRoles.atomStaticUser,
        locationId: state.model.location!.id!);
    List<BaseUser> srh = await commonServices.getBaseUsers(
        roleName: ConstantUserRoles.atomSubRegionalHeadUser,
        locationId: state.model.location!.id!);
    List<BaseUser> lsm = await commonServices.getBaseUsers(
        roleName: ConstantUserRoles.atomSecurityAndSeniorSecurityManagerUser,
        locationId: state.model.location!.id!);
    emit(
      state.copyWith(
        getEntitiesResponse: entities,
        listOfEntities: entities,
        status: FormStatus.initial,
        srh: srh,
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
    AnnualPowerShutdownListModel model = id.isNotEmpty
        ? await services.getById(id)
        : AnnualPowerShutdownListModel();

    try {
      Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();

      if (model.location == null && defaultLocation != null) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: defaultLocation.id.toString(),
          moduleCode: Constants.annualPowerShutDownModuleCode,
        );
        model.location = defaultLocation;
        model.slNo = slNo.serialNo;
      }

      // Perform multiple asynchronous operations concurrently
      final List<dynamic> results = await Future.wait([
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),
        // TODO: remove the and change the number
        SharedPrefs.getDefaultLocation(),
        commonServices.getUserDetails(userId: userId),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.eventProtectionModuleCode),
        // commonServices.getUsersByRole(roleName: 'T1_Analyst'),
        commonServices.getBaseUsers(
            roleName: ConstantUserRoles.atomStaticUser,
            locationId: model.location!.id!),
        commonServices.getOrganisations(name: 'ATOM_ENTITIES'),
        commonServices.getVendors(name: 'ATOM_VENDORS'),
        commonServices.getUsers(),
        commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS'),
        commonServices.getBaseUsers(
            roleName: ConstantUserRoles.atomSubRegionalHeadUser,
            locationId: model.location!.id!),
        commonServices.getBaseUsers(
            roleName: ConstantUserRoles.atomSecurityAndSeniorSecurityManagerUser,
            locationId: model.location!.id!),
      ]);

      // Assign results to variables with explicit data types
      Locations getLocationsData = results[0];
      Organisation? defaultLocationRemove =
          results[1]; // TODO: remove the and change the number
      User loggedInUserDetails = results[2];
      // Analyst users = results[4];
      List<BaseUser>? emailUsers = results[4];
      List<Organisation>? entities = results[5];
      Vendors vendors = results[6];
      List<User> entrySecurities = results[7];
      EmployeeDepartments departments = results[8];
      List<BaseUser>? srh = results[9];
      List<BaseUser>? lsm = results[10];

      // model.inputDate = model.inputDate == null
      //     ? Utils().getCurrentDate()
      //     : Utils().formatUnixTimestamp(model.inputDate ?? '');

      model.inputDate = model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(model.inputDate ?? '0'), Constants.fulldateFormat);

      model.createdBy ??= loggedInUserDetails;
      state.model.proposedVendors ??= [];
      // Update the model and emit the updated state
      emit(state.copyWith(
        model: model,
        locations: getLocationsData,
        loggedInUserDetails: loggedInUserDetails,
        status: FormStatus.initial,
        srh: srh,
        lsm: lsm,
        emailUsers: emailUsers,
        epOfficers: emailUsers,
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

  Future<void> updateLocationDropdownValue({
    Organisation? location,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    List<BaseUser>? emailUsers = [];
    List<BaseUser> srh = [];
    List<BaseUser> lsm = [];

    /// Get Sl No from API
    if (location != null) {
      log('Update Location');
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.annualPowerShutDownModuleCode,
      );

      state.model.location = location;
      state.model.slNo = slNo.serialNo ?? '';
      emailUsers = await commonServices.getBaseUsers(
          roleName: ConstantUserRoles.atomStaticUser, locationId: location.id!);
      srh = await commonServices.getBaseUsers(
          roleName: ConstantUserRoles.atomSubRegionalHeadUser,
          locationId: location.id!);
      lsm = await commonServices.getBaseUsers(
          roleName: ConstantUserRoles.atomSecurityAndSeniorSecurityManagerUser,
          locationId: location.id!);
    }

    state.model.srh1 = null;
    state.model.srh2 = null;
    state.model.lsm1 = null;
    state.model.lsm2 = null;
    state.model.bu1 = null;
    state.model.bu2 = null;

    emit(state.copyWith(
      model: state.model,
      // users: users,
      srh: srh,
      lsm: lsm,
      emailUsers: emailUsers,
      status: FormStatus.initial,
    ));
  }

  Future<void> updateDropdownValues({
    List<Organisation>? entities,
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
    Organisation? vendor,
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

    if (vendor != null) {
      if (state.model.proposedVendors.isEmptyOrNull) {
        state.model.proposedVendors = [];
      }
      state.model.proposedVendors?.clear();
      state.model.proposedVendors?.add(vendor);
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
      state.srh?.remove(subRegionalHead1);
      User userDetails = User(
        name: subRegionalHead1.name,
        userId: subRegionalHead1.id,
      );
      state.model.srh1 = userDetails;
    }
    if (subRegionalHead2 != null) {
      state.srh?.remove(subRegionalHead2);
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
    state.model.status ??= 0;

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
              status: FormStatus.formError,
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
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return;
        }
        response = (await services.createAnnualPowerShutdownList(
            body: request, isSubmit: true));
      }
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
      return;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
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
        id: id, module: Constants.eventProtectionModule, aps: 1);
  }

  Future<void> getEpGuardBudgetCost(BudgetCostModel budgetCost) async {
    emit(state.copyWith(status: FormStatus.loading));

    BudgetCostRequest request = BudgetCostRequest();
    request.apsBudget = budgetCost;
    BudgetCostModel budgetCostResponse = BudgetCostModel();
    try {
      budgetCostResponse = await services.getEpGuardBudgetCost(body: request);

      log('--budgetCostResponse--${budgetCostResponse.budgetCost}--');
      state.model.budget = budgetCostResponse.budgetCost;
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      // emit(
      //   state.copyWith(
      //     message: e.message,
      //     status: FormStatus.error,
      //   ),
      // );
      return;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }

    emit(state.copyWith(
      model: state.model,
      budgetCost: budgetCostResponse,
      status: FormStatus.initial,
    ));
  }
}
