// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:bloc_concurrency/bloc_concurrency.dart';
// import 'package:db_atom/src/enums/form_status.dart';
// import 'package:db_atom/src/features/contact_details/models/contact_info.dart';
// import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/requestModels/key_history_record_request.dart';
// import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/services/key_management_master_services.dart';
// import 'package:db_atom/src/models/organisation.dart';
// import 'package:db_atom/src/models/responseModels/generic_response.dart';
// import 'package:db_atom/src/services/CommonServices.dart';
// import 'package:equatable/equatable.dart';
//
//
// part 'key_history_record_event.dart';
// part 'key_history_record_state.dart';
//
// class KeyHistoryRecordBloc extends Bloc<KeyHistoryRecordEvent, KeyHistoryRecordState> {
//   final String rankType;
//
//   KeyHistoryRecordBloc({required this.rankType})
//       : super(const KeyHistoryRecordState(ranks: [])) {
//     on<FetchData>(
//       _fetchContacts,
//       transformer: droppable(),
//     );
//     on<InitializeValues>(_initializeValues);
//     on<SaveRecord>(_saveRecord);
//     on<DeleteRecord>(_deleteRecord);
//   }
//   final KeyManagementMasterServices services = KeyManagementMasterServices();
//   final CommonServices commonServices = CommonServices();
//
//   FutureOr<void> _initializeValues(
//       InitializeValues event, Emitter<KeyHistoryRecordState> emit) async {
//     try {
//       List<Organisation> items =
//       await commonServices.getOrganisations(name: rankType);
//
//       return emit(
//         state.copyWith(
//           ranks: items,
//           hasReachedMax: false,
//         ),
//       );
//     } on Exception {
//       return emit(state.copyWith(status: FormStatus.failure));
//     }
//   }
//
//
//   FutureOr<void> _fetchContacts(
//       FetchData event, Emitter<KeyHistoryRecordState> emit) async {
//     try {
//       if (state.hasReachedMax) return;
//
//       if (state.status == FormStatus.initial) {
//         ContactsListModel response = await services.getContactListByType(
//           id: '${event.id}',
//           type: '${event.type}',
//         );
//         return emit(
//           state.copyWith(
//             items: response.contacts,
//             hasReachedMax: false,
//             status: FormStatus.success,
//           ),
//         );
//       }
//
//       ContactsListModel response = await services.getKeyHistoryListByType(
//         id: '${event.id}',
//         type: '${event.type}',
//       );
//
//       if (response.contacts?.isEmpty == true) {
//         return emit(state.copyWith(hasReachedMax: true));
//       }
//       return emit(
//         state.copyWith(
//           items: List.of(state.items ?? [])..addAll(response.contacts ?? []),
//           hasReachedMax: false,
//         ),
//       );
//     } catch (e) {
//       return emit(state.copyWith(status: FormStatus.failure));
//     }
//   }
//
//   FutureOr<void> _deleteRecord(
//       DeleteRecord event, Emitter<KeyHistoryRecordState> emit) async {
//     emit(
//       state.copyWith(
//         status: FormStatus.loading,
//       ),
//     );
//     try {
//       await KeyManagementMasterServices().deleteKHdById(event.id);
//       ContactsListModel response = await services.getContactListByType(
//         id: '${event.mainContactId}',
//         type: '${event.type}',
//       );
//
//       return emit(
//         state.copyWith(items: response.contacts, status: FormStatus.success),
//       );
//     } on GenericResponse catch (e) {
//       emit(
//         state.copyWith(
//           message: e.message,
//           status: FormStatus.error,
//         ),
//       );
//       return;
//     } on Exception {
//       return emit(state.copyWith(status: FormStatus.failure));
//     }
//   }
//
//   FutureOr<void> _saveRecord(
//       SaveRecord event, Emitter<KeyHistoryRecordState> emit) async {
//     emit(
//       state.copyWith(
//         status: FormStatus.loading,
//       ),
//     );
//     try {
//       KeyHistoryRecordRequest request = KeyHistoryRecordRequest();
//
//       request.keyLossGi = event.contactInfo;
//       await KeyManagementMasterServices()
//           .createKeyHistoryRecord(body: request, isSubmit: false);
//
//       /// Refresh list
//       ContactsListModel response = await services.getContactListByType(
//         id: '${event.mainContactId}',
//         type: '${event.type}',
//       );
//       return emit(
//         state.copyWith(items: response.contacts, status: FormStatus.success),
//       );
//     } on GenericResponse catch (e) {
//       emit(
//         state.copyWith(
//           message: e.message,
//           status: FormStatus.error,
//         ),
//       );
//       return;
//     } on Exception {
//       return emit(state.copyWith(status: FormStatus.failure));
//     }
//   }
// }
