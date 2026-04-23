import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/services/duty_post_master_services.dart';
import 'package:intl/intl.dart';

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

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    Organisation? location;
    List<Organisation> dutyPostNames = await services.getDutyPostsByLocation(
        locationId: location!.id.toString());

    emit(
      state.copyWith(
        status: FormStatus.initial,
        dutyPosts: dutyPostNames,
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
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),//0
        commonServices.getUserDetails(userId: userId),//1
        // commonServices.getUsers(),
        commonServices.getAtomStaticUsers(
            roleName: ConstantUserRoles.atomStaticUser),//2
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.guardingMasterModuleCode),//3
        SharedPrefs.getDefaultLocation(),//4
     services.getDutyPostsByLocation(
    locationId: state.model.location!.id.toString()),
      ]);

      Locations getLocationsData = futures[0];
      User loggedInUserDetails = futures[1];
      // List<User> entrySecurities = futures[2];
      GetDepositor emailUsers = futures[2];
      dynamic responseLabels = futures[3];
      Organisation? defaultLocation = futures[4];
      List<Organisation> dutyPosts = futures[5];
      // Organisation? location = state.model.location;

      if (state.model.location == null && defaultLocation != null) {
        // SerialNumberModel slNo = await commonServices.getSlNo(
        //   locationId: defaultLocation.id.toString(),
        //   moduleCode: Constants.contactDetailsModule,
        // );
        state.model.location = defaultLocation;
        // state.model.slNo = slNo.serialNo;
        dutyPosts = await services.getDutyPostsByLocation(
            locationId: state.model.location!.id.toString());
      }
      state.model.createdBy ??= loggedInUserDetails;
      // Get Date of Creation
      // state.model.createdDate = _getCurrentDate();
      // state.model.createdDate = state.model.createdDate == null
      //     ? Utils().getCurrentDate()
      //     : Utils().formatUnixTimestamp(state.model.createdDate ?? '');

      state.model.createdDate = state.model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.createdDate ?? '0'),
              Constants.fulldateFormat);

      SSUiLabels labels = SSUiLabels.fromJson(responseLabels);
      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          // entrySecurities: entrySecurities,
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
      // SerialNumberModel slNo = await commonServices.getSlNo(
      //   locationId: location.id.toString(),
      //   moduleCode: Constants.guardingMasterDataModule,
      // );
      state.model.status = status ?? state.model.status;
      state.model.location = location;
      state.model.dutyPostLocation = dutyPostName;
      List<Organisation> dutyPosts = await services.getDutyPostsByLocation(
          locationId: location.id.toString());
      log('--dutyPosts-${dutyPosts.length}---');

      await checkDpmExistsOrNot(state.model);
      emit(state.copyWith(
        dutyPosts: dutyPosts,
        status: FormStatus.initial,
      ));
    }

    log('--dutyPostName--${dutyPostName?.name}---');
    if (dutyPostName != null) {
      state.model.dutyPostLocation = dutyPostName;
      await checkDpmExistsOrNot(state.model);
    }
    if (rankId != null) {
      state.model.rankId = rankId;
      await checkDpmExistsOrNot(state.model);
    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  Future<void> checkDpmExistsOrNot(DutyPostMasterModel model) async {
    if (state.model.location?.id == null ||
        state.model.dutyPostLocation?.id == null ||
        state.model.rankId == null) {
      log('Not calling API because mandatory fields are not filled yet.');
      return;
    }
    try {
      await services.checkDpmExists(
        locationId: state.model.location!.id!,
        dutyPostLocationId: state.model.dutyPostLocation!.id!,
        rankId: state.model.rankId!,
      );
    } on GenericResponse catch (e) {
      state.model.location = null;

      emit(
        state.copyWith(
          model: state.model,
          message: e.message,
          status: FormStatus.formError,
        ),
      );
      return;
    } on Exception catch (e) {
      state.model.location = null;
      emit(
        state.copyWith(
          model: state.model,
          message: e.toString(),
          status: FormStatus.formError,
        ),
      );
      return;
    }
  }

  void submitForm({bool isSaveOnly = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (state.model.status == 0 || state.model.status == null) {
      state.model.status = 1;
    }
    // Setting time in milliseconds
    // state.model.createdDate =
    //     (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.createdDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.createdDate!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.createdDate = inputDate.toString();
    }
    // Create/Update API Call
    DutyPostMasterRequest request =
        DutyPostMasterRequest(dutyPostMaster: state.model);

    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
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
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return;
        }
        response = (await services.createDutyPostMaster(
            body: request, isSubmit: true));
      }
      state.model.createdDate = state.model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.createdDate ?? '0'),
              Constants.fulldateFormat);
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);

      state.model.createdDate = state.model.createdDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.createdDate ?? '0'),
              Constants.fulldateFormat);
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
