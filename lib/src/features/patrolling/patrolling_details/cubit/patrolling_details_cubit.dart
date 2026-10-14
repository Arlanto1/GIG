

import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/patrolling/models/patrolling_model.dart';
import 'package:db_atom/src/features/patrolling/models/patrolling_other_model.dart';
import 'package:db_atom/src/features/patrolling/models/requestModel/patrolling_other_request.dart';
import 'package:db_atom/src/features/patrolling/models/requestModel/patrolling_request_model.dart';
import 'package:db_atom/src/features/patrolling/services/patrolling_service.dart';
import 'package:intl/intl.dart';

import '../../../../models/location_Type_Model.dart';
import '../../models/dbsponsor_user_model.dart';
import '../../models/lsm_user_model.dart';
import '../../models/owner_user_model.dart';
import '../../models/securitySupervisor_user_model.dart';

part 'patrolling_details_state.dart';

class PatrollingDetailsCubit extends Cubit<PatrollingDetailsState> {
  final PatrollingService services;
  final PatrollingModel? model;
  final CommonServices commonServices;
  final PatrollingOtherModel? otherModel;

  // Name-based default location. IDs differ per environment, so we resolve
  // by name against the freshly-fetched locations tree instead of relying
  // on any stored/environment-specific id or a stray default baked into a model.
  // static const String _defaultLocationName = 'NKP B1';

  PatrollingDetailsCubit({
    required this.services,
    required this.commonServices,
    this.model,
    this.otherModel
  }) : super(
    PatrollingDetailsState.initial(
      model: model ?? PatrollingModel(),
      loggedInUserDetails: User(),
      users: const [],
      errorMessage: '',
      priorities: const [],
      projects: const [],
      trackers: const [],
      eventId: null, locations: Locations(), listOfModules: const [], getStatus: const [], listOfEntities: const [], otherModel: otherModel ?? PatrollingOtherModel(), owner: const [], lsm:const [], securitySupervisor: const [] ,
      getLocationType: GetLocationType(),

    ),
  );

  void onModelValueChange(PatrollingModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(PatrollingModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  /// Finds a location by name (case-insensitive, trimmed) across all regions
  /// in the given [locations] tree. Returns null if not found.
  ///
  /// NOTE: adjust `region.locations` / `loc.name` / `loc.id` accessors below
  /// if your actual Locations/Organisation model field names differ.
  Organisation? _findLocationByName(Locations locations, String name) {
    final regions = locations.regions ?? [];
    for (final region in regions) {
      final locs = region.locations ?? [];
      for (final loc in locs) {
        if ((loc.name ?? '').trim().toLowerCase() == name.trim().toLowerCase()) {
          return loc;
        }
      }
    }
    return null;
  }

  /// Returns true if [candidate] is an id/name that genuinely exists in the
  /// fetched [locations] tree. Used to detect and discard stray/default
  /// values (e.g. "Sungard") that don't come from real data.
  bool _isValidFetchedLocation(Locations locations, Organisation? candidate) {
    if (candidate == null) return false;
    final regions = locations.regions ?? [];
    for (final region in regions) {
      final locs = region.locations ?? [];
      for (final loc in locs) {
        if (loc.id != null && loc.id == candidate.id) return true;
        if ((loc.name ?? '').trim().toLowerCase() ==
            (candidate.name ?? '').trim().toLowerCase()) {
          return true;
        }
      }
    }
    return false;
  }

  Future<void> initializeValues() async {

    // Show Loader and emit loading state
    emit(
      state.copyWith(status: FormStatus.loading),
    );

    var userId = await SharedPrefs.getUserId();
    final isNewRecord = state.model.id == null;
    Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();
    final Locations locations =
    await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');
    final int? locationId = state.model.location?.id;

    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getPatrollingRegionsWithLocations(name: 'ATOM_LOCATIONS', patrolling: true),//0
        commonServices.getUserDetails(userId: userId),//1
        // SharedPrefs.getDefaultLocation(),//2
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.ticketingSystemModuleCode),//3
        commonServices.getOrganisations(name: 'ATOM_ENTITIES'),//4

        commonServices.getPatrollingActionOwnerUsers(
          locationId: state.model.location?.id ?? defaultLocation!.id,
            ownerType: state.otherModel.items?.firstOrNull?.ownerType),//5


        commonServices.getPatrollingLSMUsers(
          locationId: state.model.location?.id ?? defaultLocation!.id
        ),//6

        commonServices.getPatrollingSecuritySupervisor(
          locationId: state.model.location?.id ?? defaultLocation!.id
        ),//7

        commonServices.getPatrollingDBSponsor(
          locationId: state.model.location?.id ?? defaultLocation!.id
        ),//8
        // commonServices.getStatusesByModuleId(
        //   module: Constants.ticketingSystemModuleCode,),
        // services.getGenIndoDetails(userId)
        if (isNewRecord)
          services.getGenIndoDetails(userId)
        else Future.value(null),
      ]);//9

