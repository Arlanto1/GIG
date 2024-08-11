import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/notifications/services/notifications_services.dart';

import '../../../../../models/responseModels/permission_error.dart';

part 'charts_state.dart';

class ChartsCubit extends Cubit<ChartsState> {
  final CommonServices commonServices;

  ChartsCubit({
    required this.commonServices,
  }) : super(
          ChartsState.initial(
              lawEnforcementVisitByEntity: const [],
              lawEnforcementVisitByRegion: const [],
              eventProtectionByRegion: const [],
              errorMessage: '',
              notificationCount: 0),
        );

  NotificationServices notificationServices = NotificationServices();

  Future<void> initializeValues() async {
    log('-status-1-${state.status}--');
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    log('-status--${state.status}--');

    try {
      int count = await notificationServices.getNotificationCount();
      log('-count---$count--');
      final futures = [
        commonServices.getDashboardChart(module: 'LEVE'),
        commonServices.getDashboardChart(module: 'LEVR'),
        commonServices.getDashboardChart(module: 'EPR'),
      ];

      final results = await Future.wait(futures);
      DisplayMenu displayMenu =
          await SharedPrefs.getDisplayMenu() ?? DisplayMenu();

      List<PieChartData> lawEnforcementVisitByEntity = results[0];
      List<PieChartData> lawEnforcementVisitByRegion = results[1];
      List<PieChartData> eventProtectionByRegion = results[2];

      emit(
        state.copyWith(
          lawEnforcementVisitByEntity: lawEnforcementVisitByEntity,
          lawEnforcementVisitByRegion: lawEnforcementVisitByRegion,
          eventProtectionByRegion: eventProtectionByRegion,
          status: FormStatus.initial,
          notificationCount: count,
          displayMenu: displayMenu,
        ),
      );
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.formError,
        ),
      );
      return;
    } on TokenExpiredException catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.sessionExpired,
        ),
      );
      return;
    } on PermissionError catch (e) {
      log('PermissionError issue', error: e, name: 'Charts Cubit');
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.permissionLocationError,
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
