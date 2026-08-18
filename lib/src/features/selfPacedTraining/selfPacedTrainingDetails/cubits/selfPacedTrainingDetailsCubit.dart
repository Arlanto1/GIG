import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/selfPacedTraining/models/selfPacedTrainingModel.dart';
import 'package:db_atom/src/features/selfPacedTraining/services/selfPacedTrainingService.dart';
import 'package:db_atom/src/features/training_module/models/requestModel/training_module_request.dart';

import '../../../incident_management/models/im_ui_labels.dart';

part 'selfPacedTrainingDetailsState.dart';

class SelfPacedTrainingDetailsCubit extends Cubit<SelfPacedTrainingDetailsState> {
  final SelfPacedTrainingService services;
  final SelfPacedTrainingModel? model;
  final CommonServices commonServices;

  SelfPacedTrainingDetailsCubit({
    required this.services,
    required this.commonServices,
    this.model,
  }) : super(
    SelfPacedTrainingDetailsState.initial(
      model: model ?? SelfPacedTrainingModel(),
      loggedInUserDetails: User(),
      // users: const [],
      // emailUsers: const [],
      errorMessage: '',
    ),
  );

  void onModelValueChange(SelfPacedTrainingModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<void> initializeValues() async {
    log('-status-1-${state.status}--');
    log('-creatorName-1-${state.model.creatorName}--');

    // Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    var userId = await SharedPrefs.getUserId();
    try {
      final futures = [
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),
        // commonServices.getUserDetails(userId: userId),
        // commonServices.getUsersByRole(roleName: 'T1_Analyst'),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.contactDetailsModule),
        SharedPrefs.getDefaultLocation(),
      ];

      final results = await Future.wait(futures);

      Locations getLocationsData = results[0];
      // User loggedInUserDetails = results[1];
      // Analyst users = results[2];
      dynamic responseLabels = results[1];
      Organisation? defaultLocation = results[2];

      // Get Date of Creation
      // state.model.inputDate = Utils().getCurrentDate();

      state.model.creationDate = state.model.creationDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.creationDate ?? '0'),
          Constants.fulldateFormat);

      state.model.launchDate = state.model.launchDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.launchDate ?? '0'),
          Constants.fulldateFormat);


      state.model.dueDate = state.model.dueDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.dueDate ?? '0'),
          Constants.fulldateFormat);
      state.model.modificationDate = state.model.modificationDate == null
          ? Utils().getCurrentDate()
          : Utils().formatUnixTimestamp(state.model.modificationDate ?? '');

      // state.model.modifiedDate = Utils().getCurrentDate();

      CdUiLabels labels = CdUiLabels.fromJson(responseLabels);
      // state.model.creatorName ??= loggedInUserDetails.name;
      // state.model.modifiedBy ??= (loggedInUserDetails.firstName ?? "") +
      //     (loggedInUserDetails.lastName ?? "");

      emit(
        state.copyWith(
          // loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          // users: users.t1Analyst,
        ),
      );
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

  void updateStatus({required String id}) {
    commonServices.updateRecordStatus(
        id: id, module: Constants.contactDetailsModule);
  }
}
