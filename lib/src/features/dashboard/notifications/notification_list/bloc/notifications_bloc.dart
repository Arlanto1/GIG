import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/notifications/services/notifications_services.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(const NotificationsState()) {
    on<InitializeValues>(_initializeValues);
    on<ReadRecord>(_readRecord);
    on<DeleteRecord>(_deleteRecord);
    on<DeleteAllRecords>(_deleteAllRecords);
    on<FetchData>(
      _fetchMaterialMovements,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
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
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.formError,
        ),
      );
      return;
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

  FutureOr<void> _refreshList(
      RefreshList event, Emitter<NotificationsState> emit) async {
    try {
      NotificationsResponseModel response = await services.getNotificationList(
        startPosition: '${0}',
        maximumRecords: '${20}',
      );

      return emit(
        state.copyWith(
          items: response.items,
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
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

  FutureOr<void> _readRecord(
      ReadRecord event, Emitter<NotificationsState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      await NotificationServices().readRecord(event.id);

      final updatedItems =
          state.items.where((item) => item.id != event.id).toList();

      return emit(
        state.copyWith(items: updatedItems, status: FormStatus.success),
      );
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.formError,
        ),
      );
      return;
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
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
          status: FormStatus.formError,
        ),
      );
      return;
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

  FutureOr<void> _deleteAllRecords(
      DeleteAllRecords event, Emitter<NotificationsState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      await NotificationServices().deleteAll();
      return emit(
        state.copyWith(items: [], status: FormStatus.success),
      );
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.formError,
        ),
      );
      return;
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }
}
