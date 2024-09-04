import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/services/shift_schedule_services.dart';

part 'duty_post_details_state.dart';

class DutyPostDetailsCubit extends Cubit<DutyPostDetailsState> {
  final ShiftScheduleServices services = ShiftScheduleServices();
  final DutyPostModel parentModel;
  final String id;
  final CommonServices commonServices = CommonServices();
  final int shiftScheduleId;

  DutyPostDetailsCubit({
    required this.parentModel,
    required this.id,
    required this.shiftScheduleId,
  }) : super(
          DutyPostDetailsState.initial(
            locations: Locations(),
            loggedInUserDetails: User(),
            users: const [],
            emailUsers: const [],
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

    ///
    try {
      Organisation selectedRank;
      List<Organisation> ranks = await services
          .getRanksListByAssignedDutyPostId(dutyPostId: parentModel.id!);

      selectedRank = state.selectedRank ?? ranks.first;

      List<Organisation> shifts =
          await services.getShiftListByAssignedDutyPostId(
              dutyPostId: parentModel.id!, rankId: selectedRank.id!);
      Organisation selectedShift = state.selectedShift ?? shifts.first;

      ShiftModel model = await services.getAvailableSelectedGuardsByShift(
        shiftId: selectedShift.id!,
        dutyPostId: parentModel.id!,
        rankId: selectedRank.id!,
      );

      log('-state.selectedRank----${state.selectedRank?.name}---');
      log('-state.selectedShift----${state.selectedShift?.name}---');
      emit(
        state.copyWith(
          status: FormStatus.initial,
          ranks: ranks,
          selectedRank: state.selectedRank ?? selectedRank,
          selectedShift: state.selectedShift ?? selectedShift,
          shifts: shifts,
          model: model,
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
    } catch (e) {
      log('Initialization issue', error: e, name: 'Duty Post Details Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.formError,
        ),
      );
    }
  }

  void updateStatus({required String id}) {
    commonServices.updateRecordStatus(
        id: id, module: Constants.contactDetailsModule);
  }

  /// Shift Dropdown Value
  Future<void> getShifts({
    required Organisation rank,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    List<Organisation> shifts = await services.getShiftListByAssignedDutyPostId(
        dutyPostId: parentModel.id!, rankId: rank.id!);
    Organisation selectedShift = shifts.first;

    emit(state.copyWith(
      shifts: shifts,
      selectedRank: rank,
      status: FormStatus.initial,
    ));
    getAvailableSelectedGuardsByShift(shift: selectedShift);
  }

  Future<void> getAvailableSelectedGuardsByShift({
    // required Organisation rank,
    required Organisation shift,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    ShiftModel model = await services.getAvailableSelectedGuardsByShift(
      shiftId: shift.id!,
      dutyPostId: parentModel.id!,
      rankId: state.selectedRank!.id!,
    );
    emit(state.copyWith(
      model: model,
      status: FormStatus.initial,
      selectedShift: shift,
    ));
  }

  Future<void> updateReplacement(
    BuildContext context,
    Replacement updatedReplacement,
  ) async {
    emit(state.copyWith(status: FormStatus.loading));

    if (updatedReplacement.id != null) {
      log('Updating Existing Replacement');
      state.model.replacements = state.model.replacements
          ?.map((existing) => existing.id == updatedReplacement.id
              ? updatedReplacement
              : existing)
          .toSet();
    } else {
      /// Handle new replacements
      state.model.replacements ??= {};
      if (updatedReplacement.tempId != null) {
        log('Creating/Updating new Replacement with tempId: ${updatedReplacement.tempId}');
        // Remove any existing replacement with the same tempId before adding
        state.model.replacements!.removeWhere((existingReplacement) =>
            existingReplacement.tempId == updatedReplacement.tempId);
      }
      state.model.replacements!.add(updatedReplacement);
    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));

    /// Saving and Refresh the record
    await submitAndRefreshScreen(context: context, checkValidations: false);
  }

  Future<void> submitAndRefreshScreen({
    BuildContext? context,
    required bool checkValidations,
  }) async {
    /// Saving the record
    await submitForm(
      isSaveOnly: true,
      model: state.model,
      status: FormStatus.initial,
      newSelectedShift: state.selectedShift!,
      checkValidations: checkValidations,
    );

    /// For Adding Replacement
    log('--state.status--context-${state.status}--');
    if (state.status != FormStatus.formError &&
        context != null &&
        context.mounted) {
      Navigator.pop(context);
    }

    /// refreshing the list so that we can refresh the validation for creating new replacements.
    initializeValues();
  }

  Future<void> getNextAvailableReplacementDates({required int userId}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    NextAvailableDateRange replacementDateRange =
        await services.getNextAvailableReplacementDates(
      dutyPostId: parentModel.id!,
      rankId: state.selectedRank!.id!,
      userId: userId,
      shiftId: state.selectedShift!.id!,
    );

    emit(state.copyWith(
      status: FormStatus.initial,
      replacementDates: replacementDateRange,
    ));
  }

  Future<void> submitForm({
    bool isSaveOnly = false,
    required ShiftModel model,
    FormStatus? status,
    required Organisation newSelectedShift,
    required bool checkValidations,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    log('---state.selectedShift!.id-${state.selectedShift!.id}--');
    log('---isSaveOnly---$isSaveOnly--');

    // Create/Update API Call
    ShiftRequest request = ShiftRequest(shifts: model);

    log('--checkValidations-$checkValidations-');
    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        if (checkValidations && !state.isValidDraft.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValidDraft.message,
            ),
          );
          return;
        }
        response = (await services.saveSelectedGuards(
          body: request,
          isSubmit: false,
          dutyPostId: parentModel.id!,
          rankId: state.selectedRank!.id!,
          shiftId: newSelectedShift.id!,
          shiftScheduleId: shiftScheduleId,
        ));
      } else {
        //Validating Fields
        // if (!state.isValid.status) {
        //   emit(
        //     state.copyWith(
        //       status: FormStatus.error,
        //       message: state.isValid.message,
        //     ),
        //   );
        //   return;
        // }
        response = await services.saveSelectedGuards(
          body: request,
          isSubmit: true,
          dutyPostId: parentModel.id!,
          rankId: state.selectedRank!.id!,
          shiftId: state.selectedShift!.id!,
          shiftScheduleId: shiftScheduleId,
        );
      }
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.formError,
        ),
      );
      return;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }

    log('---response--msg--${response.message}---');

    emit(
      state.copyWith(
        message: response.message,
        status: status == null ? FormStatus.success : FormStatus.initial,
        selectedShift: newSelectedShift,
      ),
    );
  }
}
