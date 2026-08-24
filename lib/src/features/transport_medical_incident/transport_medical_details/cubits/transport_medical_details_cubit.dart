import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/incident_management/models/im_ui_labels.dart';
import 'package:db_atom/src/features/transport_medical_incident/models/request_models/notification_email_request.dart';
import 'package:db_atom/src/features/transport_medical_incident/models/transport_email_notification.dart';
import 'package:db_atom/src/features/transport_medical_incident/models/transport_medical_incident_model.dart';
import 'package:db_atom/src/features/transport_medical_incident/services/transport_medical_service.dart';
import 'package:intl/intl.dart';

import '../../models/request_models/transport_medical_request_model.dart';

part 'transport_medical_details_state.dart';

class TransportMedicalDetailsCubit extends Cubit<TransportMedicalDetailsState> {
  final TransportMedicalServices services;
  final TransportMedicalModel? model;
  final CommonServices commonServices;
  final bool isTransport;
  final String transportId;
  final TransportEmailNotificationModel? emailModel;

  TransportMedicalDetailsCubit({
    required this.services,
    required this.commonServices,
    this.model,
    required this.isTransport,
    required this.transportId,
    this.emailModel,
  }) : super(
    TransportMedicalDetailsState.initial(
      model: model ?? TransportMedicalModel(),
      locations: Locations(),
      loggedInUserDetails: User(),
      users: const [],
      emailUsers: const [],
      listOfEntities: const [],
      errorMessage: '',
      getEntitiesResponse: const [],
      loadAttachments: const [],
      mapAttachments: const [],
      departments: const [],
      vendors: const [],
      eventId: null,
      draftTemplateHtml: '',
      emailModel: emailModel ?? TransportEmailNotificationModel(),
    ),
  );

