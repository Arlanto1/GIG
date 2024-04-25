import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/km_ui_labels.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/services/key_management_issuance_services.dart';
import 'package:db_atom/src/services/common_services.dart';

import '../../../../../../utils/utils_common.dart';


part 'key_issuance_process_record_event.dart';
part 'key_issuance_process_record_state.dart';

class KeyIssuanceProcessRecordBloc
    extends Bloc<KeyIssuanceProcessRecordEvent, KeyIssuanceProcessRecordState> {
  final int locationId;
  final int parentId;
  final bool isMasterKey;
  final KeyManagementMasterModel? keyManagementMasterModel;

  KeyIssuanceProcessRecordBloc({
    required this.locationId,
    required this.parentId,
    required this.isMasterKey,
    this.keyManagementMasterModel,
  }) : super(const KeyIssuanceProcessRecordState()) {
    on<FetchData>(
      _fetchContacts,
      transformer: droppable(),
    );
    on<InitializeValues>(_initializeValues);
    on<SaveRecord>(_saveRecord);
    on<DeleteRecord>(_deleteRecord);
    on<GetKeyDescription>(_getKeyDescription);
  }

  final KeyManagementIssuanceServices services =
      KeyManagementIssuanceServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(InitializeValues event,
      Emitter<KeyIssuanceProcessRecordState> emit) async {
    try {
      // List<Organisation> items =
      //     await commonServices.getOrganisations(name: violationDescription);

      List<Organisation> keyDescriptions = await KeyManagementIssuanceServices()
          .getKeyDescriptions(locationId: locationId,isMasterKey: isMasterKey);

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.keyManagementIssuanceModule);
      ExtraProperties extraProperties =
      await UtilsCommon().checkWritePermission(
        moduleCode: Constants.keyManagementIssuanceModule,
        commonServices: commonServices,
      );
      KMUiLabels labels = KMUiLabels.fromJson(responseLabels);

      return emit(
        state.copyWith(
          hasReachedMax: false,
          labels: labels,
          keyDescriptions: keyDescriptions,
          extraProperties: extraProperties,

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
    }on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _fetchContacts(
      FetchData event, Emitter<KeyIssuanceProcessRecordState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == FormStatus.initial) {
        List<KeyIssuanceProcessRecord> response =
            await services.getIssuanceProcessList(
          id: '${event.id}',
          // type: '${event.type}',
        );
        return emit(
          state.copyWith(
            items: response,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      List<KeyIssuanceProcessRecord> response =
          await services.getIssuanceProcessList(
        id: '${event.id}',
        // type: '${event.type}',
      );

      if (response.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items ?? [])..addAll(response),
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }

  FutureOr<void> _deleteRecord(
      DeleteRecord event, Emitter<KeyIssuanceProcessRecordState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      await KeyManagementIssuanceServices().deleteVpById(event.id);
      List<KeyIssuanceProcessRecord> response =
          await services.getIssuanceProcessList(
        id: '${event.parentId}',
      );
      return emit(
        state.copyWith(items: response, status: FormStatus.success),
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

  FutureOr<void> _saveRecord(
      SaveRecord event, Emitter<KeyIssuanceProcessRecordState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      KeyIssuanceProcessRecordRequest request =
          KeyIssuanceProcessRecordRequest();


      // request.model?.keyDescription ??= Organisation();
      // request.model?.keyDescription?.id = event.mainIssuanceId;
      request.model = event.keyIssuanceProcessRecord;
      await KeyManagementIssuanceServices().createIssuanceProcessRecord(
        body: request,
        kmiId: event.parentId,
        isSubmit: false,
      );

      /// Refresh list
      List<KeyIssuanceProcessRecord> response =
          await services.getIssuanceProcessList(
        id: '${event.parentId}',
        // type: '${event.type}',
      );
      return emit(state.copyWith(
        items: response,
        hasReachedMax: false,
        status: FormStatus.success,
      ));
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

  FutureOr<void> _getKeyDescription(GetKeyDescription event,
      Emitter<KeyIssuanceProcessRecordState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      Organisation keyDescription = await KeyManagementIssuanceServices()
          .getKeyDescById(
              id: event.keyDescriptionId, isMasterKey: event.isMasterKey);

      return emit(
        state.copyWith(
          keyDescription: keyDescription,
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
    } on Exception {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
