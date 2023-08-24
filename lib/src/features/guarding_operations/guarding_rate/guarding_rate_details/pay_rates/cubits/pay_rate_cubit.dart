import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/services/guarding_services.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../../../constants/constants.dart';
import '../../../../../../models/department.dart';
import '../../../../../../utils/shared_preferences.dart';
import '../../../../../createfound/models/emplyee_departments_model.dart';
import '../../../../../createfound/models/get_locations_model.dart';
import '../../../../../createfound/models/get_user_model.dart';
import '../../../../../createfound/models/serial_number_model.dart';
import '../../../../../material_movement/material_movement_details/cubits/material_movement_details_cubit.dart';
import '../../../../../material_movement/models/material_movements_model.dart';

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
            loggedInUserDetails: GetUserDetails(),
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
}
