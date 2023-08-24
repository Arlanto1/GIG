import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/request/gm_rate_request.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/services/guarding_services.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../../../constants/constants.dart';
import '../../../../../../models/department.dart';
import '../../../../../../models/entry_security.dart';
import '../../../../../../utils/shared_preferences.dart';
import '../../../../../createfound/models/emplyee_departments_model.dart';
import '../../../../../createfound/models/get_locations_model.dart';
import '../../../../../createfound/models/get_user_model.dart';
import '../../../../../createfound/models/serial_number_model.dart';
import '../../../../../material_movement/material_movement_details/cubits/material_movement_details_cubit.dart';
import '../../../../../material_movement/models/material_movements_model.dart';
import '../../../../../material_movement/models/responseModels/material_movement_response.dart';

part 'pay_rate_state.dart';

class PayRateCubit extends Cubit<PayRateState> {
  final GuardingServices services;
  final GMRate rate;
  final List<PayRate> payRates;

  PayRateCubit({
    required this.services,
    required this.rate,
    required this.payRates,
  }) : super(
          PayRateState.initial(
            payRates: payRates,
            rate: rate,
            message: '',
            newPayRate: PayRate(),
            loggedInUserDetails: EntrySecurity(),
            departments: const [],
          ),
        );

  CommonServices commonServices = CommonServices();

  Future<void> initializeValues() async {
    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    var userId = await SharedPrefs.getUserId();
    EntrySecurity loggedInUserDetails =
    await commonServices.getUserDetails(userId: userId);

    GetLocations getLocationsData =
        await commonServices.getLocations(name: 'ATOM_LOCATIONS');

    EmployeeDepartments departments =
        await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');

    // Get Date of Creation
    state.rate.inputDate =
        DateFormat(Constants.fulldateFormat).format(DateTime.now());

    try {
      emit(
        state.copyWith(
            locations: getLocationsData,
            loggedInUserDetails: loggedInUserDetails,
            rate: rate,
            departments: departments.employeeDepartments,
            items: payRates,
            status: FormStatus.initial),
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

  void onModelValueChange(PayRate model) {
    emit(state.copyWith(newPayRate: model, status: FormStatus.initial));
  }

  Future<void> updateDropdownValues({
    Location? location,
    Department? vendor,
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

      state.rate.location = location;
      state.rate.slNo = slNo.serialNo;
    }

    if (vendor != null) {
      state.rate.vendor = vendor;
    }

    emit(state.copyWith(
      rate: state.rate,
      status: FormStatus.initial,
    ));
  }

  Future<void> onSave({bool isSubmit = false, officerRank = 1}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    log('----sdsss-----${state.rate.location}---');
    log('----sdsss-----${state.newPayRate.comment}---');

    switch (officerRank) {
      case 1:
        state.rate.securityGuardRates?.add(state.newPayRate);
        break;
      case 2:
        state.rate.securityGuardRates?.add(state.newPayRate);
        break;

      default:
        state.rate.securityGuardRates?.add(state.newPayRate);
    }

    GMRateRequest request = GMRateRequest(guardingRateInfo: state.rate);

    MaterialMovementResponse response = MaterialMovementResponse();

    if (!isSubmit) {
      try{
        response = await services.createGmRate(body: request, isSubmit: isSubmit);

      } catch(e){
        log('$e');
      }
    } else {
      //Validating Fields
      // if (!state.isValid.status) {
      //   emit(
      //     state.copyWith(
      //       status: FormStatus.error,
      //       message: state.isValid.message,
      //     ),
      //   );
      //   return;
      // }
      response = await services.createGmRate(body: request, isSubmit: isSubmit);
    }

    emit(
      state.copyWith(
        message: response.message,
        status: FormStatus.success,
      ),
    );
  }
}
