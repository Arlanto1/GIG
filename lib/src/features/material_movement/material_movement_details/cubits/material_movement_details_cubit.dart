import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:intl/intl.dart';

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
            locations: Locations(),
            users: const [],
            emailUsers: const [],
            errorMessage: '',
            departments: const [],
            loadAttachments: const [],
            quantityUnits: const [],
            eventId: null,
          ),
        );

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    List<Organisation> quantityUnits = await commonServices.getOrganisations(
        name: 'ATOM_MATERIAL_MOVEMENT_UNIT');

    Analyst users = await commonServices.getUsersByRole(roleName: 'T1_Analyst');
    EmployeeDepartments departments =
        await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');
    List<BaseUser> emailUsers =
        await commonServices.getBaseUsersByRoles(roleNames: 'ATOM_STATIC_USER');

    emit(
      state.copyWith(
        status: FormStatus.initial,
        users: users.t1Analyst,
        loadAttachments: state.model.images,
        emailUsers: emailUsers,
        departments: departments.employeeDepartments,
        quantityUnits: quantityUnits,
      ),
    );
  }

  void onModelValueChange(MaterialMovementModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<void> isFormReadable() async {
    if (isInward ?? false) {
      return;
    }

    if (state.model.status != ConstantsIntValue.businessUserReview) {
      emit(state.copyWith(
        status: FormStatus.initial,
      ));
      return;
    }

    emit(state.copyWith(model: model, status: FormStatus.loading));
    String email = await SharedPrefs.getEmail();
    bool isReadOnly;

    if (state.model.requestorEmail.equalsIgnoreCase(email)) {
      isReadOnly = false;
    } else {
      isReadOnly = true;
    }

    emit(state.copyWith(
      model: model,
      isReadOnly: isReadOnly,
      status: FormStatus.initial,
    ));
  }

  Future<void> initializeValues() async {
    log('-status-1-${state.status}--');
    // Show Loader and emit loading state
    emit(
      state.copyWith(status: FormStatus.loading),
    );

    var userId = await SharedPrefs.getUserId();
    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),
        commonServices.getUserDetails(userId: userId),
        commonServices.getUsersByRole(roleName: 'T1_Analyst'),
        commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS'),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.materialMovementModuleCode),
        SharedPrefs.getDefaultLocation(),
        commonServices.getBaseUsersByRoles(roleNames: 'ATOM_STATIC_USER'),
        commonServices.getOrganisations(name: 'ATOM_MATERIAL_MOVEMENT_UNIT'),
      ]);

      Locations locations = futures[0];
      User loggedInUserDetails = futures[1];
      Analyst users = futures[2];
      EmployeeDepartments departments = futures[3];
      dynamic responseLabels = futures[4];
      Organisation? defaultLocation = futures[5];
      List<BaseUser> emailUsers = futures[6];
      List<Organisation> quantityUnits = futures[7];

      // Get Date of Creation
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          :  Utils.timestampToDateConversion(
          int.tryParse(state.model?.inputDate ?? '0'),
          Constants.fulldateFormat);

      // if (state.model.inputDate != null) {
      //   Utils.timestampToDateConversion(
      //       int.tryParse(state.model?.inputDate ?? '0'),
      //       Constants.fulldateFormat);
      // } else {
      //   Utils().getCurrentDate();
      // }

      state.model.inwardMovement = isInward;
      if (state.model.approvedDate != null) {
        state.model.approvedDate =
            Utils().formatUnixTimestamp(state.model.approvedDate ?? '');
      }
      if (state.model.rejectedDate != null) {
        state.model.rejectedDate =
            Utils().formatUnixTimestamp(state.model.rejectedDate ?? '');
      }

      MmUiLabels labels = MmUiLabels.fromJson(responseLabels);
      if (state.model.location == null && defaultLocation != null) {
        String moduleCode = isInward ?? false
            ? Constants.materialMovementInwardReturnableModule
            : Constants.materialMovementOutwardNonReturnableModule;

        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: defaultLocation.id.toString(),
          moduleCode: moduleCode,
        );

        state.model.location = defaultLocation;
        state.model.slNo = slNo.serialNo;
      }

      log('--loggedInUserDetails---${loggedInUserDetails.firstName}----');

      state.model.entrySecurity ??= loggedInUserDetails;
      state.model.unit = model?.unit;
      // state.model.rejectedBy ??= loggedInUserDetails;
      log('--state.model.entrySecurity---${state.model.entrySecurity?.firstName}----');

      emit(
        state.copyWith(
          locations: locations,
          loggedInUserDetails: state.model.entrySecurity,
          status: FormStatus.initial,
          model: state.model,
          users: users.t1Analyst,
          loadAttachments: state.model.images,
          emailUsers: emailUsers,
          approver1Users: emailUsers,
          approver2Users: emailUsers,
          departments: departments.employeeDepartments,
          quantityUnits: quantityUnits,
          labels: labels,
        ),
      );
      isFormReadable();
    } catch (e) {
      log('Initialization issue',
          error: e, name: 'Material Movement Details Cubit');
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
    BaseUser? receiverEmail,
    BaseUser? requesterEmailUser,
    BaseUser? returnReceiverMailId,
    Organisation? requesterDepartment,
    Organisation? preparedByDepartment,
    Organisation? approver1Department,
    Organisation? approver2Department,
    Organisation? receiverDepartment,
    Organisation? quantityUnit,
    bool? isReturnable,
    int? status,
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
    if (location != null && isInward == false) {
      SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: location.id.toString(),
          moduleCode: state.model.returnable ?? false
              ? Constants.materialMovementOutwardReturnableModule
              : Constants.materialMovementOutwardNonReturnableModule);
      state.model.location = location;
      state.model.slNo = slNo.serialNo;
    }
    state.model.status = status ?? state.model.status;
    // if (location != null &&
    //     isInward == false &&
    //     state.model.returnable == false) {
    //   SerialNumberModel slNo = await commonServices.getSlNo(
    //     locationId: location.id.toString(),
    //     moduleCode: Constants.materialMovementOutwardNonReturnableModule,
    //   );
    //   state.model.location = location;
    //   state.model.slNo = slNo.serialNo;
    // }

    if (user != null) {
      state.model.receiverEmail = user.name;
    }

    if (receiverEmailUser != null) {
      state.model.receiverEmail = receiverEmailUser.email;
    }

    if (receiverEmail != null) {
      state.model.receiverEmail = receiverEmail.email;
    }

    if (requesterEmailUser != null) {
      state.model.requestorEmail = requesterEmailUser.email;
    }

    if (returnReceiverMailId != null) {
      state.model.returnReceiverMailId = returnReceiverMailId.email;
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
    if (receiverDepartment != null) {
      state.model.receiverDepartment = receiverDepartment;
    }
    if (quantityUnit != null) {
      state.model.unit = quantityUnit;
    }

    if (isReturnable != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: state.model.location!.id.toString(),
          moduleCode: isReturnable
              ? Constants.materialMovementOutwardReturnableModule
              : Constants.materialMovementOutwardNonReturnableModule);
      state.model.slNo = slNo.serialNo;
      state.model.returnable = isReturnable;
    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  Future<void> updateApproverEmailsValue({
    BaseUser? requesterEmailUser,
    BaseUser? approver1EmailUser,
    BaseUser? approver2EmailUser,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (requesterEmailUser != null) {
      state.model.requestorEmail = requesterEmailUser.email;

      emit(
        state.copyWith(
          requestorEmailUsers: state.emailUsers,
        ),
      );
      state.approver1Users?.remove(requesterEmailUser);
      state.approver2Users?.remove(requesterEmailUser);

      emit(
        state.copyWith(
          model: state.model,
          approver2Users: state.approver2Users,
          approver1Users: state.approver1Users,
          status: FormStatus.initial,
        ),
      );
    }

    if (approver1EmailUser != null) {
      state.model.approver1Email = approver1EmailUser.email;

      emit(
        state.copyWith(
          approver2Users: state.emailUsers,
        ),
      );

      state.requestorEmailUsers?.remove(approver1EmailUser);
      state.approver2Users?.remove(approver1EmailUser);

      emit(
        state.copyWith(
          model: state.model,
          requestorEmailUsers: state.requestorEmailUsers,
          approver2Users: state.approver2Users,
          status: FormStatus.initial,
        ),
      );
    }

    if (approver2EmailUser != null) {
      state.model.approver2Email = approver2EmailUser.email;

      emit(
        state.copyWith(
          approver1Users: state.emailUsers,
        ),
      );

      state.requestorEmailUsers?.remove(approver2EmailUser);
      state.approver1Users?.remove(approver2EmailUser);

      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
          requestorEmailUsers: state.requestorEmailUsers,
          approver1Users: state.approver1Users,
        ),
      );
    }
  }

  void addAttchment(List<ImageContent>? data) async {
    log('--state.status-1---${state.status}----');
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    int eventIds = math.Random.secure().nextInt(5);
    if (data != null) {
      for (ImageContent image in data) {
        image.type = 0;
      }
      log('--data----${data.length}----');

      state.model.images = data;
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          loadAttachments: data,
          status: FormStatus.initial,
        ),
      );

      log('--state.status--3--${state.status}----');
    }
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

  void makeSignEditable(
      {bool? receiverSign, bool? entrySecuritySignatureSignEditable}) {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    emit(
      state.copyWith(
        isReceiverSignEditable: receiverSign,
        isEntrySecuritySignatureSignEditable:
            entrySecuritySignatureSignEditable,
        status: FormStatus.initial,
      ),
    );
  }

  Future<void> pushSignature({
    required SignatureController controller,
    required bool isReceiverSignature,
  }) async {
    String imageBytes = await SignatureController().exportSignature(controller);

    // Check for null explicitly
    if (imageBytes.isEmpty) {
      return;
    }

    ImageContent imageContent = ImageContent();
    imageContent.imageContent = imageBytes;

    log('--imageBytes--$imageBytes--');
    if (isReceiverSignature) {
      imageContent.type = 2;
      state.model.receiverSign = imageContent;
      emit(state.copyWith(
        model: state.model,
      ));
    } else {
      imageContent.type = 3;
      state.model.entrySecuritySign = imageContent;
      emit(state.copyWith(
        model: state.model,
      ));
    }
  }

  Future<void> submitForm({
    bool isSaveOnly = false,
    bool isRejectOnly = false,
    bool isApprovedOnly = false,
    required SignatureController receiverSignatureController,
    required SignatureController securitySignatureController,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    // DateTime dateTime =
    //     DateFormat("dd/MM/yyyy a HH:mm:ss").parse(state.model.inputDate!);
    // int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
    // state.model.inputDate = inputDate.toString();

    // Setting time in milliseconds
    state.model.inputDate = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    state.model.rejectedDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    /// Adding Signature to request Body
    await pushSignature(
      controller: receiverSignatureController,
      isReceiverSignature: true,
    );
    await pushSignature(
      controller: securitySignatureController,
      isReceiverSignature: false,
    );

    // Create/Update API Call
    MaterialMovementRequest request =
        MaterialMovementRequest(materialMovement: state.model);

    // TODO: Need to change from Backend- Status should be handled from backend
    state.model.status ??= 0;
    try {
      GenericResponse response = GenericResponse();
      if (isSaveOnly) {
        //Validating Fields
        if (!state.isValidDraft.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValidDraft.message,
            ),
          );
          return;
        }
        response = await materialMovementServices.createMaterialMovement(
            body: request, flow: 1);
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return;
        }
        int flow = 2;
        response = await materialMovementServices.createMaterialMovement(
            body: request, flow: flow);
      }

      if (isRejectOnly) {
        //Validating Fields
        if (!state.isValidDraft.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValidDraft.message,
            ),
          );
          return;
        }
        response = await materialMovementServices.createMaterialMovement(
            body: request, flow: 4);
      }
      if (isApprovedOnly) {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return;
        }
        response = await materialMovementServices.createMaterialMovement(
            body: request, flow: 3);
      }

      log('---response--msg--${response.message}---');

      emit(
        state.copyWith(
          message: response.message,
          status: FormStatus.success,
        ),
      );
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          :  Utils.timestampToDateConversion(
          int.tryParse(state.model?.inputDate ?? '0'),
          Constants.fulldateFormat);
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
        ),
      );
      return;
    } on Exception catch (e) {
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          :  Utils.timestampToDateConversion(
          int.tryParse(state.model?.inputDate ?? '0'),
          Constants.fulldateFormat);
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }
  }

  void updateStatus({required String id}) {
    commonServices.updateRecordStatus(
        id: id, module: Constants.materialMovementModuleCode);
  }

  void onAddRejectionComment(String rejectionsComment) {
    emit(state.copyWith(
      model: model,
      status: FormStatus.loading,
    ));

    state.model.rejectionComment = rejectionsComment;
    emit(state.copyWith(
      model: model,
      rejectionComment: rejectionsComment,
      status: FormStatus.initial,
    ));
  }
}
