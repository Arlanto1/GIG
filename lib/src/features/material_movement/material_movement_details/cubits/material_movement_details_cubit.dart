import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/material_movement/models/approval_model.dart';
import 'package:db_atom/src/features/material_movement/models/quantity_units.dart';
import 'package:intl/intl.dart';

part 'material_movement_details_state.dart';

class MaterialMovementDetailsCubit extends Cubit<MaterialMovementDetailsState> {
  final MaterialMovementServices materialMovementServices;
  final MaterialMovementModel? model;
  final CommonServices commonServices;
  final bool? isInward;
  final bool? returnable;
  final List<MaterialItem> materialItems;
  final ApprovalModel? approvalModel;

  MaterialMovementDetailsCubit({
    required this.materialMovementServices,
    required this.commonServices,
    this.model,
    this.isInward,
    required this.returnable,
    required this.materialItems,
    this.approvalModel,
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
            materialItems: const [],
            approvalModel: approvalModel ?? ApprovalModel(),
          ),
        );

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    List<Organisation> quantityUnits = await commonServices.getOrganisations(
        name: 'ATOM_MATERIAL_MOVEMENT_UNIT');
    EmployeeDepartments departments =
        await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');
    List<BaseUser> emailUsers = await commonServices.getBaseUsers(
        roleName: ConstantUserRoles.atomStaticUser,
        locationId: state.model.location!.id!);

    List<BaseUser> onlyDBUsers = await commonServices.getBaseUsers(
      roleName: ConstantUserRoles.atomStaticUser,
      locationId: state.model.location!.id!,
      isDbUser: true,
    );

