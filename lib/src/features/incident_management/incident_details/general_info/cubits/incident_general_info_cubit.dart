import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/createfound/models/user.dart';
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
import '../../../../createfound/models/get_articletype_model.dart';
import '../../../../createfound/models/get_depositor_model.dart';
import '../models/general_info_model.dart';
import '../models/requestModel/general_info_request.dart';
import '../services/incident_management_services.dart';

part 'incident_general_info_state.dart';

class IncidentGeneralInfoCubit extends Cubit<IncidentGeneralInfoState> {
  final IncidentManagementServices services;
  final String id;
  final CommonServices commonServices;

  IncidentGeneralInfoCubit({
    required this.services,
    required this.commonServices,
    required this.id,
  }) : super(
          IncidentGeneralInfoState.initial(
            model: IncidentManagement(),
            locations: GetLocations(),
            users: const [],
            emailUsers: const [],
            errorMessage: '',
            loadAttachments: const [],
            eventId: null,
            listOfEntities: const [],
            getEntitiesResponse: null,
            departments: const [],
            loggedInUserDetails: null, getArticleTypeResponse: GetArticleType(),
          ),
        );

  void onModelValueChange(IncidentManagement model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(IncidentManagement model) {
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
      IncidentManagement model = IncidentManagement();
      if (id.isNotEmpty) {
        model = await services.getIncidentDetails(id);
      }

      // Get Date of Creation
      model.inputDate = Utils().getCurrentDate();

      GetLocations getLocationsData =
          await commonServices.getLocations(name: 'ATOM_LOCATIONS');

      User loggedInUserDetails =
          await commonServices.getUserDetails(userId: userId);

      Analyst users =
          await commonServices.getUsersByRole(roleName: 'T1_Analyst');

      GetDepositor emailUsers =
          await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

      AddEntities entities =
          await commonServices.getEntities(name: 'ATOM_ENTITIES');

      GetArticleType getArticleType =
      await commonServices.getArticleType(name: 'ARTICLE_LIST');

      List<User> entrySecurities = await commonServices.getUsers();

      EmployeeDepartments departments =
          await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');

      emit(
        state.copyWith(
          model: model,
          locations: getLocationsData,
          articleType: getArticleType,
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
    BaseUser? complainant,
    BaseUser? complainantHR,
    BaseUser? incidentManager,
    BaseUser? incidentOwner,
    List<Entity>? entities,
    Organisation? complainantDepartment,
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
    state.model.incidentType =
        incidentType ?? state.model.incidentType;
    log('--incidentType----$incidentType--');


    state.model.typeOfAsset =
        assetType ?? state.model.typeOfAsset;
    log('--assetType----$assetType--');

    if (complainant != null) {
      User userDetails = User(
        name: complainant.name,
        userId: complainant.id,
        userName: complainant.name,
      );
      state.model.complainant = userDetails;
    }

    if (complainantHR != null) {
      User userDetails = User(
        name: complainantHR.name,
        userId: complainantHR.id,
        userName: complainantHR.name,
      );
      state.model.complainantHr = userDetails;
    }

    if (incidentManager != null) {
      User userDetails = User(
        name: incidentManager.name,
        userId: incidentManager.id,
        userName: incidentManager.name,
      );
      state.model.incidentManager = userDetails;
    }

    if (incidentOwner != null) {
      User userDetails = User(
        name: incidentOwner.name,
        userId: incidentOwner.id,
        userName: incidentOwner.name,
      );
      state.model.incidentOwner = userDetails;
    }

    if (complainantDepartment != null) {
      state.model.complainantDepartment = complainantDepartment;
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

    log('--state.model.incidentType--@@---${state.model.incidentType}-');

   // if (state.model.incidentType != null) {
   //   log('--incidentType---$incidentType-');
   //   state.model.incidentType = incidentType;
   //   log('--state.model.incidentType--@@---${state.model.incidentType}-');
   // }

    if (state.model.typeOfAsset != null) {
      log('--incidentType---$incidentType-');
      state.model.typeOfAsset = assetType;
      log('--state.model.incidentType--@@---${state.model.typeOfAsset}-');
    }

    if (entities != null) {
      state.model.entities = entities;
    }


    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));

    log('--state.model---${state.model.incidentType}--');
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
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    // if (state.model.status == 0 || state.model.status == null) {
    //   state.model.status = 1;
    // }
    // Setting time in milliseconds
    state.model.inputDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    /// Create/Update API Call
    IncidentGeneralInfoRequest request =
    IncidentGeneralInfoRequest(incidentManagement: state.model);

    log('--isSaveOnly----$isSaveOnly--');
    GenericCreateResponse response = GenericCreateResponse();
    try {
      if (isSaveOnly) {
        response = (await services.createIncidentManagement(
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
        response = (await services.createIncidentManagement(
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
        message: response.message,
        status: FormStatus.success,
      ),
    );
  }
}
