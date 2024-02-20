import 'dart:developer';

import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/services/duty_post_master_services.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:intl/intl.dart';

import '../../../../../../../index.dart';

part 'duty_post_master_details_state.dart';

class DutyPostMasterDetailsCubit extends Cubit<DutyPostMasterDetailsState> {
  final DutyPostMasterServices services;
  final DutyPostMasterModel? model;
  final CommonServices commonServices;

  DutyPostMasterDetailsCubit({
    required this.services,
    required this.commonServices,
    required this.model,
  }) : super(
          DutyPostMasterDetailsState.initial(
            model: model ?? DutyPostMasterModel(),
            locations: Locations(),
            loggedInUserDetails: User(),
            users: const [],
            emailUsers: const [],
            errorMessage: '',
          ),
        );

  void onModelValueChange(DutyPostMasterModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  String _getCurrentDate() {
    return DateFormat(Constants.fulldateFormat).format(DateTime.now());
  }

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    Organisation? location;
        List<Organisation> dutyPostName =
    await services.getDutyPostsByLocation(locationId: location!.id.toString());

    emit(
      state.copyWith(
        status: FormStatus.initial,
        dutyPosts: dutyPostName,
      ),
    );
  }

  Future<void> initializeValues() async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    var userId = await SharedPrefs.getUserId();
    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),
        commonServices.getUserDetails(userId: userId),
        commonServices.getUsersByRole(roleName: 'T1_Analyst'),
        commonServices.getUsers(),
        commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER'),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.guardingMasterModuleCode),
        SharedPrefs.getDefaultLocation(),
      ]);

      Locations getLocationsData = futures[0];
      User loggedInUserDetails = futures[1];
      Analyst users = futures[2];
      List<User> entrySecurities = futures[3];
      GetDepositor emailUsers = futures[4];
      dynamic responseLabels = futures[5];
      Organisation? defaultLocation = futures[6];
      List<Organisation> dutyPosts = [];
      Organisation? location = state.model.location ;

      if (state.model.location == null && defaultLocation != null) {
        // SerialNumberModel slNo = await commonServices.getSlNo(
        //   locationId: defaultLocation.id.toString(),
        //   moduleCode: Constants.contactDetailsModule,
        // );
        state.model.location = defaultLocation;
        // state.model.slNo = slNo.serialNo;
        dutyPosts = await services.getDutyPostsByLocation(
            locationId: defaultLocation.id.toString());
      }
      state.model.createdBy ??= loggedInUserDetails;
      // Get Date of Creation
      state.model.createdDate = _getCurrentDate();

      GmUiLabels labels = GmUiLabels.fromJson(responseLabels);
      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          users: users.t1Analyst,
          entrySecurities: entrySecurities,
          dutyPosts: dutyPosts,
          emailUsers: emailUsers.atomStaticUser,
          labels: labels,
        ),
      );
    } catch (e) {
      log('Initialization issue',
          error: e, name: 'Duty Post Master Details Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.error,
        ),
      );
    }
  }

  Future<void> updateDropdownValues({
    Organisation? location,
    Organisation? dutyPostName,
    BaseUser? user,
    int? status,
    int? rankId,
    int? dutyType,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    //Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.guardingMasterDataModule,
      );
      state.model.status = status ?? state.model.status;
      state.model.location = location;
      state.model.dutyPostLocation = dutyPostName;
      List<Organisation> dutyPosts = await services.getDutyPostsByLocation(
          locationId: location.id.toString());
      emit(state.copyWith(
        dutyPosts: dutyPosts,
        status: FormStatus.initial,
      ));
    }

    log('--dutyPostName--${dutyPostName?.name}---');
    //if (location != null) {
      state.model.dutyPostLocation = dutyPostName ?? state.model.dutyPostLocation;
   // }
    state.model.rankId = rankId ?? state.model.rankId;
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void submitForm({bool isSaveOnly = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    // if (state.model.status == 0 || state.model.status == null) {
    //   state.model.status = 1;
    // }
    // Setting time in milliseconds
    state.model.createdDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    // Create/Update API Call
    DutyPostMasterRequest request =
        DutyPostMasterRequest(dutyPostMaster: state.model);

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
        response = (await services.createDutyPostMaster(
            body: request, isSubmit: false));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValid.message,
            ),
          );
          return;
        }
        response = (await services.createDutyPostMaster(
            body: request, isSubmit: true));
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
}