  void onModelValueChange(TransportMedicalModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(TransportMedicalModel model) {
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

    emit(
      state.copyWith(
        model: state.model, //  FIX: always carry model
        getEntitiesResponse: entities,
        listOfEntities: entities,
        status: FormStatus.initial,
        escortGuard: emailUsers,
      ),
    );
  }

  Future<void> initializeValues() async {
    log('-status-1-${state.status}--');

    emit(state.copyWith(status: FormStatus.loading));

    var userId = await SharedPrefs.getUserId();

    if (state.model.location == null) {
      Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();
      if (defaultLocation != null) {
        SerialNumberModel slNo = await commonServices.getIMSlNo(
            locationId: defaultLocation.id.toString(),
            moduleCode: Constants.incidentManagementModule,
            type: isTransport ? 0 : 1);
        state.model.location = defaultLocation;
        state.model.slNo = slNo.serialNo;
      }
    }

    try {
      Locations getLocationsData =
      await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      AddEntities entities =
      await commonServices.getEntities(name: 'ATOM_ENTITIES');

      User loggedInUserDetails =
      await commonServices.getUserDetails(userId: userId);

      List<BaseUser> emailUsers = await commonServices.getBaseUsers(
        roleName: ConstantUserRoles.atomStaticUser,
        locationId: state.model.location?.id,
        isDbUser: true,
      );

      List<Map<String, dynamic>> emailTemplates = [];
      if (model != null && model!.id != null) {
        final notificationResponse =
        await services.getNotificationList(model!.id.toString());
        final notificationItems = notificationResponse.data ?? [];
        emailTemplates = notificationItems
            .map((e) => {
          "id": e.id,
          "html": e.notification,
        })
            .toList();
      }

      if (state.model.location == null) {
        Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();
        if (defaultLocation != null) {
          SerialNumberModel slNo = await commonServices.getIMSlNo(
              locationId: defaultLocation.id.toString(),
              moduleCode: Constants.incidentManagementModule,
              type: isTransport ? 0 : 1);
          state.model.location = defaultLocation;
          state.model.slNo = slNo.serialNo;
        }
      }

      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.incidentManagementModule);
      IMUiLabels labels = IMUiLabels.fromJson(responseLabels);
      state.model.entrySecurity ??= loggedInUserDetails;
      state.model.modifiedBy ??= (loggedInUserDetails.firstName ?? "") +
          (loggedInUserDetails.lastName ?? "");

      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          escortGuard: emailUsers,
          employees: emailUsers,
          listOfEntities: entities.atomEntities,
          labels: labels,
          emailTemplates: emailTemplates,
          loadAttachments: emailModel?.images,
        ),
      );
    } catch (e) {
      log('initialization issue',
          error: e, name: 'Transport Medical Details Cubit');
      emit(
        state.copyWith(
          model: state.model, //  FIX: always carry model
          message: Constants.errorText,
          status: FormStatus.error,
        ),
      );
    }
  }

  void showFields({
    bool? escortDeployed,
    bool? premisesRoundTkn,
    bool? employeeTakenToHospital,
  }) {
    emit(state.copyWith(status: FormStatus.loading));

    if (escortDeployed != null) {
      // state.model.escortDeployed = escortDeployed;
    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void updateEmployee(List<User> employees) {
    emit(state.copyWith(
      model: state.model, //  FIX: was passing cubit-level `model` not state.model
      status: FormStatus.loading,
    ));
    state.model.employees = employees;
    emit(
      state.copyWith(
        status: FormStatus.initial,
        model: state.model,
      ),
    );
  }

  void addUserEmployee(BaseUser baseUser) {
    final list = List<User>.from(state.model.employees ?? []);

    list.add(
      User(
        userId: baseUser.id,
        name: baseUser.name,
        email: baseUser.email,
        employeeId: baseUser.employeeId,
      ),
    );

    final updatedModel = state.model;
    updatedModel.employees = list;

    emit(state.copyWith(model: updatedModel));
  }

  void removeEmployee(int index) {
    final list = List<User>.from(state.model.employees ?? [])..removeAt(index);

    final updatedModel = state.model;
    updatedModel.employees = list;

    emit(state.copyWith(model: updatedModel));
  }

  void updateEmployeeUser(int index, BaseUser baseUser) {
    final list = List<User>.from(state.model.employees ?? []);

    list[index] = User(
      userId: baseUser.id,
      name: baseUser.name,
      email: baseUser.email,
      employeeId: baseUser.employeeId,
    );

    state.model.employees = list;

    emit(state.copyWith(status: FormStatus.loading));
    emit(state.copyWith(status: FormStatus.initial, model: state.model));
  }

  void updateEmployeeId(int index, String value) {
    final list = List<User>.from(state.model.employees ?? []);

    final existing = list[index];

    list[index] = User(
      userId: existing.userId,
      name: existing.name,
      email: existing.email,
      employeeId: value,
    );

    final updatedModel = state.model;
    updatedModel.employees = list;

    emit(state.copyWith(model: updatedModel));
  }

  Future<void> updateLocationDropdownValue({
    Organisation? location,
  }) async {
    emit(state.copyWith(status: FormStatus.loading));

    List<BaseUser> emailUsers = [];

    if (location != null) {
      SerialNumberModel slNo = await commonServices.getIMSlNo(
          locationId: location.id.toString(),
          moduleCode: Constants.incidentManagementModule,
          type: isTransport ? 0 : 1);

      state.model.location = location;
      state.model.slNo = slNo.serialNo ?? '';

      emailUsers = await commonServices.getBaseUsers(
        roleName: ConstantUserRoles.atomStaticUser,
        locationId: location.id,
        isDbUser: true,
      );
    }

    emit(state.copyWith(
      model: state.model,
      users: emailUsers,
      status: FormStatus.initial,
    ));
  }

  Future<void> updateDropdownValues({
    List<Organisation>? entities,
    Organisation? location,
    List<Organisation>? distributionGroups,
    Organisation? department,
    Organisation? visitPurpose,
    BaseUser? escortGuard,
    BaseUser? employee,
    BaseUser? accompaniedEmployee,
    BaseUser? accompaniedEmployee1,
    int? status,
    int? incidentType,
    int? transportType,
  }) async {
    emit(state.copyWith(status: FormStatus.loading));

    state.model.status = status ?? state.model.status;
    state.model.incidentType = incidentType ?? state.model.incidentType;
    state.model.transportType = transportType ?? state.model.transportType;

    if (location != null) {
      SerialNumberModel slNo = await commonServices.getIMSlNo(
          locationId: location.id.toString(),
          moduleCode: Constants.incidentManagementModule,
          type: isTransport ? 0 : 1);

      state.model.location = location;
      state.model.slNo = slNo.serialNo ?? '';
    }

    if (entities != null) {
      state.model.entities = entities;
    }

    if (escortGuard != null) {
      state.model.escortGuard = User(
        name: escortGuard.name,
        userId: escortGuard.id,
        userName: escortGuard.name,
        email: escortGuard.email,
      );
    }

    if (accompaniedEmployee != null) {
      state.model.accompaniedEmployee = User(
        name: accompaniedEmployee.name,
        userId: accompaniedEmployee.id,
        userName: accompaniedEmployee.name,
        email: accompaniedEmployee.email,
      );
      emit(state.copyWith(model: state.model, status: FormStatus.initial));
    }

    if (accompaniedEmployee1 != null) {
      state.model.accompaniedEmployee1 = User(
        name: accompaniedEmployee1.name,
        userId: accompaniedEmployee1.id,
        userName: accompaniedEmployee1.name,
        email: accompaniedEmployee1.email,
      );
      emit(state.copyWith(model: state.model, status: FormStatus.initial));
    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void updateEmployeeDropdownValues({BaseUser? employee}) {
    if (employee != null) {
      final userDetails = User(
        name: employee.name,
        userId: employee.id,
        userName: employee.name,
        email: employee.email,
      );

      state.model.employees = [userDetails];

      emit(state.copyWith(model: state.model, selectedEmployee: userDetails));
    }
  }

  Future<TransportEmailNotificationModel> getNotificationById(String id) async {
    return await services.getNotificationById(id);
  }

  //  FIX: always carry model so form field values are not wiped
  Future<TransportEmailNotificationModel> getNotificationDetailsById(
      String id) async {
    final response = await services.getNotificationDetailsById(id);

    log("API images: ${response.images}");
    log("API images length: ${response.images?.length}");

    emit(
      state.copyWith(
        model: state.model, //  KEY FIX: was missing, caused isValid to fail
        loadAttachments: List<ImageContent>.from(response.images ?? []),
      ),
    );

    return response;
  }

  //  FIX: always carry model so form field values are not wiped
  Future<void> submitTemplateAndRefresh({
    required String html,
    int? id,
  }) async {
    emit(state.copyWith(
      model: state.model, //  KEY FIX: carry model into loading state
      status: FormStatus.loading,
    ));

    try {
      final transportEmailNotificationInfo = TransportEmailNotificationModel(
        id: id,
        notification: html,
        images: state.loadAttachments,
      );

      final request = TransportNotificationEmailRequest(
        transportEmailNotificationInfo: transportEmailNotificationInfo,
      );

      await services.createTransportNotification(
        body: request,
        eiId: int.parse(state.model.id.toString()),
      );

      final listResponse =
      await services.getNotificationList(state.model.id.toString());

      final items = listResponse.data ?? [];

      emit(state.copyWith(
        model: state.model, //  KEY FIX: was missing, caused isValid to fail after notification
        status: FormStatus.templateSuccess,
        emailTemplates: items
            .map((e) => {
          "id": e.id,
          "html": e.notification,
        })
            .toList(),
      ));
    } catch (e) {
      emit(state.copyWith(
        model: state.model, //  FIX: carry model on error too
        status: FormStatus.error,
        message: e.toString(),
      ));
    }
  }

  /// [isSaveOnly]  — true = draft save, false = full submit
  /// [silent]      — true = suppress the success popup (used when auto-saving
  ///                 before opening the notification template preview).
  ///                 The record is still saved and the model ID is updated;
  ///                 the BlocConsumer listener is simply not triggered because
  ///                 we emit FormStatus.initial instead of FormStatus.success.
  Future<bool> submitForm({
    bool isSaveOnly = false,
    bool navigateToNextScreen = false,
    bool silent = false,
  }) async {
    //  DEBUG: log validation state before anything runs
    log('submitForm called — isSaveOnly: $isSaveOnly, silent: $silent');
    log('model.id: ${state.model.id}, model.status: ${state.model.status}');
    log('isValid: ${state.isValid.status}, message: ${state.isValid.message}');
    log('isValidDraft: ${state.isValidDraft.status}, message: ${state.isValidDraft.message}');

    emit(state.copyWith(
      model: state.model, //  FIX: carry model into loading state
      status: FormStatus.loading,
    ));

    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.inputDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.inputDate = inputDate.toString();
    }

    TransportMedicalRequest request =
    TransportMedicalRequest(transportModel: state.model);

    state.model.status ??= 0;
    state.model.incidentType = isTransport ? 0 : 1;
    state.model.employees ?? (state.model.employees = []);

    try {
      GenericResponse response = GenericResponse();

      if (isSaveOnly) {
        // Validate draft fields
        if (!state.isValidDraft.status) {
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);

          emit(state.copyWith(
            model: state.model,
            status: FormStatus.formError,
            message: state.isValidDraft.message,
          ));
          return false;
        }
        response = await services.createTransportMedical(
            body: request, isSubmit: false);
      } else {
        // Validate submit fields
        if (!state.isValid.status) {
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);

          emit(state.copyWith(
            model: state.model,
            status: FormStatus.formError,
            message: state.isValid.message,
          ));
          return false;
        }
        response = await services.createTransportMedical(
            body: request, isSubmit: true);
      }

      log('---response--msg--${response.message}---');

      // Always update the model ID so callers can use it immediately
      if (response.id != null) {
        int? id = int.tryParse(response.id!);
        if (id != null) {
          state.model.id = id;
        }
      }

      // ─────────────────────────────────────────────────────────────────────
      // KEY FIX:
      //   silent = true  → emit initial (no popup, BlocConsumer skips listener)
      //   silent = false → emit success  (popup shown as normal)
      // ─────────────────────────────────────────────────────────────────────
      if (silent) {
        emit(state.copyWith(
          model: state.model,
          status: FormStatus.initial,
        ));
      } else {
        emit(state.copyWith(
          model: state.model,
          message: response.message,
          status: navigateToNextScreen
              ? FormStatus.navigateToNextScreen
              : FormStatus.success,
        ));
      }

      // Restore human-readable date after save
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
      emit(state.copyWith(
        model: state.model,
        message: e.toString(),
        status: FormStatus.error,
      ));
      return false;
    }
  }

  void removeAttachment(ImageContent imageToRemove) {
    final updatedLoadAttachments =
    List<ImageContent>.from(state.loadAttachments ?? [])
      ..removeWhere((img) => img == imageToRemove);

    final updatedModelImages =
    List<ImageContent>.from(state.emailModel?.images ?? [])
      ..removeWhere((img) => img == imageToRemove);

    state.emailModel?.images = updatedModelImages;

    // If the removed attachment is also referenced by the singular `map`
    // field, clear it too so it isn't sent in the submit payload.
    if (state.model.map == imageToRemove) {
      state.model.map = null;
    }

    emit(
      state.copyWith(
        loadAttachments: updatedLoadAttachments,
        model: state.model,
      ),
    );
  }
  clearAttachments() {
    state.emailModel?.images = [];

    emit(
      state.copyWith(
        model: state.model,
        loadAttachments: [],
        emailModel: state.emailModel,
        status: FormStatus.initial,
      ),
    );

    debugPrint("Attachments cleared");
  }

  void addMapAttachment({
    ImageContent? data,
    List<ImageContent>? images,
  }) async {
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.loading,
    ));

    if (data != null) {
      state.model.map = data;
      emit(
        state.copyWith(
          model: state.model,
          loadAttachments: [data],
          status: FormStatus.initial,
        ),
      );
    }

    log('--state.status--3--${state.status}----');
  }

  void addAttachment(List<ImageContent>? data) async {
    log('--state.status-1---${state.status}----');

    if (data != null) {
      for (ImageContent image in data) {
        image.type = 0;
      }
      final updatedList = List<ImageContent>.from(data);

      log('--data----${data.length}----');

      state.emailModel?.images = data;
      emit(
        state.copyWith(
          model: state.model,
          emailModel: state.emailModel,
          loadAttachments: updatedList,
          status: FormStatus.addAttachment,
        ),
      );
    }

  }
}