      commonServices.getLocationType(locId: locationId!);

    // Locations locations = futures[0];
      // User loggedInUserDetails = futures[1];
      // dynamic responseLabels = futures[2];
      // List<Organisation> getEntities = futures[3];
      // List<BaseUser> getActionOwner = futures[4];
      // List<BaseUser> getLsm = futures[5];
      // List<BaseUser> getSupervisor = futures[6];
      // final PatrollingModel? genInfoModel  = futures[7] as PatrollingModel?;
      Locations locations = futures[0];
      User loggedInUserDetails = futures[1];
      // Organisation? defaultLocation = futures[3];
      dynamic responseLabels = futures[2];
      List<Organisation> getEntities = futures[3];

      final OwnerUserModel actionOwnerResponse = futures[4];
      final LsmUserModel lsmResponse = futures[5];
      final SecuritySupervisorsModel supervisorResponse = futures[6];
      final DbSponsorUserModel dbSponsorResponse = futures[7];
      GetLocationType? getLocationType = futures[8];

      List<BaseUser> getActionOwner = actionOwnerResponse.users
          .map((e) => BaseUser(
        id: e.id,
        name: e.name,
        email: e.email,
        employeeId: e.employeeId,
      ))
          .toList();

      List<BaseUser> getLsm = lsmResponse.lsmUsers
          .map((e) => BaseUser(
        id: e.userId,
        name: e.name,
        email: e.email,
        employeeId: e.employeeId,
      ))
          .toList();

      List<BaseUser> getSupervisor = supervisorResponse.securitySupervisors
          .map((e) => BaseUser(
        id: e.id,
        name: e.name,
        email: e.email,
        employeeId: e.employeeId,
      ))
          .toList();

      List<BaseUser> getDbSponsor = dbSponsorResponse.dbSponsorUsers
          .map((e) => BaseUser(
        id: e.id,
        name: e.name,
        email: e.email,
        employeeId: e.employeeId,
      ))
          .toList();

      final PatrollingModel? genInfoModel = futures[8] as PatrollingModel?;
      // Resolve the real "NKP B1" location from the freshly-fetched tree.
      Organisation? resolvedDefaultLocation =
      _findLocationByName(locations, defaultLocation!.name!);

      // Decide which model is "final" for this screen (mirrors the emit below).
      PatrollingModel finalModel = isNewRecord
          ? (genInfoModel ?? state.model)
          : state.model;

      // Force the correct default location onto the final model whenever:
      //  - it's a new record, OR
      //  - the existing location isn't a real one from the fetched data
      //    (i.e. it's a stray/hardcoded default like "Sungard").
      final bool hasValidExistingLocation =
      _isValidFetchedLocation(locations, finalModel.location);

