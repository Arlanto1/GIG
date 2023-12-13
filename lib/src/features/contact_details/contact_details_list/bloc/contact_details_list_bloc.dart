import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/services/CommonServices.dart';

import '../../services/contact_details_services.dart';

part 'contact_details_list_event.dart';
part 'contact_details_list_state.dart';

class ContactDetailsListBloc
    extends Bloc<ContactDetailsListEvent, ContactDetailsListState> {
  ContactDetailsListBloc() : super(const ContactDetailsListState()) {
    on<InitializeValues>(_initializeValues);
    on<FetchData>(
      _fetchMaterialMovements,
      transformer: droppable(),
    );
  }

  final ContactDetailsServices services = ContactDetailsServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValues event, Emitter<ContactDetailsListState> emit) async {
    try {
      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(), moduleCode: Constants.contactDetailsModuleCode);
      log('--default--${responseLabels.toString()}----//Getting Proper response as JSON------');
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
      FetchData event, Emitter<ContactDetailsListState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        ContactDetailsListResponseModel response = await services.getGcd(
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

      ContactDetailsListResponseModel response = await services.getGcd(
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
}
