// import 'dart:async';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/guarding_operations/vvip_visitor/models/vvip_ui_labels.dart';
//
// import '../../../../../index.dart';
// import '../../../guarding_operations/vvip_visitor/models/vvip_visitor_record_model.dart';
// import '../../models/material_items_model.dart';
//
//
//
// part 'material_items_event.dart';
// part 'material_items_state.dart';
//
// class MaterialItemsBloc
//     extends Bloc<MaterialItemsEvent, MaterialItemsState> {
//   MaterialItemsBloc() : super(const MaterialItemsState()) {
//     on<FetchData>(
//       _fetchContacts,
//       transformer: droppable(),
//     );
//     on<InitializeValues>(_initializeValues);
//     // on<SaveRecord>(_saveRecord);
//     // on<DeleteRecord>(_deleteRecord);
//   }
//
//   final MaterialMovementServices services = MaterialMovementServices();
//   final CommonServices commonServices = CommonServices();
//
//   FutureOr<void> _initializeValues(
//       InitializeValues event, Emitter<MaterialItemsState> emit) async {}
//
//   FutureOr<void> _fetchContacts(
//       FetchData event, Emitter<MaterialItemsState> emit) async {
//     try {
//       if (state.hasReachedMax) return;
//
//       if (state.status == FormStatus.initial) {
//         List<MaterialMovementItemsModel> response =
//         await services.getItems(
//           id: '${event.id}',
//           // type: '${event.type}',
//         );
//         return emit(
//           state.copyWith(
//             items: response,
//             hasReachedMax: false,
//             status: FormStatus.success,
//           ),
//         );
//       }
//
//       // List<VIVPVisitorRecordModel> response =
//       //     await services.getVVIPVisitorRecordsList(
//       //   id: '${event.id}',
//       //   // type: '${event.type}',
//       // );
//       //
//       // if (response.isEmpty == true) {
//       //   return emit(state.copyWith(hasReachedMax: true));
//       // }
//       // return emit(
//       //   state.copyWith(
//       //     items: List.of(state.items ?? [])..addAll(response),
//       //     hasReachedMax: false,
//       //   ),
//       // );
//     } catch (e) {
//       return emit(state.copyWith(status: FormStatus.failure));
//     }
//   }
//
//   // FutureOr<void> _deleteRecord(
//   //     DeleteRecord event, Emitter<MaterialItemsState> emit) async {
//   //   emit(
//   //     state.copyWith(
//   //       status: FormStatus.loading,
//   //     ),
//   //   );
//   //   try {
//   //     await VVIPVisitorServices().deleteVipById(event.id);
//   //     List<VIVPVisitorRecordModel> response =
//   //     await services.getVVIPVisitorRecordsList(
//   //       id: '${event.mainContactId}',
//   //     );
//   //     return emit(
//   //       state.copyWith(items: response, status: FormStatus.success),
//   //     );
//   //   } on GenericResponse catch (e) {
//   //     emit(
//   //       state.copyWith(
//   //         message: e.message,
//   //         status: FormStatus.formError,
//   //       ),
//   //     );
//   //     return;
//   //   } on Exception catch (e) {
//   //     return UtilsCommon().exceptionHandling(e, emit, state);
//   //   }
//   // }
//
//   // FutureOr<void> _saveRecord(
//   //     SaveRecord event, Emitter<MaterialItemsState> emit) async {
//   //   emit(
//   //     state.copyWith(
//   //       status: FormStatus.loading,
//   //     ),
//   //   );
//   //   try {
//   //     VVIPVisitorRecordRequest request = VVIPVisitorRecordRequest();
//   //
//   //     request.vipVisitors = event.vViPVisitorRecordModel;
//   //     await MaterialMovementServices().createVVIPVisitorsRecord(
//   //         body: request, isSubmit: false, id: '${event.mainContactId}');
//   //
//   //     /// Refresh list
//   //     List<VIVPVisitorRecordModel> response =
//   //     await services.getVVIPVisitorRecordsList(
//   //       id: '${event.mainContactId}',
//   //       // type: '${event.type}',
//   //     );
//   //     return emit(state.copyWith(
//   //       items: response,
//   //       hasReachedMax: false,
//   //       status: FormStatus.success,
//   //     ));
//   //   } on GenericResponse catch (e) {
//   //     emit(
//   //       state.copyWith(
//   //         message: e.message,
//   //         status: FormStatus.formError,
//   //       ),
//   //     );
//   //     return;
//   //   } on Exception catch (e) {
//   //     return UtilsCommon().exceptionHandling(e, emit, state);
//   //   }
//   // }
// }