      if (resolvedDefaultLocation != null &&
          (isNewRecord || !hasValidExistingLocation)) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: resolvedDefaultLocation.id.toString(),
          moduleCode: Constants.patrollingModule,
        );
        finalModel.location = resolvedDefaultLocation;
        finalModel.slNo = slNo.serialNo;
      }

      log('default ${finalModel.location?.name}');

      // Get Date of Creation
      finalModel.inputDate = finalModel.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(finalModel.inputDate ?? '0'),
          Constants.fulldateFormat);


      finalModel.modifiedDate = finalModel.modifiedDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(finalModel.modifiedDate ?? '0'),
          Constants.fulldateFormat);


      finalModel.submittedDate = finalModel.submittedDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(finalModel.submittedDate ?? '0'),
          Constants.fulldateFormat);

      finalModel.verifiedDate = finalModel.verifiedDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(finalModel.verifiedDate ?? '0'),
          Constants.fulldateFormat);

      // PMUiLabels labels = PMUiLabels.fromJson(responseLabels);

      finalModel.entrySecurity ??= loggedInUserDetails;

      emit(
        state.copyWith(
          locations: locations,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          listOfEntities :getEntities,
          lsm: getLsm,
          securitySupervisor:getSupervisor ,
          owner: getActionOwner,
          dbSponsor :getDbSponsor,
          model: finalModel,
          getLocationType: getLocationType,

        ),
      );
    } catch (e) {
      log('Initialization issue',
          error: e, name: 'Patrolling Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
          // TODO: error message should be dynamic
          status: FormStatus.error,
        ),
      );
    }
  }

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    List<Organisation>? listOfModules =
    await commonServices.getOrganisations(name: 'ATOM_MODULES_NAME_LIST');
    emit(
      state.copyWith(
        listOfModules: listOfModules,
        status: FormStatus.initial,
      ),
    );
  }

  void onItemChanged(PatrollingOtherModel otherModel) {
    emit(state.copyWith(
      otherModel: otherModel,
      status: FormStatus.initial,
    ));
  }
  Future<void> updateGetGenInfoModelValue(String? id) async {
    if (state.model.id != null) {
      emit(
        state.copyWith(
          status: FormStatus.loading,
        ),
      );
      PatrollingModel response = await services.getGeneralInfoById(id.toString());
      emit(
        state.copyWith(
          model: response,
          status: FormStatus.initial,
        ),
      );
    }
  }

  void removeAttachment({
    required int itemIndex,
    required ImageContent imageToRemove,
  }) {
    final items = List<Items>.from(state.otherModel.items ?? []);
    if (itemIndex < 0 || itemIndex >= items.length) return;

    final item = items[itemIndex];
    final updatedAttachments = List<ImageContent>.from(item.attachments ?? [])
      ..removeWhere((img) => imageToRemove.id != null
          ? img.id == imageToRemove.id
          : identical(img, imageToRemove));

    item.attachments = updatedAttachments;
    items[itemIndex] = item;

    final updatedOtherModel = state.otherModel;
    updatedOtherModel.items = items;

    // Keep the flat upload-tracking list in sync too, if it's used elsewhere
    // (e.g. to show "recently added" files independent of per-item lists).
    final updatedUploadAttachments =
    List<ImageContent>.from(state.uploadAttachments ?? [])
      ..removeWhere((img) => imageToRemove.id != null
          ? img.id == imageToRemove.id
          : identical(img, imageToRemove));

    emit(
      state.copyWith(
        otherModel: updatedOtherModel,
        uploadAttachments: updatedUploadAttachments,
      ),
    );
  }

  Future<void> updateGetOtherInfoModelValue(String? id, String? subId) async {
    emit(state.copyWith(status: FormStatus.loading));

    final parsedId = int.tryParse(id ?? '');

    if (parsedId != null) {
      // id exists → fetch existing subsection
      PatrollingOtherModel response = await services.getSubSectionById(
        parsedId.toString(),
        subId.toString(),
      );
      state.model.id = parsedId; // stamp id onto model
      emit(state.copyWith(
        otherModel: response,
        model: state.model,
        status: FormStatus.initial,
      ));
    } else {
      // id is null → new record, fetch template only
      PatrollingOtherModel response = await services.getNewSubSectionById(
        subId.toString(),
      );
      emit(state.copyWith(
        otherModel: response,
        status: FormStatus.initial,
      ));
    }
  }
  Future<void> updateLocationDropdownValue({
    Organisation? location,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    GetLocationType? locType = state.getLocationType;


    // Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.patrollingModule,
      );
      final int? locationId = location.id;


      state.model.location = location;
      state.model.slNo = slNo.serialNo;
      locType = await commonServices.getLocationType(locId: locationId!);

    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
      getLocationType: locType,

    ));
  }

  Future<void> updateDropdownValues({
    Organisation? location,
    Organisation? projects,
    Organisation? priority,
    Organisation? trackers,
    BaseUser? lsm,
    BaseUser? securitySupervisor,
    int? status,
    int? severity,
    int? priorityType,
    int? ticketRaisedFor,
    int? ragStatus,
    List<Organisation>? modulesName,
    Organisation? entity,
    Organisation? locationType,


  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );


// Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.ticketingSystemModuleCode,
      );

      state.model.location = location;
      state.model.slNo = slNo.serialNo ?? '';
    }
    if (status != null) {
      state.model.status = status;
    }

    if (locationType != null) {
      state.model.locationType = locationType;
    }
    if ( lsm!= null) {
      state.model.lsm?.employeeId = lsm.employeeId;
      String name = lsm.name ?? '';
      String email = lsm.email ?? '';
      List<String> nameParts = lsm.name!.split(' '); // Split by space
      String? firstName = nameParts.isNotEmpty ? nameParts.first : null;
      String? lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : null;
      User userDetails = User(
        name:name,
        userId : lsm.id,
        email: email,
        employeeId: lsm.employeeId,
        firstName: firstName,
        lastName: lastName,
      );
      state.model.lsm = userDetails;
      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
        ),
      );
    }

    if ( securitySupervisor!= null) {
      state.model.securitySupervisor?.employeeId = securitySupervisor.employeeId;
      String name = securitySupervisor.name ?? '';
      String email = securitySupervisor.email ?? '';
      List<String> nameParts = securitySupervisor.name!.split(' ');
      String? firstName = nameParts.isNotEmpty ? nameParts.first : null;
      String? lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : null;
      User userDetails = User(
        name:name,
        userId : securitySupervisor.id,
        email: email,
        employeeId: securitySupervisor.employeeId,
        firstName: firstName,
        lastName: lastName,
      );
      state.model.securitySupervisor = userDetails;
      emit(
        state.copyWith(
          model: state.model,
          status: FormStatus.initial,
        ),
      );
    }
    if (entity != null) {
      state.model.entity = entity;
    }

    // if(severity !=null){
    // state.otherModel.items = severity;
    // }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }


  Future<void> getOwnerUsers(int locationId, String ownerType) async {
    try {
      final response = await services.getOwnerUser(locationId, ownerType);

      debugPrint("RAW response.users count: ${response.users.length}");

      final users = (response.users)
          .map((e) => BaseUser(
        id: e.id,
        name: e.name,
        email: e.email,
        employeeId: e.employeeId,
      ))
          .toList();

      debugPrint("Mapped users count: ${users.length}");
      for (var u in users) {
        debugPrint("User: ${u.name} | ${u.employeeId}");
      }

      emit(state.copyWith(owner: users));

    } catch (e) {
      debugPrint("Owner API Error: $e");
    }
  }

  void selectOwner(BaseUser user) {
    emit(state.copyWith(
      selectedOwner: user,
    ));
  }

  Future<void> getDbSponsorUsers(int locationId) async {
    try {
      final response = await services.getDbSponsorUser(locationId);

      log("RAW response.users count: ${response.dbSponsorUsers.length}");

      final users = (response.dbSponsorUsers)
          .map((e) => BaseUser(
        id: e.id,
        name: e.name,
        email: e.email,
        employeeId: e.employeeId,
      ))
          .toList();

      debugPrint("Mapped users count: ${users.length}");
      for (var u in users) {
        debugPrint("User: ${u.name} | ${u.employeeId}");
      }

      emit(state.copyWith(dbSponsor: users));

    } catch (e) {
      debugPrint("Owner API Error: $e");
    }
  }

  void selectDbSponsor(BaseUser user) {
    emit(state.copyWith(
      selectedOwner: user,
    ));
  }
  void submitGenInfoForm({bool isSaveOnly = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (state.model.status == 0 || state.model.status == null) {
      state.model.status = 0;
    }

    DateTime dateTime;
    // if (!Utils().isTimestamp(state.model.inputDate!)) {
    //   dateTime =
    //       DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
    //   int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
    //   state.model.inputDate = inputDate.toString();
    // }

    if (!Utils().isTimestamp(state.model.inputDate!)) {
      // Guard: only parse if it looks like a formatted date string, not a number
      if (int.tryParse(state.model.inputDate!) == null) {
        dateTime = DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
        int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
        state.model.inputDate = inputDate.toString();
      } else {
        // It's already a numeric timestamp (ms), convert to seconds
        int ms = int.parse(state.model.inputDate!);
        state.model.inputDate = (ms > 9999999999 ? ms ~/ 1000 : ms).toString();
      }
    }

    // Create/Update API Call
    PatrollingRequestModel request =
    PatrollingRequestModel(patrollingModel: state.model);

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
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
          return;
        }
        response = (await services.createGenInfo(body: request, isSubmit: false));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
          return;
        }
        response = (await services.createGenInfo(
            body: request, isSubmit: true));
      }
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);

    }
    on GenericResponse catch (e) {
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
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

    emit(
      state.copyWith(
        message: response.message,
        status: FormStatus.success,
        model: state.model..id = response.id.toIntOrNull(),
          isSaveOnly: isSaveOnly
      ),
    );
  }

  // void submitForm({bool isSaveOnly = false, String? id, String? subId}) async {
  //   emit(
  //     state.copyWith(
  //       status: FormStatus.loading,
  //     ),
  //   );
  //
  //   if (state.model.status == 0 || state.model.status == null) {
  //     state.model.status = 0;
  //   }
  //
  //   // Create/Update API Call
  //   PatrollingOtherRequestModel request =
  //   PatrollingOtherRequestModel(patrollingOtherModel: state.otherModel);
  //
  //   GenericResponse response = GenericResponse();
  //
  //   try {
  //     if (isSaveOnly) {
  //       if (!state.isValidDraft.status) {
  //         emit(
  //           state.copyWith(
  //             status: FormStatus.formError,
  //             message: state.isValidDraft.message,
  //           ),
  //         );
  //         state.model.inputDate = state.model.inputDate == null
  //             ? Utils().getCurrentDate()
  //             : Utils.timestampToDateConversion(
  //             int.tryParse(state.model.inputDate ?? '0'),
  //             Constants.fulldateFormat);
  //         return;
  //       }
  //       response = (await services.createOtherInfo(body: request, isSubmit: false, id: id.toString(), subId: subId.toString()));
  //     } else {
  //       //Validating Fields
  //       if (!state.isValid.status) {
  //         emit(
  //           state.copyWith(
  //             status: FormStatus.formError,
  //             message: state.isValid.message,
  //           ),
  //         );
  //         state.model.inputDate = state.model.inputDate == null
  //             ? Utils().getCurrentDate()
  //             : Utils.timestampToDateConversion(
  //             int.tryParse(state.model.inputDate ?? '0'),
  //             Constants.fulldateFormat);
  //         return;
  //       }
  //       response = (await services.createOtherInfo(
  //           body: request, isSubmit: true, id:id.toString(), subId: subId.toString()));
  //     }
  //     state.model.inputDate = state.model.inputDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(state.model.inputDate ?? '0'),
  //         Constants.fulldateFormat);
  //
  //   }
  //   on GenericResponse catch (e) {
  //     state.model.inputDate = state.model.inputDate == null
  //         ? Utils().getCurrentDate()
  //         : Utils.timestampToDateConversion(
  //         int.tryParse(state.model.inputDate ?? '0'),
  //         Constants.fulldateFormat);
  //     emit(
  //       state.copyWith(
  //         message: e.message,
  //         status: FormStatus.formError,
  //       ),
  //     );
  //     return;
  //   } on Exception catch (e) {
  //     emit(
  //       state.copyWith(
  //         message: e.toString(),
  //         status: FormStatus.error,
  //       ),
  //     );
  //   }
  //
  //   emit(
  //     state.copyWith(
  //       message: response.message,
  //       status: FormStatus.success,
  //     ),
  //   );
  // }
  //
  Future<bool> submitForm({bool isSaveOnly = false, String? id, String? subId}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (state.model.status == 0 || state.model.status == null) {
      state.model.status = 0;
    }

    // Create/Update API Call
    PatrollingOtherRequestModel request =
    PatrollingOtherRequestModel(patrollingOtherModel: state.otherModel);

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
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
          return false;
        }
        response = (await services.createOtherInfo(
            body: request,
            isSubmit: false,
            id: id.toString(),
            subId: subId.toString()));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
          return false;
        }
        response = (await services.createOtherInfo(
            body: request,
            isSubmit: false,
            id: id.toString(),
            subId: subId.toString()));
      }
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
    } on GenericResponse catch (e) {
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.formError,
        ),
      );
      return false;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
      return false;
    }

    emit(
      state.copyWith(
        message: response.message,
        status: FormStatus.success,
      ),
    );
    return true;
  }

  void updateStatus({required String id}) {
    commonServices.updateRecordStatus(
        id: id, module: Constants.vipVisitorsDetailsModule);
  }


  void addAttachment({List<ImageContent>? files, required int itemIndex}) async {
    emit(state.copyWith(status: FormStatus.loading));
    if (files != null) {
      final items = List<Items>.from(state.otherModel.items ?? []);
      if (itemIndex < items.length) {
        items[itemIndex] = Items.fromJson({
          ...items[itemIndex].toJson(),
          'attachments': files.map((e) => e.toJson()).toList(), // keep key consistent
        });
      }
      emit(state.copyWith(
        otherModel: state.otherModel..items = items,
        status: FormStatus.initial,
      ));
    } else {
      emit(state.copyWith(status: FormStatus.initial));
    }
  }



}