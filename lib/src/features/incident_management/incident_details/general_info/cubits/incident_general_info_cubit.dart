import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/incident_management/models/im_ui_labels.dart';
import 'package:intl/intl.dart';

import '../../../models/incidents_response.dart';
import '../../../services/incident_management_services.dart';
import '../models/requestModel/general_info_request.dart';

part 'incident_general_info_state.dart';

class IncidentGeneralInfoCubit extends Cubit<IncidentGeneralInfoState> {
  final IncidentManagementServices services;
  final String id;
  final String occId;
  final int occType;
  final String kldId;
  final CommonServices commonServices;
  final Organisation? location;

  IncidentGeneralInfoCubit({
    required this.services,
    required this.occId,
    required this.commonServices,
    required this.id,
    required this.occType,
    required this.kldId,
    this.location,
  }) : super(
          IncidentGeneralInfoState.initial(
            model: IncidentModel(),
            locations: Locations(),
            users: const [],
            emailUsers: const [],
            errorMessage: '',
            loadAttachments: const [],
            eventId: null,
            listOfEntities: const [],
            getEntitiesResponse: null,
            departments: const [],
            loggedInUserDetails: null,
            getArticleTypeResponse: const [],
          ),
        );

  void onModelValueChange(IncidentModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(IncidentModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    Analyst users = await commonServices.getUsersByRole(roleName: 'T1_Analyst');
    List<Organisation>? entities =
        await commonServices.getOrganisations(name: 'ATOM_ENTITIES');
    List<BaseUser> emailUsers =
        await commonServices.getBaseUsersByRoles(roleNames: 'ATOM_STATIC_USER');
    List<BaseUser> incidentManager = await commonServices.getBaseUsersByRoles(
        roleNames: 'ATOM_Senior_Security_Manager');
    List<BaseUser> incidentOwner = await commonServices.getBaseUsersByRoles(
        roleNames: 'ATOM_Sub_Regional_Head');
    emit(
      state.copyWith(
        status: FormStatus.initial,
        users: users.t1Analyst,
        incidentManager: incidentManager,
        incidentOwner: incidentOwner,
        getEntitiesResponse: entities,
        listOfEntities: entities,
        emailUsers: emailUsers,
      ),
    );
  }

  Future<void> initializeValues() async {
    log('initializeValues---incidentGeneralCubit-occId---$occId--');

    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    var userId = await SharedPrefs.getUserId();
    try {
      IncidentModel model = IncidentModel();
      if (id.isNotEmpty) {
        model = await services.getIncidentDetails(id);
      }

      // Get Date of Creation
      model.inputDate = model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(model.inputDate ?? '0'), Constants.fulldateFormat);
      // model.inputDate = Utils().getCurrentDate();
      // model.inputDate = model.inputDate == null
      //     ? Utils().getCurrentDate()
      //     : Utils().formatUnixTimestamp(model.inputDate ?? '');
      state.model.incidentType ??= 0;
      Locations getLocationsData =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      User loggedInUserDetails =
          await commonServices.getUserDetails(userId: userId);
      model.entrySecurity ??= loggedInUserDetails;

      List<BaseUser> emailUsers = await commonServices.getBaseUsersByRoles(
          roleNames: 'ATOM_STATIC_USER');
      List<BaseUser> incidentManager = await commonServices.getBaseUsersByRoles(
          roleNames: 'ATOM_Senior_Security_Manager');
      List<BaseUser> incidentOwner = await commonServices.getBaseUsersByRoles(
          roleNames: 'ATOM_Sub_Regional_Head');
      AddEntities entities =
          await commonServices.getEntities(name: 'ATOM_ENTITIES');

      GetArticleType getArticleType =
          await commonServices.getArticleType(name: 'ARTICLE_LIST');

      List<User> entrySecurities = await commonServices.getUsers();

      EmployeeDepartments departments =
          await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');

      if (location == null && model.location == null) {
        Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();
        log('defaultLocation $defaultLocation');
        if (defaultLocation != null) {
          SerialNumberModel slNo = await commonServices.getSlNo(
            locationId: defaultLocation.id.toString(),
            moduleCode: Constants.incidentManagementModule,
          );
          model.location = defaultLocation;
          model.slNo = slNo.serialNo;
        }
      } else if(location != null) {
        /// it is getting redirected from Shift Occurrence
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: location!.id.toString(),
          moduleCode: Constants.incidentManagementModule,
        );
        model.location = location;
        model.slNo = slNo.serialNo;
      }
      emit(
        state.copyWith(
          model: model,
          locations: getLocationsData,
          articleType: getArticleType.articleList,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          incidentOwner: incidentOwner,
          incidentManager: incidentManager,
          emailUsers: emailUsers,
          departments: departments.employeeDepartments,
          entrySecurities: entrySecurities,
          listOfEntities: entities.atomEntities,
          getEntitiesResponse: entities.atomEntities,
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
    List<Organisation>? entities,
    Organisation? complainantDepartment,
    Organisation? location,
    Organisation? typeOfArticle,
    // BaseUser? user,
    Organisation? vendor,
    int? status,
    int? incidentType,
    int? typeOfAsset,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    state.model.incidentType = incidentType ?? state.model.incidentType;
    log('--incidentType----$incidentType--');

    state.model.typeOfAsset = typeOfAsset ?? state.model.typeOfAsset;
    log('--assetType----$typeOfAsset--');

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
      state.incidentManager?.remove(incidentManager);
      User userDetails = User(
        name: incidentManager.name,
        userId: incidentManager.id,
        userName: incidentManager.name,
      );
      state.model.incidentManager = userDetails;
    }

    if (incidentOwner != null) {
      state.incidentOwner?.remove(incidentOwner);
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
    if (typeOfArticle != null) {
      state.model.typeOfArticle = typeOfArticle;
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

    // if (state.model.typeOfArticle != null) {
    //   state.model.typeOfArticle = typeOfArticle;
    // }

    // if (state.model.typeOfAsset != null) {
    //   state.model.typeOfAsset = typeOfAsset;
    // }

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
      // state.model.annualPowerShutdown = annualPowerShutdown;
    }
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void submitForm({bool isSaveOnly = false, bool isSubmit = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

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
    state.model.incidentType ??= 0;
    state.model.occurrence ??= OccurrenceModel();
    state.model.occurrence?.id = occId.toIntOrNull();
    state.model.occType = occType;
    state.model.keyLossGi ??= KeyHistoryModel();
    state.model.keyLossGi?.id = kldId.toIntOrNull();

    log('---state.model.occurrence-save---${state.model.occurrence?.id}--');
    log('---state.model.keyLossGi-save---${state.model.keyLossGi?.id}--');

    // Create/Update API Call
    IncidentGeneralInfoRequest request =
        IncidentGeneralInfoRequest(incidentManagement: state.model);

    GenericResponse response = GenericResponse();
    try {
      log('---isSaveOnly-$isSaveOnly---');
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          return emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValidDraft.message,
            ),
          );
        }
        log('---isSaveOnly-1---');
        response = (await services.createIncidentManagement(
            body: request, isSubmit: false));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          log('---submit-1---');
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return;
        }
        response = (await services.createIncidentManagement(
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
        id: id, module: Constants.incidentManagementModule, status: 40);
  }
}