    emit(
      state.copyWith(
        status: FormStatus.initial,
        loadAttachments: state.model.images,
        emailUsers: emailUsers,
        departments: departments.employeeDepartments,
        quantityUnits: quantityUnits,
        receiverEmailUsers: onlyDBUsers,
        requestorEmailUsers: onlyDBUsers,
        approver1Users: onlyDBUsers,
        approver2Users: onlyDBUsers,
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
    bool isReadOnly;

    if (state.model.requestorEmail
        .equalsIgnoreCase(state.loggedInUserDetails?.userName)) {
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
    log('returnable-$returnable--');

    // Show Loader and emit loading state
    emit(
      state.copyWith(status: FormStatus.loading),
    );

    var userId = await SharedPrefs.getUserId();

    Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();

    if (state.model.location == null && defaultLocation != null) {
      String moduleCode = isInward ?? false
          ? Constants.materialMovementInwardReturnableModule
          : (returnable ?? false
              ? Constants.materialMovementOutwardReturnableModule
              : Constants.materialMovementOutwardNonReturnableModule);
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: defaultLocation.id.toString(),
        moduleCode: moduleCode,
      );

      state.model.location = defaultLocation;
      state.model.slNo = slNo.serialNo;
    }

    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),
        commonServices.getUserDetails(userId: userId),
        commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS'),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.materialMovementModuleCode),
        SharedPrefs.getDefaultLocation(),
        commonServices.getBaseUsers(
            roleName: ConstantUserRoles.atomStaticUser,
            isDbUser: true,
            locationId: state.model.location!.id!),
        commonServices.getOrganisations(name: 'ATOM_MATERIAL_MOVEMENT_UNIT'),
      ]);

      Locations locations = futures[0];
      User loggedInUserDetails = futures[1];
      EmployeeDepartments departments = futures[2];
      dynamic responseLabels = futures[3];
      Organisation? defaultLocation = futures[4];
      List<BaseUser> emailUsers = futures[5];
      List<Organisation> quantityUnits = futures[6];

      log('--emailUsers--${emailUsers.length}---');
      // Get Date of Creation
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);

      state.model.modifiedDate = state.model.modifiedDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.modifiedDate ?? '0'),
              Constants.fulldateFormat);

      // if (state.model.inputDate != null) {
      //   Utils.timestampToDateConversion(
      //       int.tryParse(state.model?.inputDate ?? '0'),
      //       Constants.fulldateFormat);
      // } else {
      //   Utils().getCurrentDate();
      // }

      state.model.inwardMovement = isInward;
      state.model.returnable = returnable;
      if (state.model.approvedDate != null) {
        state.model.approvedDate = Utils.timestampToDateConversion(
            int.tryParse(state.model.approvedDate ?? ''),
            Constants.fulldateFormat);
      }
      if (state.model.rejectedDate != null) {
        state.model.rejectedDate = Utils.timestampToDateConversion(
            int.tryParse(state.model.rejectedDate ?? ''),
            Constants.fulldateFormat);
      }
      // if (state.model.rejectedDate != null) {
      //   state.model.rejectedDate =
      //       Utils().formatUnixTimestamp(state.model.rejectedDate ?? '');
      // }

      MmUiLabels labels = MmUiLabels.fromJson(responseLabels);

      log('--loggedInUserDetails---${loggedInUserDetails.firstName}----');

      state.model.entrySecurity ??= loggedInUserDetails;
      state.model.unit = model?.unit;
      // state.model.rejectedBy ??= loggedInUserDetails;
      log('--state.model.entrySecurity---${state.model.entrySecurity?.firstName}----');

      List<BaseUser> onlyDBUsers = await commonServices.getBaseUsers(
        roleName: ConstantUserRoles.atomStaticUser,
        locationId: state.model.location!.id!,
        isDbUser: true,
      );

      emit(
        state.copyWith(
          locations: locations,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          loadAttachments: state.model.images,
          requestorEmailUsers: onlyDBUsers,
          approver1Users: onlyDBUsers,
          approver2Users: onlyDBUsers,
          receiverEmailUsers: onlyDBUsers,
          returnReceiverEmailId: onlyDBUsers,
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

  Future<void> updateLocationDropdownValue({
    Organisation? location,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    List<BaseUser> emailUsers = [];
    // Get Sl No from API
    if (location != null && isInward == true) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.materialMovementInwardReturnableModule,
      );
      state.model.location = location;
      state.model.slNo = slNo.serialNo;

      emailUsers = await commonServices.getBaseUsers(
          roleName: ConstantUserRoles.atomStaticUser,
          isDbUser: true,
          locationId: state.model.location!.id!);
    }
    if (location != null && isInward == false) {
      SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: location.id.toString(),
          moduleCode: state.model.returnable ?? false
              ? Constants.materialMovementOutwardReturnableModule
              : Constants.materialMovementOutwardNonReturnableModule);
      state.model.location = location;
      state.model.slNo = slNo.serialNo;
      emailUsers = await commonServices.getBaseUsers(
          roleName: ConstantUserRoles.atomStaticUser,
          isDbUser: true,
          locationId: state.model.location!.id!);
    }
    state.model.receiverEmail = null;
    state.model.requestorEmail = null;
    state.model.approver1Email = null;
    state.model.approver2Email = null;

    emit(state.copyWith(
      model: state.model,
      requestorEmailUsers: emailUsers,
      approver1Users: emailUsers,
      approver2Users: emailUsers,
      receiverEmailUsers: emailUsers,
      status: FormStatus.initial,
    ));
  }

  Future<void> updateDropdownValues({
    BaseUser? user,
    BaseUser? receiverEmailUser,
    BaseUser? receiverByEmail,
    BaseUser? requesterEmailUser,
    BaseUser? returnReceiverMailId,
    Organisation? requesterDepartment,
    Organisation? requester2Department,
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

    // if (user != null) {
    //   state.model.receiverEmail = user.employeeId;
    // }
    //
    // if (receiverEmailUser != null) {
    //   state.model.receiverEmployeeId =
    //       '${receiverEmailUser.name}';
    // }
    //
    // if (receiverEmail != null) {
    //   state.model.receiverEmployeeId =
    //       '${receiverEmail.employeeId}';
    // }

    // if (requesterEmailUser != null) {
    //   state.model.requestorEmail =
    //       '${requesterEmailUser.name} (${requesterEmailUser.email})';
    // }

    if (returnReceiverMailId != null) {
      state.model.returnReceiverMailId =
          '${returnReceiverMailId.name} (${returnReceiverMailId.email})';
    }
    if (requesterDepartment != null) {
      state.model.requestorDepartment = requesterDepartment;
    }
    if (requester2Department != null) {
      state.model.requestor2Department = requester2Department;
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

    if (receiverEmailUser != null) {
      // Ensure employeeId is explicitly assigned to receiverEmployeeId
      state.model.receiverEmployeeId = receiverEmailUser.employeeId;

      // Log to verify the correct value is assigned
      log('--receiverEmployeeId-${state.model.receiverEmployeeId}-');

      // Format the name and email for receiverEmail
      String name = receiverEmailUser.name ?? '';
      String email = receiverEmailUser.email ?? '';
      state.model.receiverEmail = '$name ($email)';
      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
        ),
      );
    }

    if (receiverByEmail != null) {
      // Ensure employeeId is explicitly assigned to receiverEmployeeId
      state.model.otherReceiverEmployeeId = receiverByEmail.employeeId;

      // Log to verify the correct value is assigned
      log('--receiverEmployeeId-${state.model.receiverEmployeeId}-');

      // Format the name and email for receiverEmail
      String name = receiverByEmail.name ?? '';
      String email = receiverByEmail.email ?? '';
      state.model.otherReceiverName = '$name ($email)';
      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
        ),
      );
    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  Future<void> updateApproverEmailsValue({
    BaseUser? requesterEmailUser,
    BaseUser? requester2EmailUser,
    BaseUser? approver1EmailUser,
    BaseUser? approver2EmailUser,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (requesterEmailUser != null) {
      // if (state.model.requestorEmail != null) {
      //   BaseUser preSelectedUser = BaseUser(
      //     name: state.model.requestorEmail,
      //     // email:state.model.requestorEmail,
      //   );
      //   state.approver1Users?.add(preSelectedUser);
      // }
      state.model.requestorEmployeeId = requesterEmailUser.employeeId;

      // Log to verify the correct value is assigned
      log('--receiverEmployeeId-${state.model.receiverEmployeeId}-');

      // Format the name and email for receiverEmail
      String name = requesterEmailUser.name ?? '';
      String email = requesterEmailUser.email ?? '';
      state.model.requestorEmail = '$name ($email)';
      // state.model.requestorEmail =
      //     '${requesterEmailUser.name} ${requesterEmailUser.email != null ? '(${requesterEmailUser.email})' : ''}';
      // state.approver1Users?.remove(requesterEmailUser);
      // state.approver2Users?.remove(requesterEmailUser);
      emit(
        state.copyWith(
          model: state.model,
          // approver2Users: state.approver2Users,
          // approver1Users: state.approver1Users,
          status: FormStatus.initial,
        ),
      );
    }
    if (requester2EmailUser != null) {
      // if (state.model.requestorEmail != null) {
      //   BaseUser preSelectedUser = BaseUser(
      //     name: state.model.requestorEmail,
      //     // email:state.model.requestorEmail,
      //   );
      //   state.approver1Users?.add(preSelectedUser);
      // }
      state.model.requestor2EmployeeId = requester2EmailUser.employeeId;

      // Log to verify the correct value is assigned
      // Format the name and email for receiverEmail
      String name = requester2EmailUser.name ?? '';
      String email = requester2EmailUser.email ?? '';
      state.model.requestor2Email = '$name ($email)';
      // state.model.requestorEmail =
      //     '${requesterEmailUser.name} ${requesterEmailUser.email != null ? '(${requesterEmailUser.email})' : ''}';
      // state.approver1Users?.remove(requesterEmailUser);
      // state.approver2Users?.remove(requesterEmailUser);
      emit(
        state.copyWith(
          model: state.model,
          // approver2Users: state.approver2Users,
          // approver1Users: state.approver1Users,
          status: FormStatus.initial,
        ),
      );
    }

    if (approver1EmailUser != null) {
      if (state.model.approver1Email != null) {
        // BaseUser preSelectedUser = BaseUser(
        //   name: state.model.approver1Email,
        //   // email: state.model.approver1Email,
        // );
        // state.approver2Users?.add(preSelectedUser);
      }
      state.model.approver1Email =
          '${approver1EmailUser.name} ${approver1EmailUser.email != null ? '(${approver1EmailUser.email})' : ''}';
      // state.approver2Users?.remove(approver1EmailUser);
      // state.requestorEmailUsers?.remove(approver1EmailUser);

      emit(
        state.copyWith(
          model: state.model,
          // requestorEmailUsers: state.requestorEmailUsers,
          // approver2Users: state.approver2Users,
          status: FormStatus.initial,
        ),
      );
    }

    if (approver2EmailUser != null) {
      if (state.model.approver2Email != null) {
        // BaseUser preSelectedUser = BaseUser(
        //   name: state.model.approver2Email,
        //   // email:state.model.approver2Email,
        // );
        // state.approver1Users?.add(preSelectedUser);
      }
      state.model.approver2Email =
          '${approver2EmailUser.name} ${approver2EmailUser.email != null ? '(${approver2EmailUser.email})' : ''}';
      // state.approver1Users?.remove(approver2EmailUser);
      // state.requestorEmailUsers?.remove(approver2EmailUser);

      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
          // requestorEmailUsers: state.requestorEmailUsers,
          // approver1Users: state.approver1Users,
        ),
      );
    }
  }

  void addAttachment(List<ImageContent>? data) async {
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

  // Future<void> submitForm({
  //   bool isSaveOnly = false,
  //   bool isRejectOnly = false,
  //   bool isApprovedOnly = false,
  //   required SignatureController receiverSignatureController,
  //   required SignatureController securitySignatureController,
  // }) async {
  //   emit(
  //     state.copyWith(
  //       status: FormStatus.loading,
  //     ),
  //   );
  //
  //   // DateTime dateTime =
  //   //     DateFormat("dd/MM/yyyy a HH:mm:ss").parse(state.model.inputDate!);
  //   // int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  //   // state.model.inputDate = inputDate.toString();
  //
  //   // Setting time in milliseconds
  //   DateTime dateTime;
  //   if (!Utils().isTimestamp(state.model.inputDate!)) {
  //     dateTime =
  //         DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
  //     int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  //     state.model.inputDate = inputDate.toString();
  //   }
  //
  //   if(state.model.approvedDate !=null) {
  //     if (!Utils().isTimestamp(state.model.approvedDate!)) {
  //       dateTime =
  //           DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.approvedDate!);
  //       int inputDate = dateTime
  //           .toUtc()
  //           .millisecondsSinceEpoch ~/ 1000;
  //       state.model.approvedDate = inputDate.toString();
  //     }
  //   }
  //
  //   state.model.modifiedDate = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
  //
  //   // if (!Utils().isTimestamp(state.model.approvedDate!)) {
  //   //   dateTime =
  //   //       DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.approvedDate!);
  //   //   int approvedDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  //   //   state.model.approvedDate = approvedDate.toString();
  //   // }
  //
  //   // if(state.model.approvedDate !=null) {
  //   //   DateTime date =
  //   //   DateFormat("dd/MM/yyyy a HH:mm:ss").parse(state.model.approvedDate!);
  //   //   int approvedDate = date
  //   //       .toUtc()
  //   //       .millisecondsSinceEpoch ~/ 1000;
  //   //   state.model.approvedDate = approvedDate.toString();
  //   // }
  //
  //   state.model.rejectedDate = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
  //
  //   /// Adding Signature to request Body
  //   await pushSignature(
  //     controller: receiverSignatureController,
  //     isReceiverSignature: true,
  //   );
  //   await pushSignature(
  //     controller: securitySignatureController,
  //     isReceiverSignature: false,
  //   );
  //
  //   // Create/Update API Call
  //   MaterialMovementRequest request =
  //   MaterialMovementRequest(materialMovement: state.model);
  //
  //   // TODO: Need to change from Backend- Status should be handled from backend
  //   state.model.status ??= 0;
  //   try {
  //     GenericResponse response = GenericResponse();
  //     if (isSaveOnly) {
  //       //Validating Fields
  //       if (!state.isValidDraft.status) {
  //         state.model.inputDate = state.model.inputDate == null
  //             ? Utils().getCurrentDate()
  //             : Utils.timestampToDateConversion(
  //             int.tryParse(state.model.inputDate ?? '0'),
  //             Constants.fulldateFormat);
  //         state.model.modifiedDate = state.model.modifiedDate == null
  //             ? Utils().getCurrentDate()
  //             : Utils.timestampToDateConversion(
  //             int.tryParse(state.model.modifiedDate ?? '0'),
  //             Constants.fulldateFormat);
  //         emit(
  //           state.copyWith(
  //             status: FormStatus.formError,
  //             message: state.isValidDraft.message,
  //           ),
  //         );
  //         return;
  //       }
  //       response = await materialMovementServices.createMaterialMovement(
  //           body: request, flow: 1);
  //     }
  //     if (!isSaveOnly && !isRejectOnly && !isApprovedOnly) {
  //       //Validating Fields
  //       if (!state.isValid.status) {
  //         state.model.inputDate = state.model.inputDate == null
  //             ? Utils().getCurrentDate()
  //             : Utils.timestampToDateConversion(
  //             int.tryParse(state.model.inputDate ?? '0'),
  //             Constants.fulldateFormat);
  //         state.model.modifiedDate = state.model.modifiedDate == null
  //             ? Utils().getCurrentDate()
  //             : Utils.timestampToDateConversion(
  //             int.tryParse(state.model.modifiedDate ?? '0'),
  //             Constants.fulldateFormat);
  //         emit(
  //           state.copyWith(
  //             status: FormStatus.formError,
  //             message: state.isValid.message,
  //           ),
  //         );
  //         return;
  //       }
  //       int flow = 2;
  //       response = await materialMovementServices.createMaterialMovement(
  //           body: request, flow: flow);
  //     }
  //
  //     if (isRejectOnly) {
  //       //Validating Fields
  //       if (!state.isValidDraft.status) {
  //         state.model.inputDate = state.model.inputDate == null
  //             ? Utils().getCurrentDate()
  //             : Utils.timestampToDateConversion(
  //             int.tryParse(state.model.inputDate ?? '0'),
  //             Constants.fulldateFormat);
  //         state.model.modifiedDate = state.model.modifiedDate == null
  //             ? Utils().getCurrentDate()
  //             : Utils.timestampToDateConversion(
  //             int.tryParse(state.model.modifiedDate ?? '0'),
  //             Constants.fulldateFormat);
  //         emit(
  //           state.copyWith(
  //             status: FormStatus.formError,
  //             message: state.isValidDraft.message,
  //           ),
  //         );
  //         return;
  //       }
  //       response = await materialMovementServices.createMaterialMovement(
  //           body: request, flow: 4);
  //     }
  //     if (isApprovedOnly) {
  //       //Validating Fields
  //       if (!state.isValid.status) {
  //         state.model.inputDate = state.model.inputDate == null
  //             ? Utils().getCurrentDate()
  //             : Utils.timestampToDateConversion(
  //             int.tryParse(state.model.inputDate ?? '0'),
  //             Constants.fulldateFormat);
  //         state.model.modifiedDate = state.model.modifiedDate == null
  //             ? Utils().getCurrentDate()
  //             : Utils.timestampToDateConversion(
  //             int.tryParse(state.model.modifiedDate ?? '0'),
  //             Constants.fulldateFormat);
  //         emit(
  //           state.copyWith(
  //             status: FormStatus.formError,
  //             message: state.isValid.message,
  //           ),
  //         );
  //         return;
  //       }
  //       response = await materialMovementServices.createMaterialMovement(
  //           body: request, flow: 3);
  //     }
  //
  //     log('---response--msg--${response.message}---');
  //
  //     emit(
  //       state.copyWith(
  //         message: response.message,
  //         status: FormStatus.success,
  //       ),
  //     );
  //     state.model.inputDate = state.model.inputDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(state.model.inputDate ?? '0'),
  //         Constants.fulldateFormat);
  //     state.model.modifiedDate = state.model.modifiedDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(state.model.modifiedDate ?? '0'),
  //         Constants.fulldateFormat);
  //     state.model.approvedDate = state.model.approvedDate != null
  //         ? Utils.timestampToDateConversion(
  //         int.tryParse(state.model.approvedDate ?? '0'),
  //         Constants.fulldateFormat) : null ;
  //   } on GenericResponse catch (e) {
  //     Utils().emitErrorState(e, emit, state);
  //     state.model.inputDate = state.model.inputDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(state.model.inputDate ?? '0'),
  //         Constants.fulldateFormat);
  //     state.model.modifiedDate = state.model.modifiedDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(state.model.modifiedDate ?? '0'),
  //         Constants.fulldateFormat);
  //     state.model.approvedDate = state.model.approvedDate != null
  //         ? Utils.timestampToDateConversion(
  //         int.tryParse(state.model.approvedDate ?? '0'),
  //         Constants.fulldateFormat) : null;
  //     return;
  //   } on Exception catch (e) {
  //     state.model.inputDate = state.model.inputDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(state.model.inputDate ?? '0'),
  //         Constants.fulldateFormat);
  //     state.model.modifiedDate = state.model.modifiedDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(state.model.modifiedDate ?? '0'),
  //         Constants.fulldateFormat);
  //     state.model.approvedDate = state.model.approvedDate != null
  //         ? Utils.timestampToDateConversion(
  //         int.tryParse(state.model.approvedDate ?? '0'),
  //         Constants.fulldateFormat) : null;
  //     emit(
  //       state.copyWith(
  //         message: e.toString(),
  //         status: FormStatus.error,
  //       ),
  //     );
  //   }
  // }

  // Future<bool> submitForm({
  //   bool isSaveOnly = false,
  //   bool isRejectOnly = false,
  //   bool isApprovedOnly = false,
  //   bool navigateToNextScreen = false,
  //   required SignatureController receiverSignatureController,
  //   required SignatureController securitySignatureController,
  // }) async {
  //   emit(state.copyWith(status: FormStatus.loading));
  //   GenericResponse response = GenericResponse();
  //
  //   try {
  //     // DateTime dateTime =
  //     //     DateFormat("dd/MM/yyyy a HH:mm:ss").parse(state.model.inputDate!);
  //     // int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  //     // state.model.inputDate = inputDate.toString();
  //
  //     // DateTime dateTime;
  //     // if (!Utils().isTimestamp(state.model.inputDate!)) {
  //     //   dateTime =
  //     //       DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
  //     //   int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  //     //   state.model.inputDate = inputDate.toString();
  //     // }
  //     DateTime dateTime;
  //     if (!Utils().isTimestamp(state.model.inputDate!)) {
  //       dateTime =
  //           DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
  //       int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  //       state.model.inputDate = inputDate.toString();
  //     }
  //
  //     if (state.model.approvedDate != null) {
  //       if (!Utils().isTimestamp(state.model.approvedDate!)) {
  //         dateTime = DateFormat("dd/MM/yyyy HH:mm:ss")
  //             .parse(state.model.approvedDate!);
  //         int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  //         state.model.approvedDate = inputDate.toString();
  //       }
  //     }
  //
  //     state.model.modifiedDate =
  //         (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
  //
  //     // if (!Utils().isTimestamp(state.model.approvedDate!)) {
  //     //   dateTime =
  //     //       DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.approvedDate!);
  //     //   int approvedDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  //     //   state.model.approvedDate = approvedDate.toString();
  //     // }
  //
  //     // if(state.model.approvedDate !=null) {
  //     //   DateTime date =
  //     //   DateFormat("dd/MM/yyyy a HH:mm:ss").parse(state.model.approvedDate!);
  //     //   int approvedDate = date
  //     //       .toUtc()
  //     //       .millisecondsSinceEpoch ~/ 1000;
  //     //   state.model.approvedDate = approvedDate.toString();
  //     // }
  //
  //     // ---------- Helper function to convert date string to timestamp ----------
  //     // String convertToTimestamp(String? dateString) {
  //     //   if (dateString == null || Utils().isTimestamp(dateString)) return dateString ?? '';
  //     //   DateTime dateTime = DateFormat("dd/MM/yyyy HH:mm:ss").parse(dateString);
  //     //   return (dateTime.toUtc().millisecondsSinceEpoch ~/ 1000).toString();
  //     // }
  //     //
  //     // // ---------- Update all relevant dates ----------
  //     // state.model.inputDate = convertToTimestamp(state.model.inputDate);
  //     // state.model.modifiedDate = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
  //     // state.model.approvedDate = convertToTimestamp(state.model.approvedDate);
  //     // state.model.rejectedDate = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
  //
  //     // ---------- Push signatures ----------
  //     await pushSignature(
  //         controller: receiverSignatureController, isReceiverSignature: true);
  //     await pushSignature(
  //         controller: securitySignatureController, isReceiverSignature: false);
  //
  //     // ---------- Create request ----------
  //     MaterialMovementRequest request =
  //         MaterialMovementRequest(materialMovement: state.model);
  //
  //     // ---------- Default status ----------
  //     state.model.status ??= 0;
  //
  //     GenericResponse response;
  //
  //     // ---------- Validate and call API based on flow ----------
  //     if (isSaveOnly) {
  //       if (!state.isValidDraft.status) {
  //         emit(state.copyWith(
  //             status: FormStatus.formError,
  //             message: state.isValidDraft.message));
  //         return false;
  //       }
  //       response = await materialMovementServices.createMaterialMovement(
  //           body: request, flow: 1);
  //     } else if (isRejectOnly) {
  //       // state.model.inputDate = state.model.inputDate == null
  //       //     ? Utils().getCurrentDate()
  //       //     : Utils.timestampToDateConversion(
  //       //         int.tryParse(state.model.inputDate ?? '0'),
  //       //         Constants.fulldateFormat);
  //       // state.model.modifiedDate = Utils.timestampToDateConversion(
  //       //     int.tryParse(state.model.modifiedDate ?? '0'),
  //       //     Constants.fulldateFormat);
  //       if (!state.isValidDraft.status) {
  //         emit(state.copyWith(
  //             status: FormStatus.formError,
  //             message: state.isValidDraft.message));
  //         // state.model.inputDate = state.model.inputDate == null
  //         //     ? Utils().getCurrentDate()
  //         //     : Utils.timestampToDateConversion(
  //         //     int.tryParse(state.model.inputDate?? '0'),
  //         //     Constants.fulldateFormat);
  //         return false;
  //       }
  //       response = await materialMovementServices.createMaterialMovement(
  //           body: request, flow: 4);
  //     } else if (isApprovedOnly) {
  //       // state.model.inputDate = state.model.inputDate == null
  //       //     ? Utils().getCurrentDate()
  //       //     : Utils.timestampToDateConversion(
  //       //         int.tryParse(state.model.inputDate ?? '0'),
  //       //         Constants.fulldateFormat);
  //       // state.model.modifiedDate = Utils.timestampToDateConversion(
  //       //     int.tryParse(state.model.modifiedDate ?? '0'),
  //       //     Constants.fulldateFormat);
  //       if (!state.isValid.status) {
  //         emit(state.copyWith(
  //             status: FormStatus.formError, message: state.isValid.message));
  //         return false;
  //       }
  //       response = await materialMovementServices.createMaterialMovement(
  //           body: request, flow: 3);
  //     } else {
  //       // state.model.inputDate = state.model.inputDate == null
  //       //     ? Utils().getCurrentDate()
  //       //     : Utils.timestampToDateConversion(
  //       //         int.tryParse(state.model.inputDate ?? '0'),
  //       //         Constants.fulldateFormat);
  //       // state.model.modifiedDate = Utils.timestampToDateConversion(
  //       //     int.tryParse(state.model.modifiedDate ?? '0'),
  //       //     Constants.fulldateFormat);
  //       if (!state.isValid.status) {
  //         // state.model.inputDate = state.model.inputDate == null
  //         //     ? Utils().getCurrentDate()
  //         //     : Utils.timestampToDateConversion(
  //         //         int.tryParse(state.model.inputDate ?? '0'),
  //         //         Constants.fulldateFormat);
  //         // state.model.modifiedDate = Utils.timestampToDateConversion(
  //         //     int.tryParse(state.model.modifiedDate ?? '0'),
  //         //     Constants.fulldateFormat);
  //         emit(state.copyWith(
  //             status: FormStatus.formError, message: state.isValid.message));
  //         return false;
  //       }
  //       // state.model.inputDate = state.model.inputDate == null
  //       //     ? Utils().getCurrentDate()
  //       //     : Utils.timestampToDateConversion(
  //       //         int.tryParse(state.model.inputDate ?? '0'),
  //       //         Constants.fulldateFormat);
  //       // state.model.modifiedDate = Utils.timestampToDateConversion(
  //       //     int.tryParse(state.model.modifiedDate ?? '0'),
  //       //     Constants.fulldateFormat);
  //       response = await materialMovementServices.createMaterialMovement(
  //           body: request, flow: 2);
  //     }
  //
  //     // ---------- Update model id if returned ----------
  //     if (response.id != null) {
  //       int? id = int.tryParse(response.id!);
  //       if (id != null) state.model.id = id;
  //     }
  //
  //     // ---------- Convert timestamps back to readable dates ----------
  //     // state.model.inputDate = Utils.timestampToDateConversion(
  //     //     int.tryParse(state.model.inputDate ?? '0'), Constants.fulldateFormat);
  //     // state.model.modifiedDate = Utils.timestampToDateConversion(
  //     //     int.tryParse(state.model.modifiedDate ?? '0'), Constants.fulldateFormat);
  //     // if (state.model.approvedDate != null) {
  //     //   state.model.approvedDate = Utils.timestampToDateConversion(
  //     //       int.tryParse(state.model.approvedDate ?? '0'), Constants.fulldateFormat);
  //     // }
  //     state.model.modifiedDate = Utils.timestampToDateConversion(
  //         int.tryParse(state.model.modifiedDate ?? '0'),
  //         Constants.fulldateFormat);
  //     state.model.inputDate = state.model.inputDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //             int.tryParse(state.model.inputDate ?? '0'),
  //             Constants.fulldateFormat);
  //     // ---------- Emit success ----------
  //     // emit(state.copyWith(
  //     //   model: state.model,
  //     //   message: response.message,
  //     //   status: navigateToNextScreen
  //     //       ? FormStatus.navigateToNextScreen
  //     //       : FormStatus.success,
  //     // ));
  //
  //     return true; //  success
  //   } on GenericResponse catch (e) {
  //     Utils().emitErrorState(e, emit, state);
  //     state.model.inputDate = state.model.inputDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(state.model.inputDate ?? '0'),
  //         Constants.fulldateFormat);
  //     return true;
  //   } on Exception catch (e) {
  //     emit(
  //       state.copyWith(
  //         message: e.toString(),
  //         status: FormStatus.error,
  //       ),
  //     );
  //   }
  //   emit(
  //     state.copyWith(
  //       message:response.Message,
  //       status: FormStatus.success,
  //     ),
  //   );
  // }

  Future<bool> submitForm({
    bool isSaveOnly = false,
    bool isRejectOnly = false,
    bool isApprovedOnly = false,
    bool navigateToNextScreen = false,
    required SignatureController receiverSignatureController,
    required SignatureController securitySignatureController,
  }) async {
    emit(state.copyWith(status: FormStatus.loading));

    try {
      DateTime dateTime;
      if (!Utils().isTimestamp(state.model.inputDate!)) {
        dateTime = DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
        int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
        state.model.inputDate = inputDate.toString();
      }

      if (state.model.approvedDate != null) {
        if (!Utils().isTimestamp(state.model.approvedDate!)) {
          dateTime = DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.approvedDate!);
          int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
          state.model.approvedDate = inputDate.toString();
        }
      }

      state.model.modifiedDate = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

      await pushSignature(controller: receiverSignatureController, isReceiverSignature: true);
      await pushSignature(controller: securitySignatureController, isReceiverSignature: false);

      MaterialMovementRequest request = MaterialMovementRequest(materialMovement: state.model);
      state.model.status ??= 0;

      //  Single declaration here
      GenericResponse response;

      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          emit(state.copyWith(status: FormStatus.formError, message: state.isValidDraft.message));
          return false;
        }
        response = await materialMovementServices.createMaterialMovement(body: request, flow: 1);
      } else if (isRejectOnly) {
        if (!state.isValidDraft.status) {
          emit(state.copyWith(status: FormStatus.formError, message: state.isValidDraft.message));
          return false;
        }
        response = await materialMovementServices.createMaterialMovement(body: request, flow: 4);
      } else if (isApprovedOnly) {
        if (!state.isValid.status) {
          emit(state.copyWith(status: FormStatus.formError, message: state.isValid.message));
          return false;
        }
        response = await materialMovementServices.createMaterialMovement(body: request, flow: 3);
      } else {
        if (!state.isValid.status) {
          emit(state.copyWith(status: FormStatus.formError, message: state.isValid.message));
          return false;
        }
        response = await materialMovementServices.createMaterialMovement(body: request, flow: 2);
      }

      if (response.id != null) {
        int? id = int.tryParse(response.id!);
        if (id != null) state.model.id = id;
      }

      state.model.modifiedDate = Utils.timestampToDateConversion(
          int.tryParse(state.model.modifiedDate ?? '0'), Constants.fulldateFormat);
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'), Constants.fulldateFormat);

      //  Emit is now inside try block where response is in scope
      emit(state.copyWith(
        message: response.message, //  use correct casing
        status: navigateToNextScreen ? FormStatus.navigateToNextScreen : FormStatus.success,
      ));

      return true;

    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'), Constants.fulldateFormat);
      return false; //  return false on error, not true
    } on Exception catch (e) {
      emit(state.copyWith(
        message: e.toString(),
        status: FormStatus.error,
      ));
      return false; // explicit return
    }
  }
  Future<void> updateStatus({required String id}) async {
    await commonServices.updateRecordStatus(
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

  // void addMaterialItem() {
  //   final updatedList = List<MaterialItem>.from(state.materialItems);
  //   updatedList.add(MaterialItem());
  //
  //   emit(state.copyWith(materialItems: updatedList));
  // }
  void addMaterialItem() {
    final updatedList = List<MaterialItem>.from(state.materialItems);
    updatedList.add(MaterialItem());

    emit(state.copyWith(materialItems: updatedList));
  }

  void removeMaterialItem(int index) {
    materialItems.removeAt(index);
    emit(state.copyWith(materialItems: materialItems));
  }

// void saveMaterial() {
//   final updatedList = List.of(state.materialList)
//     ..add(state.model);
//
//   emit(state.copyWith(materialList: updatedList));
// }
}
