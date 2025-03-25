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

  LawEnforcementDetailsCubit({
    required this.services,
    required this.commonServices,
    this.model,
  }) : super(
    LawEnforcementDetailsState.initial(
      model: model ?? LawEnforcementModelNew(),
      locations: Locations(),
      loggedInUserDetails: User(),
      users: const [],
      emailUsers: const [],
      listOfEntities: const [],
      department: const [],
      visitPurpose: const [],
      visitingDepartment: const [],
      errorMessage: '',
      getEntitiesResponse: const [], loadAttachments:const [], distributionGroups: const [],
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
      roleName: ConstantUserRoles.atomStaticUser,
      locationId: state.model.location?.id,
      isDbUser: true,
    );
    EmployeeDepartments departments =
    await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');

    LeoPurposeVisit visitPurpose =  await commonServices.getLeoVisitPurpose(name: 'ATOM_LEO_PURPOSE_VISIT');
    LeoDepartments visitingDepartment =
    await commonServices.getLeoVisitDepartment(name: 'ATOM_LEO_DEPARTMENTS');

    DistributionGroupModel distributionGroup =
    await commonServices.getLeoDistributionGroup();

    emit(
      state.copyWith(
        getEntitiesResponse: entities,
        listOfEntities: entities,
        status: FormStatus.initial,
        emailUsers: emailUsers,
        department : departments.employeeDepartments,
        visitPurpose: visitPurpose.atomLeoPurposeVisit,
        visitingDepartment: visitingDepartment.atomLeoDepartments,
        distributionGroups: distributionGroup.distributionGroups,
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

      EmployeeDepartments departments =
      await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');
      LeoPurposeVisit visitPurpose =  await commonServices.getLeoVisitPurpose(name: 'ATOM_LEO_PURPOSE_VISIT');

      User loggedInUserDetails =
      await commonServices.getUserDetails(userId: userId);

      List<BaseUser> emailUsers = await commonServices.getBaseUsers(
        roleName: ConstantUserRoles.atomStaticUser,
        locationId: state.model.location?.id,
        isDbUser: true,
      );
      LeoDepartments visitingDepartment =
      await commonServices.getLeoVisitDepartment(name: 'ATOM_LEO_DEPARTMENTS');

      DistributionGroupModel distributionGroup =
      await commonServices.getLeoDistributionGroup();


      if (state.model.location == null) {
        Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();
        if (defaultLocation != null) {
          SerialNumberModel slNo = await commonServices.getSlNo(
            locationId: defaultLocation.id.toString(),
            moduleCode: Constants.vipVisitorsDetailsModule,
          );
          state.model.location = defaultLocation;
          state.model.slNo = slNo.serialNo;
        }
      }
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

      // if (location != null) {
      //   SerialNumberModel slNo = await commonServices.getSlNo(
      //     locationId: location!.id.toString(),
      //     moduleCode: Constants.leoModuleCode,
      //   );
      //   state.model.location = location;
      //   state.model.slNo = slNo.serialNo;
      // }

      // List<String> pocs = Utils().splitStringAfterComma(state.model.poc ?? '');

      state.model.entrySecurity ??= loggedInUserDetails;
      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          users: emailUsers,
          listOfEntities: entities.atomEntities,
          department: departments.employeeDepartments,
          visitingDepartment: visitingDepartment.atomLeoDepartments,
          visitPurpose: visitPurpose.atomLeoPurposeVisit,
          distributionGroups: distributionGroup.distributionGroups,
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
      users: emailUsers,
      status: FormStatus.initial,
    ));
  }

  Future<void> updateDropdownValues({
    List<Organisation>? entities,
    List<Organisation>? distributionGroups,
    Organisation? department,
    Organisation? visitPurpose,
    BaseUser? user,
    BaseUser? dbOfficialEmail,
    int? status,
    // BaseUser? receiverEmailUser,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    state.model.status = status ?? state.model.status;

    if (entities != null) {
      state.model.entities = entities;
    }
    if (distributionGroups != null) {
      state.model.mailList = distributionGroups;
    }

    if (department != null) {
      state.model.dbOfficialEmailDepartment = department;
    }

    if (visitPurpose != null) {
      state.model.visitPurpose = visitPurpose;
    }

    if (dbOfficialEmail != null) {
      // Ensure employeeId is explicitly assigned to receiverEmployeeId
      state.model.dbOfficialAccompaniedEmail = dbOfficialEmail.name;
      // Format the name and email for receiverEmail
      String name = dbOfficialEmail.name ?? '';
      String email = dbOfficialEmail.email ?? '';
      state.model.dbOfficialAccompaniedEmail = '$name ($email)';
      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
        ),
      );
    }
    emit(state.copyWith(
      model: state.model,
      users: state.users,
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

    // Create/Update API Call
    LawEnforcementRequestBodyNew request =
    LawEnforcementRequestBodyNew(lawEnforcementModel: state.model);


    // TODO: Need to change from Backend- Status should be handled from backend
    state.model.status ??= 0;
    try {
      // GenericResponse response = GenericResponse();
      SubmitLawEnforcementResponse response =SubmitLawEnforcementResponse();
      // await services.createLawFoundArticle(
      //   body: bodyRequest,
      //   isSubmit: isSubmit,
      // ); /
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
      //
      // if (response.id != null) {
      //   int? id = int.tryParse(response.id!);
      //   if (id != null) {
      //     state.model.id = id;
      //   }
      // }
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

  void addAttachment({
    List<ImageContent>? data,
    List<ImageContent>? images,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    // int eventIds = math.Random.secure().nextInt(5);
    if (data != null) {
      for (ImageContent image in data) {
        image.type = 1;
      }
      log('--data----${data.length}----');

      state.model.images = data;
      emit(
        state.copyWith(
          // eventId: eventIds,
          model: state.model,
          loadAttachments: data,
          status: FormStatus.initial,
        ),
      );
    }

    emit(
      state.copyWith(
        // eventId: eventIds,
        model: state.model,
        status: FormStatus.initial,
      ),
    );

    log('--state.status--3--${state.status}----');
  }

}
