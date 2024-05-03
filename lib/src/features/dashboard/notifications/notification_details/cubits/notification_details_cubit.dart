import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/notifications/services/notifications_services.dart';
import 'package:db_atom/src/services/common_services.dart';

part 'notification_details_state.dart';

class NotificationDetailsCubit extends Cubit<NotificationDetailsState> {
  final NotificationServices services;
  final String id;
  final CommonServices commonServices;

  NotificationDetailsCubit({
    required this.services,
    required this.commonServices,
    required this.id,
  }) : super(
          NotificationDetailsState.initial(
            model: NotificationModel(),
            locations: Locations(),
            loggedInUserDetails: User(),
            users: const [],
            emailUsers: const [],
            errorMessage: '',
          ),
        );

  Future<void> initializeValues() async {
    log('--initializeValues-Notification-');
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      NotificationModel model = NotificationModel();
      log('--1111--$model');

      if (!id.isEmptyOrNull) {
        // model = await services.getById(81);
        model = await services.getById(int.parse(id));
      }

      emit(
        state.copyWith(
          status: FormStatus.initial,
          model: model,
        ),
      );
    } on Exception catch (e) {
      return UtilsCommon().eHandling(e, emit, state);
    }
  }

  Future<void> deleteNotification(int id) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      GenericResponse response = await NotificationServices().deleteById(id);
      emit(
        state.copyWith(
          message: response.message,
          status: FormStatus.success,
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
    } on Exception catch (e) {
      return UtilsCommon().eHandling(e, emit, state);
    }
  }
}
