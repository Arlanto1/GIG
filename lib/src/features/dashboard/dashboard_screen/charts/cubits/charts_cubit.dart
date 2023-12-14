import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/contact_details/services/contact_details_services.dart';
import 'package:db_atom/src/models/responseModels/generic_response.dart';
import 'package:db_atom/src/services/CommonServices.dart';

part 'charts_state.dart';

class ChartsCubit extends Cubit<ChartsState> {
  final CommonServices commonServices;

  ChartsCubit({
    required this.commonServices,
  }) : super(
          ChartsState.initial(
            pieCharts: const [],
            errorMessage: '',
          ),
        );

  Future<void> initializeValues() async {
    log('-status-1-${state.status}--');
    // Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      final futures = [
        commonServices.getDashboardChart(module: 'LEVE'),
      ];

      final results = await Future.wait(futures);

      List<PieChartData> pieCharts = results[0];

      emit(
        state.copyWith(
          pieCharts: pieCharts,
        ),
      );
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
        ),
      );
      return;
    } catch (e) {
      log('Initialization issue', error: e, name: 'Charts Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.error,
        ),
      );
    }
  }
}
