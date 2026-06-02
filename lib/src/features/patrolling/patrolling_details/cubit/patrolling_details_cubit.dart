import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/patrolling/models/patrolling_model.dart';
import 'package:db_atom/src/features/patrolling/models/patrolling_other_model.dart';
import 'package:db_atom/src/features/patrolling/models/requestModel/patrolling_other_request.dart';
import 'package:db_atom/src/features/patrolling/models/requestModel/patrolling_request_model.dart';
import 'package:db_atom/src/features/patrolling/services/patrolling_service.dart';
import 'package:intl/intl.dart';

part 'patrolling_details_state.dart';

class PatrollingDetailsCubit extends Cubit<PatrollingDetailsState> {
  final PatrollingService services;
  final PatrollingModel? model;
  final CommonServices commonServices;
  final PatrollingOtherModel? otherModel;

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
    ),
  );

  void onModelValueChange(PatrollingModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(PatrollingModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }


  Future<void> initializeValues() async {

    // Show Loader and emit loading state
    emit(
      state.copyWith(status: FormStatus.loading),
    );

    var userId = await SharedPrefs.getUserId();
    final isNewRecord = state.model.id == null;

    Organisation? defaultLocation = await SharedPrefs.getPDefaultLocation(Constants.patrollingModule);

    log('default ${defaultLocation?.name}');
    if (state.model.location == null && defaultLocation != null) {
      String moduleCode = Constants.patrollingModule;
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: defaultLocation.id.toString(),
        moduleCode: moduleCode,
      );
      state.model.location = defaultLocation;
      state.model.slNo = slNo.serialNo;
    }

    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),
        commonServices.getUserDetails(userId: userId),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.ticketingSystemModuleCode),
        SharedPrefs.getPDefaultLocation(Constants.patrollingModule),
        commonServices.getOrganisations(name: 'ATOM_MODULES_NAME_LIST'),
        commonServices.getOrganisations(name: 'PATROLLING_ENTITIES'),
        commonServices.getBaseUsers(
            roleName: ConstantUserRoles.atomSecurityAndSeniorSecurityManagerUser,
            isDbUser: true,
         ),
        // commonServices.getStatusesByModuleId(
        //   module: Constants.ticketingSystemModuleCode,),
          // services.getGenIndoDetails(userId)
        if (isNewRecord)
          services.getGenIndoDetails(userId)
        else Future.value(null),
      ]);
      Locations locations = futures[0];
      User loggedInUserDetails = futures[1];
      dynamic responseLabels = futures[2];
      Organisation? defaultLocation = futures[3];
      List<Organisation> listOfModules = futures[4];
      List<Organisation> getEntities = futures[5];
      List<BaseUser> getLsm = futures[6];
      final PatrollingModel? genInfoModel  = futures[7] as PatrollingModel?;

      // Get Date of Creation
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);


      state.model.modifiedDate = state.model.modifiedDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.modifiedDate ?? '0'),
          Constants.fulldateFormat);


      state.model.submittedDate = state.model.submittedDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.submittedDate ?? '0'),
          Constants.fulldateFormat);

      state.model.verifiedDate = state.model.verifiedDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.verifiedDate ?? '0'),
          Constants.fulldateFormat);

      // PMUiLabels labels = PMUiLabels.fromJson(responseLabels);


      state.model.entrySecurity ??= loggedInUserDetails;

      emit(
        state.copyWith(
          locations: locations,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          // model: state.model,
          listOfModules:listOfModules,
          listOfEntities :getEntities,
          lsm: getLsm,
          model: isNewRecord ? genInfoModel : state.model,
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

  // Future<void> updateGetOtherInfoModelValue(String? id, String? subId) async {
  //   if (id != null) {
  //     emit(state.copyWith(status: FormStatus.loading));
  //
  //     try {
  //       PatrollingOtherModel response = await services.getSubSectionById(
  //           id.toString(), subId.toString());
  //       emit(state.copyWith(otherModel: response, status: FormStatus.initial));
  //     } on Exception catch (e) {
  //       // ✅ API failed (no record) — create empty model with subsectionId
  //       // so PatrollingOtherView still loads with patrollingId + subsectionId
  //       emit(state.copyWith(
  //         otherModel: PatrollingOtherModel(
  //           patrollingId: int.tryParse(id),
  //           subsectionId: int.tryParse(subId ?? ''),
  //           items: [], // empty — view will show empty state or you can prefill
  //         ),
  //         status: FormStatus.initial,
  //       ));
  //     }
  //   }
  // }
  // Future<void> updateGetOtherInfoModelValue(String? id, String? subId) async {
  //   if (id != null) {
  //     emit(
  //       state.copyWith(
  //         status: FormStatus.loading,
  //       ),
  //     );
  //     PatrollingOtherModel response = await services.getSubSectionById(id.toString(),subId.toString());
  //     emit(
  //       state.copyWith(
  //         otherModel: response,
  //         status: FormStatus.initial,
  //       ),
  //     );
  //   }
  //   else{
  //     emit(
  //       state.copyWith(
  //         status: FormStatus.loading,
  //       ),
  //     );
  //     PatrollingOtherModel response = await services.getNewSubSectionById(subId.toString());
  //     emit(
  //       state.copyWith(
  //         otherModel: response,
  //         status: FormStatus.initial,
  //       ),
  //     );
  //   }
  // }


  // Future<void> updateGetOtherInfoModelValue(String? id, String? subId) async {
  //   if (state.model.id != null) {
  //     emit(state.copyWith(status: FormStatus.loading));
  //     PatrollingOtherModel response = await services.getSubSectionById(id.toString(), subId.toString());
  //
  //     //  stamp the patrolling id onto state.model so submitForm can read it
  //     state.model.id = int.tryParse(id!);
  //
  //     emit(state.copyWith(
  //       otherModel: response,
  //       model: state.model, //  emit updated model too
  //       status: FormStatus.initial,
  //     ));
  //   } else {
  //     emit(state.copyWith(status: FormStatus.loading));
  //     PatrollingOtherModel response = await services.getNewSubSectionById(subId.toString());
  //     emit(state.copyWith(otherModel: response, status: FormStatus.initial));
  //   }
  // }

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


    // Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.patrollingModule,
      );
      state.model.location = location;
      state.model.slNo = slNo.serialNo;

    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
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
      List<String> nameParts = securitySupervisor.name!.split(' '); // Split by space
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

      debugPrint("RAW response.users count: ${response.users.length}"); // ✅ add this

      final users = (response.users)
          .map((e) => BaseUser(
        id: e.id,
        name: e.name,
        email: e.email,
        employeeId: e.employeeId,
      ))
          .toList();

      debugPrint("Mapped users count: ${users.length}"); // ✅ add this
      for (var u in users) {
        debugPrint("User: ${u.name} | ${u.employeeId}"); // ✅ add this
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

    // Setting time in milliseconds

    // state.model.startDate = state.model.startDate == null
    //     ? Utils().getCurrentDate()
    //     : Utils().formatUnixTimestamp(state.model.startDate ?? '');


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
      ),
    );
  }

  void submitForm({bool isSaveOnly = false, String? id, String? subId}) async {
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
          return;
        }
        response = (await services.createOtherInfo(body: request, isSubmit: false, id: id.toString(), subId: subId.toString()));
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
        response = (await services.createOtherInfo(
            body: request, isSubmit: false, id:id.toString(), subId: subId.toString()));
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
      ),
    );
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

  // void addAttachment({
  //   List<ImageContent>? files,
  //   required int itemIndex,
  // }) async {
  //   emit(state.copyWith(status: FormStatus.loading));
  //
  //   if (files != null) {
  //     final items = state.otherModel.items ?? [];
  //     if (itemIndex < items.length) {
  //       items[itemIndex].attachments = files;
  //     }
  //     emit(state.copyWith(
  //       otherModel: state.otherModel,
  //       status: FormStatus.initial,
  //     ));
  //   } else {
  //     emit(state.copyWith(status: FormStatus.initial));
  //   }
  // }

}
