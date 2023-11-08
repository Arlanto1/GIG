import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/common_widgets/signature/signature_controller.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/features/material_movement/models/material_movement_model.dart';
import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';
import 'package:db_atom/src/features/material_movement/models/quantity_units.dart';
import 'package:db_atom/src/features/material_movement/models/requestModels/material_movement_request.dart';
import 'package:db_atom/src/features/material_movement/services/material_movement_services.dart';
import 'package:db_atom/src/models/language.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../constants/constants.dart';
import '../../../../enums/form_status.dart';
import '../../../../models/base_user.dart';
import '../../../../models/organisation.dart';
import '../../../../models/responseModels/error_response_validation.dart';
import '../../../../models/responseModels/generic_create_response.dart';
import '../../../createfound/models/emplyee_departments_model.dart';
import '../../../passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import '../../models/mm_ui_labels.dart';

part 'material_movement_details_state.dart';

class MaterialMovementDetailsCubit extends Cubit<MaterialMovementDetailsState> {
  final MaterialMovementServices materialMovementServices;
  final MaterialMovementModel? model;
  final CommonServices commonServices;
  final bool? isInward;
  final bool? returnable;

  MaterialMovementDetailsCubit({
    required this.materialMovementServices,
    required this.commonServices,
    this.model,
    this.isInward,
    this.returnable,
  }) : super(
          MaterialMovementDetailsState.initial(
            model: model ?? MaterialMovementModel(),
            locations: GetLocations(),
            loggedInUserDetails: User(),
            users: const [],
            emailUsers: const [],
            errorMessage: '',
            departments: const [],
            loadAttachments: const [],
            quantityUnits: const [],
            eventId: null,
          ),
        );

