import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/services/shift_schedule_services.dart';

part 'duty_post_details_state.dart';

class DutyPostDetailsCubit extends Cubit<DutyPostDetailsState> {
  final ShiftScheduleServices services = ShiftScheduleServices();
  final DutyPostModel parentModel;
  final String id;
  final CommonServices commonServices = CommonServices();

  DutyPostDetailsCubit({
    required this.parentModel,
    required this.id,
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

    Organisation selectedRank;
    try {
      List<Organisation> ranks = await services
          .getRanksListByAssignedDutyPostId(dutyPostId: parentModel.id!);

      selectedRank = ranks.first;

      List<Organisation> shifts =
          await services.getShiftListByAssignedDutyPostId(
              dutyPostId: parentModel.id!, rankId: selectedRank.id!);
      Organisation selectedShift = shifts.first;

      Shift model = await services.getAvailableSelectedGuardsByShift(
        shiftId: selectedShift.id!,
        dutyPostId: parentModel.id!,
        rankId: selectedRank.id!,
      );

      emit(
        state.copyWith(
          status: FormStatus.initial,
          ranks: ranks,
          selectedRank: selectedRank,
          selectedShift: selectedShift,
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

  Future<void> getShiftListByAssignedDutyPostId({required rank}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    List<Organisation> shifts = await services.getShiftListByAssignedDutyPostId(
        dutyPostId: parentModel.id!, rankId: rank);
    Organisation selectedShift = shifts.first;
    getAvailableSelectedGuardsByShift(shift: selectedShift);

    emit(state.copyWith(
      shifts: shifts,
      status: FormStatus.initial,
      selectedShift: selectedShift,
    ));
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
    Shift model = await services.getAvailableSelectedGuardsByShift(
      shiftId: shift.id!,
      dutyPostId: parentModel.id!,
      rankId: state.selectedRank!.id!,
    );
    emit(state.copyWith(
      model: model,
      status: FormStatus.initial,
    ));
  }

  void submitForm({
    bool isSaveOnly = false,
    required Shift model,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    log('---submitDutyPost---');

    // Create/Update API Call
    ShiftRequest request = ShiftRequest(shifts: model);

    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValidDraft.message,
            ),
          );
          return;
        }
        response = (await services.saveSelectedGuards(
          body: request,
          isSubmit: false,
          dutyPostId: parentModel.id!,
          rankId: state.selectedShift!.id!,
          shiftId: state.selectedShift!.id!,
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
        response = (await services.saveSelectedGuards(
          body: request,
          isSubmit: true,
          dutyPostId: parentModel.id!,
          rankId: state.selectedShift!.id!,
          shiftId: state.selectedShift!.id!,
        ));
      }
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
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
        status: FormStatus.success,
      ),
    );
  }

  void updateReplacement(
    Replacement replacement,
  ) {
    emit(state.copyWith(
      status: FormStatus.loading,
    ));

    log('----replacement.fromDate---${replacement.fromDate}-');

    // Check if replacement has an ID
    if (replacement.id != null) {
      // Iterate over ranks and shifts to find and update the replacement
      state.model.replacements?.forEach((existingReplacement) {
        log('----existingReplacement-${existingReplacement.id} ${(replacement.id)}--${existingReplacement.toString()}-');
        if (existingReplacement.id == replacement.id) {
          // Update the existing replacement with the new values
          existingReplacement.replacedFor = replacement.replacedFor;
          existingReplacement.replacementBy = replacement.replacementBy;
          existingReplacement.fromDate = replacement.fromDate;
          existingReplacement.toDate = replacement.toDate;
          existingReplacement.status = replacement.status;
        }
      });
    } else {
      // If replacement has no ID, add it as a new object to the replacements list
      state.model.replacements ??= [];
      state.model.replacements!.add(replacement);
    }

    log('----end----');
    emit(state.copyWith(
      model: state.model,
      // seletedDutyPostModel: state.selectedDutyPostModel,
      status: FormStatus.initial,
    ));
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
}
