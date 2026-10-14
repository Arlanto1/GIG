import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/parking/models/parking_model.dart';
import 'package:db_atom/src/features/parking/models/requestModels/parking_request_model.dart';
import 'package:db_atom/src/features/parking/services/parking_service.dart';
import 'package:intl/intl.dart';

import '../../../../models/location_Type_Model.dart';


part 'parking_details_state.dart';

class ParkingDetailsCubit extends Cubit<ParkingDetailsState> {
  final ParkingService services;
  final String id;
  final CommonServices commonServices;
  final Organisation? location;

  ParkingDetailsCubit({
    required this.services,
    required this.commonServices,
    required this.id,
    this.location,
  }) : super(
    ParkingDetailsState.initial(
      model: ParkingModel(),
      locations: Locations(),
      emailUsers: const [],
      errorMessage: '',
      eventId: null,
      listOfEntities: const [],
      departments: const [],
      loggedInUserDetails: null,
      getLocationType: GetLocationType(),

    ),
  );

  void onModelValueChange(ParkingModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(ParkingModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    List<BaseUser> emailUsers = await commonServices.getBaseUsers(
        isDbUser: false,
        roleName: ConstantUserRoles.atomStaticUser,
        locationId: state.model.location!.id!);
    emit(
      state.copyWith(
        status: FormStatus.initial,
        complainant: emailUsers,
      ),
    );
  }
  /// Finds the region id that contains the given location id.
  int? _getRegionIdForLocation(Locations? locations, int? locationId) {
    if (locations == null || locationId == null) return null;

    for (final region in locations.regions ?? []) {
      final bool found =
          region.locations?.any((loc) => loc.id == locationId) ?? false;
      if (found) return region.id;
    }
    return null;
  }


  // Future<void> initializeValues() async {
  //   emit(
  //     state.copyWith(
  //       status: FormStatus.loading,
  //     ),
  //   );
  //
  //   ParkingModel model = ParkingModel();
  //   if (id.isNotEmpty) {
  //     model = await services.getParkingDetailsById(id);
  //   }
  //   var userId = await SharedPrefs.getUserId();
  //   final Locations locations =
  //   await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');
  //   final int? regionId =
  //   _getRegionIdForLocation(locations, state.model.location?.id);
  //
  //   try {
  //
  //     // Get Date of Creation
  //     model.inputDate = model.inputDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(model.inputDate ?? '0'), Constants.fulldateFormat);
  //
  //
  //     final results = await Future.wait([
  //       commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS',isSezLocations: true),
  //       commonServices.getUserDetails(userId: userId),
  //       commonServices.getLocationType(locId: regionId!),
  //
  //     ]);
  //
  //     // Assign results to respective variables
  //     final Locations getLocationsData = results[0] as Locations;
  //     final User loggedInUserDetails = results[1] as User;
  //     final GetLocationType getLocationType = results[2] as GetLocationType;
  //
  //     model.entrySecurity ??= loggedInUserDetails;
  //
  //     emit(
  //       state.copyWith(
  //         model: model,
  //         locations: getLocationsData,
  //         loggedInUserDetails: loggedInUserDetails,
  //         status: FormStatus.initial,
  //         getLocationType: getLocationType,
  //       ),
  //     );
  //   } catch (e) {
  //     log('initialization issue', error: e, name: 'General Information Cubit');
  //     emit(
  //       state.copyWith(
  //         message: Constants.errorText,
  //         // TODO: error message should be dynamic
  //         status: FormStatus.error,
  //       ),
  //     );
  //   }
  // }

  Future<void> initializeValues() async {
    emit(state.copyWith(status: FormStatus.loading));

    try {
      ParkingModel model = ParkingModel();
      if (id.isNotEmpty) {
        model = await services.getParkingDetailsById(id);
      }

      final userId = await SharedPrefs.getUserId();

      model.inputDate = model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(model.inputDate ?? '0'), Constants.fulldateFormat);

      final results = await Future.wait([
        commonServices.getRegionsWithLocations(
            name: 'ATOM_LOCATIONS', isSezLocations: true),
        commonServices.getUserDetails(userId: userId),
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),
      ]);

      final Locations getLocationsData = results[0] as Locations;
      final User loggedInUserDetails = results[1] as User;
      final Locations allLocations = results[2] as Locations;

      // Use the loaded model, and tolerate a missing location (new record)
      final int? regionId =
      _getRegionIdForLocation(allLocations, model.location?.id);
      final int? locationId = model.location?.id;

      GetLocationType locationType = GetLocationType();
      if (locationId != null) {
        locationType = await commonServices.getLocationType(locId: locationId!);
      }

      model.entrySecurity ??= loggedInUserDetails;

      emit(state.copyWith(
        model: model,
        locations: getLocationsData,
        loggedInUserDetails: loggedInUserDetails,
        getLocationType: locationType,
        status: FormStatus.initial,
      ));
    } catch (e) {
      log('initialization issue', error: e, name: 'General Information Cubit');
      emit(state.copyWith(message: Constants.errorText, status: FormStatus.error));
    }
  }
  Future<void> updateLocationDropdownValue({
    Organisation? location,
  }) async {
    emit(state.copyWith(status: FormStatus.loading));
    GetLocationType? locType = state.getLocationType;

    if (location != null) {
      state.model.location = location;
      final int? locationId = location.id;
      final int? regionId =
      _getRegionIdForLocation(state.locations, locationId);
      locType = await commonServices.getLocationType(locId: locationId!);

    }
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
      getLocationType: locType,

    ));
  }


  Future<void> updateDropdownValues({
    int? demandStatus,
    Organisation? locationType,

  }) async {
    emit(state.copyWith(status: FormStatus.loading));

    state.model.parkingDemandStatus = demandStatus ?? state.model.parkingDemandStatus;
    if (locationType != null) {
      state.model.locationType = locationType;
    }
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void submitForm({bool isSaveOnly = false, bool isSubmit = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.inputDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.inputDate = inputDate.toString();
    }

    // Create/Update API Call
    ParkingRequestModel request =
    ParkingRequestModel(parkingModel: state.model);

    GenericResponse response = GenericResponse();
    try {
      log('---isSaveOnly-$isSaveOnly---');
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
          return emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValidDraft.message,
            ),
          );
        }
        log('---isSaveOnly-1---');
        response = (await services.createParking(
            body: request, isSubmit: false));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
          log('---submit-1---');
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return;
        }
        response = (await services.createParking(
            body: request, isSubmit: true));
      }
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
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
        model: state.model,
        message: response.message,
        status: FormStatus.success,
      ),
    );
  }

  void updateStatus({required String id}) {
    commonServices.updateRecordStatus(
        id: id, module: Constants.incidentManagementModule, status: 40);
  }
}