  void onModelValueChange(MaterialMovementModel model) {
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
      GetLocations getLocationsData =
          await commonServices.getLocations(name: 'ATOM_LOCATIONS');

      User loggedInUserDetails =
          await commonServices.getUserDetails(userId: userId);
      Analyst users =
          await commonServices.getUsersByRole(roleName: 'T1_Analyst');

      // Get Date of Creation
      state.model.inputDate = Utils().getCurrentDate();
      state.model.inputDate =
          DateFormat(Constants.fulldateFormat).format(DateTime.now());

      state.model.inwardMovement = isInward;
      if (state.model.approvedDate != null) {
        state.model.approvedDate =
            Utils().formatUnixTimestamp(state.model.approvedDate ?? '');
      }
      if (state.model.rejectedDate != null) {
        state.model.rejectedDate =
            Utils().formatUnixTimestamp(state.model.rejectedDate ?? '');
      }
      EmployeeDepartments departments =
          await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');
      log('--getlabels-----}--');

      // MmUiLabels uilabels = await commonServices.getUiLabels(
      //     language: 'en', moduleCode: Constants.materialMovementModuleCode);
      //
      // log('--uilabels-----${uilabels.defaultLabels}--');
      // log('--uilabels---2232--${uilabels.localeLabels.status}--');

      GetDepositor emailUsers =
          await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

      QuantityUnits quantityUnits = await commonServices.getQuantityUnits();

      state.model.entrySecurity = loggedInUserDetails;
      state.model.unit = model?.unit;

      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          users: users.t1Analyst,
          emailUsers: emailUsers.atomStaticUser,
          departments: departments.employeeDepartments,
          quantityUnits: quantityUnits.units,
          //  language: uilabels
        ),
      );
    } catch (e) {
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
    Organisation? location,
    BaseUser? user,
    BaseUser? receiverEmailUser,
    BaseUser? requesterEmailUser,
    BaseUser? approver1EmailUser,
    BaseUser? returnReceiverMailId,
    BaseUser? approver2EmailUser,
    Organisation? requesterDepartment,
    Organisation? preparedByDepartment,
    Organisation? approver1Department,
    Organisation? approver2Department,
    Organisation? receiverDepartment,
    Organisation? quantityUnit,
    bool? isReturnable,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    // Get Sl No from API
    if (location != null && isInward == true) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.materialMovementInwardReturnableModule,
      );
      state.model.location = location;
      state.model.slNo = slNo.serialNo;
    }
    if (location != null &&
        isInward == false &&
        state.model.returnable == true) {
      SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: location.id.toString(),
          moduleCode: Constants.materialMovementOutwardReturnableModule);
      state.model.location = location;
      state.model.slNo = slNo.serialNo;
    }

    if (location != null &&
        isInward == false &&
        state.model.returnable == false) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.materialMovementOutwardNonReturnableModule,
      );
      state.model.location = location;
      state.model.slNo = slNo.serialNo;
    }

    if (user != null) {
      state.model.otherReceiverName = user.name;
    }

    if (receiverEmailUser != null) {
      state.model.receiverEmail = receiverEmailUser.email;
    }

    if (receiverEmailUser != null) {
      state.model.receiverEmail = receiverEmailUser.email;
    }

    if (requesterEmailUser != null) {
      state.model.requestorEmail = requesterEmailUser.email;
    }
    if (approver1EmailUser != null) {
      state.model.approver1Email = approver1EmailUser.email;
    }
    if (returnReceiverMailId != null) {
      state.model.returnReceiverMailId = returnReceiverMailId.email;
    }
    if (approver2EmailUser != null) {
      state.model.approver2Email = approver2EmailUser.email;
    }

    if (requesterDepartment != null) {
      state.model.requestorDepartment = requesterDepartment;
    }
    if (preparedByDepartment != null) {
      state.model.preparedByDepartment = preparedByDepartment;
    }
    if (approver1Department != null) {
      state.model.approver1Department = approver1Department;
    }

    if (approver2Department != null) {
      state.model.approver2Department = approver2Department;
    }
    log('--depart---${receiverDepartment?.name}-----');
    if (receiverDepartment != null) {
      state.model.receiverDepartment = receiverDepartment;
    }
    if (quantityUnit != null) {
      state.model.unit = quantityUnit;
    }
    log('-quantityUnit---${state.model.unit?.name}');

    if (isReturnable != null) {
      state.model.returnable = isReturnable;
    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void addAttchment(List<CreateImage>? data) async {
    log('--state.status-1---${state.status}----');

    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    int eventIds = math.Random.secure().nextInt(5);

    log('--data----${data?.length}----');
    log('--state.status-2---${state.status}----');

    emit(state.copyWith(
      eventId: eventIds,
      model: state.model,
      loadAttachments: data,
      status: FormStatus.initial,
    ));

    log('--state.status--3--${state.status}----');
  }

  void showFields(
      {bool? isOriginalReceiverReceiving, bool? isMaterialPhysicallyChecked}) {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (isOriginalReceiverReceiving != null) {
      state.model.originalReceiver = isOriginalReceiverReceiving;
    }
    if (isMaterialPhysicallyChecked != null) {
      state.model.materialPhysicallyChecked = isMaterialPhysicallyChecked;
    }
    // final updatedMaterialMovement = materialMovement.copyWith(state.materialMovement.originalReceiver: isOriginalReceiverReceiving);

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  Future<void> pushSignature({
    required SignatureController controller,
    required isReceiverSignature,
  }) async {
    String imageBytes = await exportSignature(
      controller,
    );
    if (imageBytes.isEmptyOrNull) {
      return;
    }
    ImageContent imageContent = ImageContent();
    imageContent.imageContent = imageBytes;
    if (isReceiverSignature) {
      (state.model.receiverSign ??= []).add(imageContent);
    } else {
      (state.model.entrySecuritySign ??= []).add(imageContent);
    }
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<String> exportSignature(
    SignatureController controller,
  ) async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      exportBackgroundColor: Colors.white,
      penColor: Colors.black,
      points: controller.points,
    );

    Uint8List? signature = await exportController.toPngBytes();
    if (signature == null) {
      return '';
    }
    String bs4str = base64Encode(signature);

    //clean up the memory
    exportController.dispose();

    return bs4str;
    // saveSignature(context, signature!);
  }

  Future<void> submitForm({
    bool isSaveOnly = false,
    required SignatureController receiverSignatureController,
    required SignatureController securitySignatureController,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    // Setting time in milliseconds
    state.model.inputDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    /// Adding Signature to request Body
    pushSignature(
      controller: receiverSignatureController,
      isReceiverSignature: true,
    );
    pushSignature(
      controller: securitySignatureController,
      isReceiverSignature: false,
    );

    // Create/Update API Call
    MaterialMovementRequest request =
        MaterialMovementRequest(materialMovement: state.model);

    // TODO: Need to change from Backend- Status should be handled from backend
    state.model.status ??= 0;
    try {
      GenericCreateResponse response = GenericCreateResponse();
      if (isSaveOnly) {
        //Validating Fields
        if (!state.isValidDraft.status) {
          state.model.inputDate =
              DateFormat(Constants.fulldateFormat).format(DateTime.now());
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValidDraft.message,
            ),
          );
          return;
        }
        response = await materialMovementServices.createMaterialMovement(
            body: request, isSubmit: false);
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          state.model.inputDate =
              DateFormat(Constants.fulldateFormat).format(DateTime.now());
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValid.message,
            ),
          );
          return;
        }
        response = await materialMovementServices.createMaterialMovement(
            body: request, isSubmit: true);
      }

      log('---response--msg--${response.message}---');

      emit(
        state.copyWith(
          message: response.message,
          status: FormStatus.success,
        ),
      );
    } on Exception catch (e) {
      state.model.inputDate =
          DateFormat(Constants.fulldateFormat).format(DateTime.now());
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }
  }
}
