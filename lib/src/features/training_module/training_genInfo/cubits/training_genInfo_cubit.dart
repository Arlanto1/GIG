import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/contact_details/services/contact_details_services.dart';
import 'package:db_atom/src/features/training_module/models/requestModel/training_module_request.dart';
import 'package:db_atom/src/features/training_module/services/training_module_service.dart';
import 'package:intl/intl.dart';

import '../../../incident_management/models/im_ui_labels.dart';

part 'training_genInfo_state.dart';

class TrainingGenInfoCubit extends Cubit<TrainingGenInfoState> {
  final TrainingModuleServices services;
  final TrainingModel? model;
  final CommonServices commonServices;

  TrainingGenInfoCubit({
    required this.services,
    required this.commonServices,
    this.model,
  }) : super(
    TrainingGenInfoState.initial(
      model: model ?? TrainingModel(),
      loggedInUserDetails: User(),
      // users: const [],
      // emailUsers: const [],
      errorMessage: '',
    ),
  );

  void onModelValueChange(TrainingModel model) {
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
        commonServices.getUserDetails(userId: userId),
        // commonServices.getUsersByRole(roleName: 'T1_Analyst'),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.contactDetailsModule),
        SharedPrefs.getDefaultLocation(),
      ];

      final results = await Future.wait(futures);

      Locations getLocationsData = results[0];
      User loggedInUserDetails = results[1];
      // Analyst users = results[2];
      dynamic responseLabels = results[2];
      Organisation? defaultLocation = results[3];

      // Get Date of Creation
      // state.model.inputDate = Utils().getCurrentDate();

      state.model.creationDate = state.model.creationDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.creationDate ?? '0'),
          Constants.fulldateFormat);

      state.model.startDate = state.model.startDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.startDate ?? '0'),
          Constants.fulldateFormat);


      state.model.endDate = state.model.endDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.endDate ?? '0'),
          Constants.fulldateFormat);
      // state.model.inputDate = state.model.inputDate == null ? Utils().getCurrentDate() : Utils().formatUnixTimestamp(state.model.inputDate ?? '') ;
      // state.model.modifiedDate = state.model.modifiedDate == null
      //     ? Utils().getCurrentDate()
      //     : Utils().formatUnixTimestamp(state.model.modifiedDate ?? '');

      // state.model.modifiedDate = Utils().getCurrentDate();

      CdUiLabels labels = CdUiLabels.fromJson(responseLabels);
      state.model.creatorName ??= loggedInUserDetails.name;
      // state.model.modifiedBy ??= (loggedInUserDetails.firstName ?? "") +
      //     (loggedInUserDetails.lastName ?? "");

      emit(
        state.copyWith(
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          // users: users.t1Analyst,
        ),
      );
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }
  //
  //
  // Future<bool> submitForm({
  //   bool isSaveOnly = false,
  //   bool navigateToNextScreen = false,
  // }) async {
  //   emit(
  //     state.copyWith(
  //       status: FormStatus.loading,
  //     ),
  //   );
  //
  //   // Setting time in milliseconds
  //   // state.model.inputDate =
  //   //     (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
  //   DateTime dateTime;
  //   if (!Utils().isTimestamp(state.model.inputDate!)) {
  //     dateTime =
  //         DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
  //     int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  //     state.model.inputDate = inputDate.toString();
  //   }
  //   // Create/Update API Call
  //   ContactDetailsGiRequest request =
  //   ContactDetailsGiRequest(cdGi: state.model);
  //
  //   // TODO: Need to change from Backend- Status should be handled from backend
  //   state.model.status ??= 0;
  //   try {
  //     GenericResponse response = GenericResponse();
  //     if (isSaveOnly) {
  //       //Validating Fields
  //       if (!state.isValidDraft.status) {
  //         state.model.inputDate = state.model.inputDate == null
  //             ? Utils().getCurrentDate()
  //             : Utils.timestampToDateConversion(
  //             int.tryParse(state.model.inputDate ?? '0'),
  //             Constants.fulldateFormat);
  //         emit(
  //           state.copyWith(
  //             status: FormStatus.formError,
  //             message: state.isValidDraft.message,
  //           ),
  //         );
  //         return false;
  //       }
  //       response = await services.createContactDetailsGi(
  //           body: request, isSubmit: false);
  //     } else {
  //       //Validating Fields
  //       if (!state.isValid.status) {
  //         emit(
  //           state.copyWith(
  //             status: FormStatus.formError,
  //             message: state.isValid.message,
  //           ),
  //         );
  //         return false;
  //       }
  //       response = await services.createContactDetailsGi(
  //           body: request, isSubmit: true);
  //     }
  //
  //     log('---response--msg--${response.message}---');
  //
  //     if (response.id != null) {
  //       int? id = int.tryParse(response.id!);
  //       if (id != null) {
  //         state.model.id = id;
  //       }
  //     }
  //     emit(
  //       state.copyWith(
  //         model: state.model,
  //         message: response.message,
  //         status: navigateToNextScreen
  //             ? FormStatus.navigateToNextScreen
  //             : FormStatus.success,
  //       ),
  //     );
  //     state.model.inputDate = state.model.inputDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(state.model.inputDate ?? '0'),
  //         Constants.fulldateFormat);
  //     return true;
  //   } on GenericResponse catch (e) {
  //     Utils().emitErrorState(e, emit, state);
  //     state.model.inputDate = state.model.inputDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(state.model.inputDate ?? '0'),
  //         Constants.fulldateFormat);
  //     return false;
  //   } on Exception catch (e) {
  //     state.model.inputDate = state.model.inputDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(state.model.inputDate ?? '0'),
  //         Constants.fulldateFormat);
  //     emit(
  //       state.copyWith(
  //         message: e.toString(),
  //         status: FormStatus.error,
  //       ),
  //     );
  //     return false;
  //   }
  // }

  void updateStatus({required String id}) {
    commonServices.updateRecordStatus(
        id: id, module: Constants.contactDetailsModule);
  }
}
