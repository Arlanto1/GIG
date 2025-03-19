import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/law_enforcement_new/models/law_enforcement_model_new.dart';
import 'package:db_atom/src/features/law_enforcement_new/models/requestModels/law_enforcement_request_new.dart';
import 'package:db_atom/src/features/law_enforcement_new/services/law_enforcement_services_new.dart';
import 'package:intl/intl.dart';

part 'law_enforcement_details_state_new.dart';

class LawEnforcementDetailsCubit
    extends Cubit<LawEnforcementDetailsState> {
  final LawEnforcementServicesNew services;
  final LawEnforcementModelNew? model;
  final CommonServices commonServices;
  final Organisation? location;
  final Organisation? locationRegion;
  final Organisation? vendor;

  LawEnforcementDetailsCubit({
    required this.services,
    required this.commonServices,
    this.model,
    required this.location,
    required this.locationRegion,
    required this.vendor,
  }) : super(
    LawEnforcementDetailsState.initial(
      model: model ?? LawEnforcementModelNew(),
      locations: Locations(),
      loggedInUserDetails: User(),
      users: const [],
      emailUsers: const [],
      listOfEntities: const [],
      vendors: const [],
      typeOfServices: const [],
      errorMessage: '',
      getEntitiesResponse: const [],
    ),
  );

  void onModelValueChange(LawEnforcementModelNew model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(LawEnforcementModelNew model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    List<Organisation>? entities =
    await commonServices.getOrganisations(name: 'ATOM_ENTITIES');
    List<BaseUser> emailUsers = await commonServices.getBaseUsers(
      roleName: ConstantUserRoles.atomAssistantSecurityLead,
      locationId: state.model.location?.id,
      isDbUser: true,
    );

    Vendors vendors = await commonServices.getVendors(name: 'ATOM_VENDORS');

    TypeOfServices typeOfService = await commonServices.getTypeOfService(
        name: 'SLA_VIOLATION_TYPE_OF_SERVICE');

    emit(
      state.copyWith(
        getEntitiesResponse: entities,
        listOfEntities: entities,
        status: FormStatus.initial,
        emailUsers: emailUsers,
        vendors: vendors.items,
        typeOfServices: typeOfService.items,
      ),
    );
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

    if (state.model.location == null) {
      Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();
      if (defaultLocation != null) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: defaultLocation.id.toString(),
          moduleCode: Constants.leoModuleCode,
        );
        state.model.location = defaultLocation;
        state.model.slNo = slNo.serialNo;
      }
    }

    try {
      Locations getLocationsData =
      await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      AddEntities entities =
      await commonServices.getEntities(name: 'ATOM_ENTITIES');

      Vendors vendors = await commonServices.getVendors(name: 'ATOM_VENDORS');

      TypeOfServices typeOfService = await commonServices.getTypeOfService(
          name: 'SLA_VIOLATION_TYPE_OF_SERVICE');

      User loggedInUserDetails =
      await commonServices.getUserDetails(userId: userId);

      List<BaseUser> emailUsers = await commonServices.getBaseUsers(
        roleName: ConstantUserRoles.atomStaticUser,
        locationId: state.model.location?.id,
        isDbUser: true,
      );

      if (location != null) {
        state.model.location = location;
      }
      if (locationRegion != null) {
        state.model.locationRegion = locationRegion;
      }
      // if (vendor != null) {
      //   if (state.model.vendor.isEmptyOrNull) {
      //     state.model.vendor = [];
      //   }
      //
      //   state.model.vendor?.add(vendor!);
      // }
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      // Get Date of Creation
      // state.model.inputDate = state.model.inputDate == null
      //     ? Utils().getCurrentDate()
      //     : Utils().formatUnixTimestamp(state.model.inputDate ?? '');
      // state.model.inputDate =
      //     (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.leoModuleCode);
      SlaUiLabels labels = SlaUiLabels.fromJson(responseLabels);

      if (location != null) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: location!.id.toString(),
          moduleCode: Constants.leoModuleCode,
        );
        state.model.location = location;
        state.model.slNo = slNo.serialNo;
      }

      // List<String> pocs = Utils().splitStringAfterComma(state.model.poc ?? '');
      log('-typeOfService.items---${typeOfService.items}---');

      state.model.entrySecurity ??= loggedInUserDetails;
      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          emailUsers: emailUsers,
          listOfEntities: entities.atomEntities,
          vendors: vendors.items,
          typeOfServices: typeOfService.items,
          labels: labels,
        ),
      );
    } catch (e) {
      log('initialization issue',
          error: e, name: 'Law Enforcement Details Cubit');
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

    List<BaseUser> emailUsers = [];

    /// Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.leoModuleCode,
      );

      state.model.location = location;
      state.model.slNo = slNo.serialNo ?? '';

      emailUsers = await commonServices.getBaseUsers(
        roleName: ConstantUserRoles.atomStaticUser,
        locationId: location.id,
        isDbUser: true,
      );
    }

    // state.model.approver = null;

    emit(state.copyWith(
      model: state.model,
      emailUsers: emailUsers,
      status: FormStatus.initial,
    ));
  }

  Future<void> updateDropdownValues({
    List<Organisation>? entities,
    List<Organisation>? vendors,
    List<Organisation>? typeOfServices,
    // Organisation? location,
    BaseUser? user,
    BaseUser? approver,
    int? status,
    BaseUser? receiverEmailUser,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    // List<BaseUser> emailUsers = [];
    // // Get Sl No from API
    // if (location != null) {
    //   SerialNumberModel slNo = await commonServices.getSlNo(
    //     locationId: location.id.toString(),
    //     moduleCode: Constants.slaViolationPenaltyDetailsModuleCode,
    //   );
    //   state.model.location = location;
    //   state.model.slNo = slNo.serialNo;
    //   emailUsers = await commonServices.getBaseUsers(
    //       roleName: ConstantUserRoles.atomStaticUser, locationId: location.id);
    // }
    state.model.status = status ?? state.model.status;
    // if (location != null) {
    //   SerialNumberModel slNo = await commonServices.getSlNo(
    //       locationId: location.id.toString(),
    //       moduleCode: Constants.slaViolationPenaltyDetailsModuleCode);
    //   state.model.location = location;
    //   state.model.slNo = slNo.serialNo;
    // }
    if (entities != null) {
      state.model.entities = entities;
    }
    // if (vendors != null) {
    //   state.model.vendor = vendors;
    // }
    // if (typeOfServices != null) {
    //   state.model.typeOfService = typeOfServices;
    // }

    if (user != null) {
      User userDetails = User(
        name: user.name,
        userId: user.id,
        userName: user.name,
      );
      // state.model.approver = userDetails;
    }
    emit(state.copyWith(
      model: state.model,
      // emailUsers: emailUsers,
      status: FormStatus.initial,
    ));
  }

  Future<bool> submitForm({
    bool isSaveOnly = false,
    bool navigateToNextScreen = false,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.inputDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.inputDate = inputDate.toString();
    }

    //
    // state.model.startTime = state.model.startTime != null
    //     ? ((int.tryParse(state.model.startTime ?? '') ?? DateTime.now().millisecondsSinceEpoch)).toString()
    //     : (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    //
    // state.model.endTime = state.model.endTime != null
    //     ? ((int.tryParse(state.model.endTime ?? '') ?? DateTime.now().add(const Duration(hours: 12)).millisecondsSinceEpoch)).toString()
    //     : (DateTime.now().add(const Duration(hours: 12)).millisecondsSinceEpoch ~/ 1000).toString();
    //
    // if(state.model.status == 1 && (state.model.updatedStatus == 2||state.model.updatedStatus == 8 || state.model.updatedStatus == 9)){
    //   state.model.returnedTime = state.model.returnedTime != null
    //       ? ((int.tryParse(state.model.returnedTime ?? '') ?? DateTime.now().millisecondsSinceEpoch)).toString()
    //       : (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    // }

    // Create/Update API Call
    LawEnforcementRequestBodyNew request =
    LawEnforcementRequestBodyNew(lawEnforcementModel: state.model);


    // TODO: Need to change from Backend- Status should be handled from backend
    state.model.status ??= 0;
    try {
      GenericResponse response = GenericResponse();
      if (isSaveOnly) {
        //Validating Fields
        if (!state.isValidDraft.status) {
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValidDraft.message,
            ),
          );
          return false;
        }
        response = await services.createLawEnforcement(
            body: request, isSubmit: false);
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return false;
        }
        response = await services.createLawEnforcement(
            body: request, isSubmit: true);
      }

      log('---response--msg--${response.message}---');

      if (response.id != null) {
        int? id = int.tryParse(response.id!);
        if (id != null) {
          state.model.id = id;
        }
      }
      emit(
        state.copyWith(
          model: state.model,
          message: response.message,
          status: navigateToNextScreen
              ? FormStatus.navigateToNextScreen
              : FormStatus.success,
        ),
      );
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      return true;
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      return false;
    } on Exception catch (e) {
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
      return false;
    }
  }

}
