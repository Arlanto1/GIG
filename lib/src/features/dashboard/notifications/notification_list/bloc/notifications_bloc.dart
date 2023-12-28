import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/notifications/notification_details/models/notifications_response_model.dart';
import 'package:db_atom/src/features/dashboard/notifications/services/notifications_services.dart';
import 'package:db_atom/src/services/CommonServices.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(const NotificationsState()) {
    on<InitializeValues>(_initializeValues);
    on<DeleteRecord>(_deleteRecord);
    on<FetchData>(
      _fetchMaterialMovements,
      transformer: droppable(),
    );
  }

  final NotificationServices services = NotificationServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<NotificationsState> emit) async {
    try {
      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.contactDetailsModuleCode);
      CdUiLabels labels = CdUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          labels: labels,
          hasReachedMax: false,
        ),
      );
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _fetchMaterialMovements(
      FetchData event, Emitter<NotificationsState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        NotificationsResponseModel response =
            await services.getNotificationList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      NotificationsResponseModel response = await services.getNotificationList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
      );

      if (response.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items)..addAll(response.items ?? []),
          hasReachedMax: false,
        ),
      );
    } on TokenExpiredException catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.sessionExpired,
        ),
      );
      return;
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _deleteRecord(
      DeleteRecord event, Emitter<NotificationsState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      await NotificationServices().deleteById(event.id);

      final updatedItems =
          state.items.where((item) => item.id != event.id).toList();

      return emit(
        state.copyWith(items: updatedItems, status: FormStatus.success),
      );
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
        ),
      );
      return;
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
