import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/material_movement/material_movements/models/material_movements_model.dart';
import 'package:db_atom/src/features/material_movement/material_movements/models/requestModels/material_movement_request.dart';
import 'package:db_atom/src/features/material_movement/material_movements/models/responseModels/material_movement_response.dart';
import 'package:db_atom/src/features/material_movement/services/material_movement_services.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

import '../../../../constants/constants.dart';

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
              errorMessage: ''),
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
          await commonServices.getLocations(locationName: 'ATOM_LOCATIONS');

      GetUserDetails loggedInUserDetails =
          await commonServices.getUserDetails(userId: userId);

      // Get Date of Creation
      state.materialMovement.inputDate = _getCurrentDate();

      // TODO: Generate sl No for creating Inward Movement , Need to call the API : 'getSerialnumberDetails'
      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          materialMovement: state.materialMovement,
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

  Future<void> submitForm() async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    // TODO: Need to change inward type from String to int
    // For Inward the type value should be 1


    // TODO: Validating Fields


    // Create/Update API Call
    MaterialMovementRequest request = MaterialMovementRequest(materialMovement: state.materialMovement);
    try {
      MaterialMovementResponse response = await materialMovementServices.createMaterialMovement(request);
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
          message: Constants.errorText,
          status: FormStatus.error,
        ),
      );

    }


  }
}
