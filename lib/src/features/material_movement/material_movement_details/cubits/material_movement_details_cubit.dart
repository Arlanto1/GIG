import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';
import 'package:db_atom/src/features/material_movement/models/quantity_units.dart';
import 'package:db_atom/src/features/material_movement/models/requestModels/material_movement_request.dart';
import 'package:db_atom/src/features/material_movement/models/responseModels/material_movement_response.dart';
import 'package:db_atom/src/features/material_movement/services/material_movement_services.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../constants/constants.dart';
import '../../../../models/base_user.dart';
import '../../../../models/department.dart';
import '../../../createfound/models/emplyee_departments_model.dart';
import '../../../passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';

part 'material_movement_details_state.dart';

class MaterialMovementDetailsCubit extends Cubit<MaterialMovementDetailsState> {
  final MaterialMovementServices materialMovementServices;
  final MaterialMovementModel? model;
  final CommonServices commonServices;
  final bool isInward;

  MaterialMovementDetailsCubit({
    required this.materialMovementServices,
    required this.commonServices,
    required this.model,
    required this.isInward,
  }) : super(
          MaterialMovementDetailsState.initial(
            model: model ?? MaterialMovementModel(),
            locations: GetLocations(),
            loggedInUserDetails: GetUserDetails(),
            users: const [],
            emailUsers: const[],
            errorMessage: '',
            departments: const [],
            loadAttachments: const [],
            quantityUnits: const [],
          ),
        );

  void onModelValueChange(MaterialMovementModel model) {
    emit(state.copyWith(materialMovement: model, status: FormStatus.initial));
  }

  String _getCurrentDate() {
    return DateFormat(Constants.fulldateFormat).format(DateTime.now());
  }

  Future<void> initializeValues() async {
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

      GetUserDetails loggedInUserDetails =
          await commonServices.getUserDetails(userId: userId);

      Analyst users =
          await commonServices.getUsersByRole(roleName: 'T1_Analyst');
      // Get Date of Creation
      state.materialMovement.inputDate = _getCurrentDate();

      EmployeeDepartments departments =
          await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');

      GetDepositor emailUsers =
      await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

      QuantityUnits quantityUnits = await commonServices.getQuantityUnits();

      emit(
        state.copyWith(
            locations: getLocationsData,
            loggedInUserDetails: loggedInUserDetails,
            status: FormStatus.initial,
            materialMovement: state.materialMovement,
            users: users.t1Analyst,
          emailUsers: emailUsers.atomStaticUser,
            departments: departments.employeeDepartments,
            quantityUnits: quantityUnits.units,
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
    Location? location,
    BaseUser? user,
    BaseUser? requesterEmailUser,
    BaseUser? approver1EmailUser,
    BaseUser? approver2EmailUser,
    Department? department,
    Department? preparedByDepartment,
    Department? approver1Department,
    Department? approver2Department,
    Department? receiverDepartment,
    bool? isReturnable,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    //Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.materialMovementInwardNonReturnableModule,
      );

      state.materialMovement.location = location;
      state.materialMovement.slNo = slNo.serialNo;
    }
    if (user != null) {
      state.materialMovement.otherReceiverName = user.name;
    }

    if (requesterEmailUser != null) {
      state.materialMovement.requestorEmail = requesterEmailUser.email;
    }
    if (approver1EmailUser != null) {
      state.materialMovement.approver1Email = approver1EmailUser.email;
    }
    if (approver2EmailUser != null) {
      state.materialMovement.approver2Email = approver2EmailUser.email;
    }

    if (department != null) {
      state.materialMovement.receiverDepartmenttName = department.name;
    }
    if (preparedByDepartment != null) {
      state.materialMovement.preparedByDepartment =
          preparedByDepartment;
    }
    if (approver1Department != null) {
      state.materialMovement.approver1Department =
          approver1Department;
    }

    if (approver2Department != null) {
      state.materialMovement.approver2Department =
          approver2Department;
    }
    if (receiverDepartment != null) {
      state.materialMovement.receiverDepartmenttName =
          receiverDepartment.name;
    }
    if (isReturnable != null) {
      state.materialMovement.returnable = isReturnable;
    }

    emit(state.copyWith(
      materialMovement: state.materialMovement,
      status: FormStatus.initial,
    ));
  }

  Future<void> addAttchment(List<CreateImage>? data) async {
    // int eventIds = Random.secure().nextInt(5);

    emit(state.copyWith(
        // eventId:eventIds ,
        loadAttachments: data,
        status: FormStatus.addAttachment));
  }

  // void showFields({required bool isOriginalReceiverReceiving}){
  //   emit(
  //     state.copyWith(
  //       status: FormStatus.loading,
  //     ),
  //   );
  //   log('-isOriginalReceiverReceiving---$isOriginalReceiverReceiving-----');
  //
  //   state.materialMovement.originalReceiver = isOriginalReceiverReceiving;
  //
  //   emit(state.copyWith(
  //     materialMovement: state.materialMovement,
  //     status: FormStatus.initial,
  //   ));
  // }
  void showFields(
      {bool? isOriginalReceiverReceiving, bool? isMaterialPhysicallyChecked}) {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (isOriginalReceiverReceiving != null) {
      state.materialMovement.originalReceiver = isOriginalReceiverReceiving;
    }
    if (isMaterialPhysicallyChecked != null) {
      state.materialMovement.materialPhysicallyChecked =
          isMaterialPhysicallyChecked;
    }
    // final updatedMaterialMovement = materialMovement.copyWith(state.materialMovement.originalReceiver: isOriginalReceiverReceiving);

    emit(state.copyWith(
      materialMovement: state.materialMovement,
      status: FormStatus.initial,
    ));
  }

  Future<void> submitForm({bool isSaveOnly = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    // TODO: Need to change inward type from String to int
    // For Inward the type value should be 1

    // Create/Update API Call
    MaterialMovementRequest request =
        MaterialMovementRequest(materialMovement: state.materialMovement);
    try {
      MaterialMovementResponse response = MaterialMovementResponse();
      if (isSaveOnly) {
        await materialMovementServices.createMaterialMovement(
            body: request, isSubmit: false);
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValid.message,
            ),
          );
        }
        response = await materialMovementServices.createMaterialMovement(
            body: request, isSubmit: true);
      }
      emit(
        state.copyWith(
          message: response.message,
          status: FormStatus.success,
        ),
      );

      // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //   Utils.dynamicAlert(
      //       context, lawcreateFoundresponse.message ?? '', title, '');
      // });
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }
  }
}
