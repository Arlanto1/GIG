import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/services/guarding_services.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../constants/constants.dart';
import '../../../../../../utils/shared_preferences.dart';
import '../../../../../material_movement/material_movement_details/cubits/material_movement_details_cubit.dart';

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
            rate: GMRate(),
            message: '',
            newPayRate: PayRate(),
          ),
        );

  Future<void> initializeValues() async {
    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    var userId = await SharedPrefs.getUserId();

    try {
      emit(
        state.copyWith(),
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
}
