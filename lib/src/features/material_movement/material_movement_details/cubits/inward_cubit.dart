import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/material_movement/material_movements/models/material_movements_model.dart';
import 'package:db_atom/src/features/material_movement/material_movements/models/requestModels/material_movement_request.dart';
import 'package:db_atom/src/features/material_movement/material_movements/models/responseModels/material_movement_response.dart';
import 'package:db_atom/src/features/material_movement/services/material_movement_services.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../constants/constants.dart';
import '../../../passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';

part 'inward_state.dart';

class InwardCubit extends Cubit<InwardState> {
  final MaterialMovementServices materialMovementServices;
  final MaterialMovementModel? model;
  final CommonServices commonServices;

  InwardCubit(
      {required this.materialMovementServices,
      required this.commonServices,
      required this.model})
      : super(
          InwardState.initial(
            model: model ?? MaterialMovementModel(),
            locations: GetLocations(),
            loggedInUserDetails: GetUserDetails(),
            atomStaticUser: const [],
            errorMessage: '',
            departments: const [],
            loadAttachments: const [],
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

      // TODO: Generate sl No for creating Inward Movement , Need to call the API : 'getSerialnumberDetails'
      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          materialMovement: state.materialMovement,
          users: users.t1Analyst,
          departments: departments.employeeDepartments,
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

  Future<void> updateDropdownValues(
      {Location? location,
      T1Analyst? user,
      EmployeeDepartment? department}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    log('---status-----${state.status}---');
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

    if (department != null) {
      state.materialMovement.receiverDepartmenttName = department.name;
    }

    log('----state.materialMovement.otherReceiverName-----${state.materialMovement.otherReceiverName}---');

    emit(state.copyWith(
      materialMovement: state.materialMovement,
      status: FormStatus.initial,
    ));
    log('---status-----${state.status}---');
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
  void showFields({required bool isOriginalReceiverReceiving, required MaterialMovementModel materialMovement}) {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    state.materialMovement.originalReceiver= isOriginalReceiverReceiving;
    // final updatedMaterialMovement = materialMovement.copyWith(state.materialMovement.originalReceiver: isOriginalReceiverReceiving);

    emit(state.copyWith(
      materialMovement: state.materialMovement,
      status: FormStatus.initial,
    ));
  }


  Future<void> submitForm() async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    // TODO: Need to change inward type from String to int
    // For Inward the type value should be 1

    // TODO: Validating Fields

    if (!state.isValid.status) {
      emit(
        state.copyWith(
          status: FormStatus.error,
          message: state.isValid.message,
        ),
      );
    }

    // Create/Update API Call
    MaterialMovementRequest request =
        MaterialMovementRequest(materialMovement: state.materialMovement);
    try {
      MaterialMovementResponse response =
          await materialMovementServices.createMaterialMovement(request);
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
