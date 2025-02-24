import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/day_passmangement/services/day_pass_management_services.dart';
import 'package:intl/intl.dart';

import '../../models/day_pass_management_model.dart';
import '../../models/requestModels/day_pass_management_request.dart';

part 'day_passmanagement_details_state.dart';

class DayPassManagementDetailsCubit extends Cubit<DayPassManagementDetailsState> {
  final DayPassManagementServices dayPassManagementServices;
  final DayPassManagementModel? model;
  final CommonServices commonServices;

  DayPassManagementDetailsCubit({
    required this.dayPassManagementServices,
    required this.commonServices,
    this.model,

  }) : super(
    DayPassManagementDetailsState.initial(
      model: model ?? DayPassManagementModel(),
      locations: Locations(),
      users: const [],
      emailUsers: const [],
      errorMessage: '',
      departments: const [],
      loadAttachments: const [],
      quantityUnits: const [],
      eventId: null, listOfEntities: const [], getCompanyTypeResponse: const [],
    ),
  );

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));

    List<Organisation>? entities =
    await commonServices.getOrganisations(name: 'ATOM_ENTITIES');
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
        // getEntitiesResponse: entities,
        listOfEntities: entities,
        emailUsers: emailUsers,
        departments: departments.employeeDepartments,
        receiverEmailUsers: onlyDBUsers,
        requestorEmailUsers: onlyDBUsers,
        approver1Users: onlyDBUsers,
        approver2Users: onlyDBUsers,
      ),
    );
  }

  void onModelValueChange(DayPassManagementModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<void> isFormReadable() async {

    if (state.model.status != ConstantsIntValue.businessUserReview) {
      emit(state.copyWith(
        status: FormStatus.initial,
      ));
      return;
    }

    emit(state.copyWith(model: model, status: FormStatus.loading));
    bool isReadOnly;

    // if (state.model.requestorEmail
    //     .equalsIgnoreCase(state.loggedInUserDetails?.userName)) {
    //   isReadOnly = false;
    // } else {
    //   isReadOnly = true;
    // }

    emit(state.copyWith(
      model: model,
      // isReadOnly: isReadOnly,
      status: FormStatus.initial,
    ));
  }

  Future<void> initializeValues() async {

    // Show Loader and emit loading state
    emit(
      state.copyWith(status: FormStatus.loading),
    );

    var userId = await SharedPrefs.getUserId();

    Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();

    if (state.model.location == null && defaultLocation != null) {
      String moduleCode = Constants.passManagementModule;
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
            moduleCode: Constants.passManagementModule),
        SharedPrefs.getDefaultLocation(),
        commonServices.getBaseUsers(
            roleName: ConstantUserRoles.atomStaticUser,
            isDbUser: true,
            locationId: state.model.location!.id!),
        commonServices.getEntities(name: 'ATOM_ENTITIES'),
      ]);

      Locations locations = futures[0];
      User loggedInUserDetails = futures[1];
      EmployeeDepartments departments = futures[2];
      dynamic responseLabels = futures[3];
      Organisation? defaultLocation = futures[4];
      List<BaseUser> emailUsers = futures[5];
      AddEntities entities = futures[6];


      log('--emailUsers--${emailUsers.length}---');
      // Get Date of Creation
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
     // fulldateFormat state.model.modifiedDate = state.model.modifiedDate == null
     //      ? Utils().getCurrentDate()
     //      : Utils.timestampToDateConversion(
     //      int.tryParse(state.model.modifiedDate ?? '0'),
     //      Constants.fulldateFormat);

      // if (state.model.inputDate != null) {
      //   Utils.timestampToDateConversion(
      //       int.tryParse(state.model?.inputDate ?? '0'),
      //       Constants.fulldateFormat);
      // } else {
      //   Utils().getCurrentDate();
      // }
      //
      // state.model.inwardMovement = isInward;
      // if (state.model.approvedDate != null) {
      //   state.model.approvedDate =
      //       Utils().formatUnixTimestamp(state.model.approvedDate ?? '');
      // }
      // if (state.model.rejectedDate != null) {
      //   state.model.rejectedDate =
      //       Utils().formatUnixTimestamp(state.model.rejectedDate ?? '');
      // }

      MmUiLabels labels = MmUiLabels.fromJson(responseLabels);

      log('--loggedInUserDetails---${loggedInUserDetails.firstName}----');

      state.model.entrySecurity ??= loggedInUserDetails;
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
          requestorEmailUsers: onlyDBUsers,
          approver1Users: onlyDBUsers,
          approver2Users: onlyDBUsers,
          receiverEmailUsers: onlyDBUsers,
          returnReceiverEmailId: onlyDBUsers,
          departments: departments.employeeDepartments,
          labels: labels,
          listOfEntities: entities.atomEntities,
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
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.passManagementModule,
      );
      state.model.location = location;
      state.model.slNo = slNo.serialNo;

      emailUsers = await commonServices.getBaseUsers(
          roleName: ConstantUserRoles.atomStaticUser,
          isDbUser: true,
          locationId: state.model.location!.id!);
    }
    // state.model.receiverEmail = null;
    // state.model.requestorEmail = null;
    // state.model.approver1Email = null;
    // state.model.approver2Email = null;

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
    List<Organisation>? entities,
    int? passType,
    Organisation? companyType,
    BaseUser? user,
    BaseUser? host,
    BaseUser? receiverEmailUser,
    BaseUser? receiverByEmail,
    Organisation? department,
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
    if (entities != null) {
      state.model.entities = entities;
    }
    // if (passType != null) {
    //   state.model.passInfo?.passType = passType;
    // }

    state.model.passType = passType ?? state.model.passType;

    if (companyType != null) {
      state.model.companyType = companyType;
    }

    if (host != null) {
      // Ensure employeeId is explicitly assigned to receiverEmployeeId
      state.model.employeeID = host.employeeId;

      // Log to verify the correct value is assigned
      log('--receiverEmployeeId-${state.model.employeeID}-');

      // Format the name and email for receiverEmail
      String name = host.name ?? '';
      String email = host.email ?? '';
      User userDetails = User(
        name:name,
        userId: host.id,
        email: email,
      );
      state.model.host = userDetails;
      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
        ),
      );
    }
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

    // if (returnReceiverMailId != null) {
    //   state.model.returnReceiverMailId =
    //   '${returnReceiverMailId.name} (${returnReceiverMailId.email})';
    // }
    // if (requesterDepartment != null) {
    //   state.model.requestorDepartment = requesterDepartment;
    // }
    // if (preparedByDepartment != null) {
    //   state.model.preparedByDepartment = preparedByDepartment;
    // }
    if (department != null) {
      // state.model.department = department;
    }
    //
    // if (approver2Department != null) {
    //   state.model.approver2Department = approver2Department;
    // }
    // if (receiverDepartment != null) {
    //   state.model.receiverDepartment = receiverDepartment;
    // }
    // if (quantityUnit != null) {
    //   state.model.unit = quantityUnit;
    // }

    // if (isReturnable != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: state.model.location!.id.toString(),
          moduleCode: Constants.passManagementModuleCode);
      state.model.slNo = slNo.serialNo;
      // state.model.returnable = isReturnable;
    // }

    // if (receiverEmailUser != null) {
    //   // Ensure employeeId is explicitly assigned to receiverEmployeeId
    //   state.model.receiverEmployeeId = receiverEmailUser.employeeId;
    //
    //   // Log to verify the correct value is assigned
    //   log('--receiverEmployeeId-${state.model.receiverEmployeeId}-');
    //
    //   // Format the name and email for receiverEmail
    //   String name = receiverEmailUser.name ?? '';
    //   String email = receiverEmailUser.email ?? '';
    //   state.model.receiverEmail = '$name ($email)';
    //   emit(
    //     state.copyWith(
    //       model: state.model,
    //       status: FormStatus.initial,
    //     ),
    //   );
    // }
    //
    // if (receiverByEmail != null) {
    //   // Ensure employeeId is explicitly assigned to receiverEmployeeId
    //   state.model.otherReceiverEmployeeId = receiverByEmail.employeeId;
    //
    //   // Log to verify the correct value is assigned
    //   log('--receiverEmployeeId-${state.model.receiverEmployeeId}-');
    //
    //   // Format the name and email for receiverEmail
    //   String name = receiverByEmail.name ?? '';
    //   String email = receiverByEmail.email ?? '';
    //   state.model.otherReceiverName = '$name ($email)';
    //   emit(
    //     state.copyWith(
    //       model: state.model,
    //       status: FormStatus.initial,
    //     ),
    //   );
    // }

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

    // if (requesterEmailUser != null) {
    //   // if (state.model.requestorEmail != null) {
    //   //   BaseUser preSelectedUser = BaseUser(
    //   //     name: state.model.requestorEmail,
    //   //     // email:state.model.requestorEmail,
    //   //   );
    //   //   state.approver1Users?.add(preSelectedUser);
    //   // }
    //   state.model.requestorEmployeeId = requesterEmailUser.employeeId;
    //
    //   // Log to verify the correct value is assigned
    //   log('--receiverEmployeeId-${state.model.receiverEmployeeId}-');
    //
    //   // Format the name and email for receiverEmail
    //   String name = requesterEmailUser.name ?? '';
    //   String email = requesterEmailUser.email ?? '';
    //   state.model.requestorEmail = '$name ($email)';
    //   // state.model.requestorEmail =
    //   //     '${requesterEmailUser.name} ${requesterEmailUser.email != null ? '(${requesterEmailUser.email})' : ''}';
    //   state.approver1Users?.remove(requesterEmailUser);
    //   state.approver2Users?.remove(requesterEmailUser);
    //   emit(
    //     state.copyWith(
    //       model: state.model,
    //       approver2Users: state.approver2Users,
    //       approver1Users: state.approver1Users,
    //       status: FormStatus.initial,
    //     ),
    //   );
    // }

    // if (approver1EmailUser != null) {
    //   if (state.model.approver1Email != null) {
    //     BaseUser preSelectedUser = BaseUser(
    //       name: state.model.approver1Email,
    //       // email: state.model.approver1Email,
    //     );
    //     state.approver2Users?.add(preSelectedUser);
    //   }
    //   state.model.approver1Email =
    //   '${approver1EmailUser.name} ${approver1EmailUser.email != null ? '(${approver1EmailUser.email})' : ''}';
    //   state.approver2Users?.remove(approver1EmailUser);
    //   state.requestorEmailUsers?.remove(approver1EmailUser);
    //
    //   emit(
    //     state.copyWith(
    //       model: state.model,
    //       requestorEmailUsers: state.requestorEmailUsers,
    //       approver2Users: state.approver2Users,
    //       status: FormStatus.initial,
    //     ),
    //   );
    // }

    // if (approver2EmailUser != null) {
    //   if (state.model.approver2Email != null) {
    //     BaseUser preSelectedUser = BaseUser(
    //       name: state.model.approver2Email,
    //       // email:state.model.approver2Email,
    //     );
    //     state.approver1Users?.add(preSelectedUser);
    //   }
    //   state.model.approver2Email =
    //   '${approver2EmailUser.name} ${approver2EmailUser.email != null ? '(${approver2EmailUser.email})' : ''}';
    //   state.approver1Users?.remove(approver2EmailUser);
    //   state.requestorEmailUsers?.remove(approver2EmailUser);
    //
    //   emit(
    //     state.copyWith(
    //       model: state.model,
    //       status: FormStatus.initial,
    //       requestorEmailUsers: state.requestorEmailUsers,
    //       approver1Users: state.approver1Users,
    //     ),
    //   );
    // }
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

      // state.model.images = data;
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

    // if (isOriginalReceiverReceiving != null) {
    //   state.model.originalReceiver = isOriginalReceiverReceiving;
    // }
    // if (isMaterialPhysicallyChecked != null) {
    //   state.model.materialPhysicallyChecked = isMaterialPhysicallyChecked;
    // }
    // final updatedMaterialMovement = materialMovement.copyWith(state.materialMovement.originalReceiver: isOriginalReceiverReceiving);

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }


  Future<void> submitForm({
    bool isSaveOnly = false,
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
    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.inputDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.inputDate = inputDate.toString();
    }

    // if (!Utils().isTimestamp(state.model.approvedDate!)) {
    //   dateTime =
    //       DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.approvedDate!);
    //   int approvedDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
    //   state.model.approvedDate = approvedDate.toString();
    // }

    // if(state.model.approvedDate !=null) {
    //   DateTime date =
    //   DateFormat("dd/MM/yyyy a HH:mm:ss").parse(state.model.approvedDate!);
    //   int approvedDate = date
    //       .toUtc()
    //       .millisecondsSinceEpoch ~/ 1000;
    //   state.model.approvedDate = approvedDate.toString();
    // }
    // if(state.model.rejectedDate !=null) {
    //   DateTime date =
    //   DateFormat("dd/MM/yyyy a HH:mm:ss").parse(state.model.rejectedDate!);
    //   int rejectedDate = date
    //       .toUtc()
    //       .millisecondsSinceEpoch ~/ 1000;
    //   state.model.rejectedDate = rejectedDate.toString();
    // }


    // Create/Update API Call
    DayPassManagementRequest request =
    DayPassManagementRequest(passManagement: state.model);

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
          return;
        }
        response = await dayPassManagementServices.createPass(
            requestBody: request, isSubmit: false);
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
    }
  }

  Future<void> updateStatus({required String id}) async {
    await commonServices.updateRecordStatus(
        id: id, module: Constants.materialMovementModuleCode);
  }
}
