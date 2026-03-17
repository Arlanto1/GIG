import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/ticketing_system/models/activityNote_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/requestModel/ticketing_system_request_model.dart';
import 'package:intl/intl.dart';
import '../../models/ticketing_system_model.dart';
import '../../services/ticketing_system_services.dart';

part 'ticketing_system_details_state.dart';

class TicketingSystemDetailsCubit extends Cubit<TicketingSystemDetailsState> {
  final TicketingSystemServices services;
  final TicketingSystemModel? model;
  final CommonServices commonServices;

  TicketingSystemDetailsCubit({
    required this.services,
    required this.commonServices,
    this.model,
  }) : super(
          TicketingSystemDetailsState.initial(
            model: model ?? TicketingSystemModel(),
            loggedInUserDetails: User(),
            users: const [],
            errorMessage: '',
            priorities: const [],
            projects: const [],
            trackers: const [],
            eventId: null, locations: Locations(), listOfModules: const [], getStatus: const [],
          ),
        );

  void onModelValueChange(TicketingSystemModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(TicketingSystemModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }


  Future<void> initializeValues() async {

    // Show Loader and emit loading state
    emit(
      state.copyWith(status: FormStatus.loading),
    );

    var userId = await SharedPrefs.getUserId();

    Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();

    if (state.model.location == null && defaultLocation != null) {
      String moduleCode = Constants.ticketingSystemModuleCode;
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: defaultLocation.id.toString(),
        moduleCode: moduleCode,
      );
      state.model.location = defaultLocation;
      state.model.ticketNo = slNo.serialNo;
    }

    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),
        commonServices.getUserDetails(userId: userId),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.ticketingSystemModuleCode),
        SharedPrefs.getDefaultLocation(),
        commonServices.getOrganisations(name: 'ATOM_MODULES_NAME_LIST'),
        commonServices.getStatusesByModuleId(
            module: Constants.ticketingSystemModuleCode,),
      ]);
      Locations locations = futures[0];
      User loggedInUserDetails = futures[1];
      dynamic responseLabels = futures[2];
      Organisation? defaultLocation = futures[3];
      List<Organisation> listOfModules = futures[4];
      List<Organisation> getStatus = futures[5];
      // Get Date of Creation
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);

      state.model.fromDate = state.model.fromDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.fromDate ?? '0'),
          Constants.fulldateFormat);

      state.model.modifiedDate = state.model.modifiedDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.modifiedDate ?? '0'),
          Constants.fulldateFormat);

      // PMUiLabels labels = PMUiLabels.fromJson(responseLabels);


      state.model.createdBy ??= loggedInUserDetails;
      state.model.assignee ??= 'support@arlanto.com';

      emit(
        state.copyWith(
          locations: locations,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          listOfModules:listOfModules,
          getStatus :getStatus,
        ),
      );
    } catch (e) {
      log('Initialization issue',
          error: e, name: 'Article Found Details Cubit');
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
        moduleCode: Constants.dayPassManagementModule,
      );
      state.model.location = location;
      state.model.ticketNo = slNo.serialNo;

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
    BaseUser? assignee,
    int? status,
    int? ticketType,
    int? priorityType,
    int? ticketRaisedFor,
    int? ragStatus,
    List<Organisation>? modulesName,


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
      state.model.ticketNo = slNo.serialNo ?? '';
    }
    if (status != null) {
      state.model.status = status;
    }

    if (ticketType != null) {
      state.model.ticketType = ticketType;
    }

    if (priorityType != null) {
      state.model.priorityType = priorityType;
    }


    if (ticketRaisedFor != null) {
      state.model.issuedForm = ticketRaisedFor;
    }

    if (ragStatus != null) {
      state.model.ragStatus = ragStatus;
    }


    if (modulesName != null) {
      state.model.modulesName = modulesName;
    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void updateActivityNotes(List<ActivityNote> notes) {
    emit(state.copyWith(
      model: model,
      status: FormStatus.loading,
    ));
    state.model.activityNotes = notes;
    emit(
      state.copyWith(
        status: FormStatus.initial,
        model: state.model,
      ),
    );
  }


  void submitForm({bool isSaveOnly = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (state.model.status == 0 || state.model.status == null) {
      state.model.status = 0;
    }

    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.inputDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.inputDate = inputDate.toString();
    }

    // Setting time in milliseconds

    // state.model.startDate = state.model.startDate == null
    //     ? Utils().getCurrentDate()
    //     : Utils().formatUnixTimestamp(state.model.startDate ?? '');

    state.model.fromDate = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();


    // Create/Update API Call
    TicketingSystemRequest request =
        TicketingSystemRequest(ticketingSystemModel: state.model);

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
          state.model.fromDate = state.model.fromDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.fromDate ?? '0'),
              Constants.fulldateFormat);
          return;
        }
        response = (await services.createTicketingSystem(body: request, isSubmit: false));
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
          state.model.fromDate = state.model.fromDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.fromDate ?? '0'),
              Constants.fulldateFormat);
          return;
        }
        response = (await services.createTicketingSystem(
            body: request, isSubmit: true));
      }
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      state.model.fromDate = state.model.fromDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.fromDate ?? '0'),
          Constants.fulldateFormat);
    }
    on GenericResponse catch (e) {
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.inputDate ?? '0'),
          Constants.fulldateFormat);
      state.model.fromDate = state.model.fromDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.fromDate ?? '0'),
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


  void addAttachment({
    List<ImageContent>? data,
    List<ImageContent>? images,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    int eventIds = math.Random.secure().nextInt(5);
    if (data != null) {
      for (ImageContent image in data) {
        image.type = 1;
      }
      log('--data----${data.length}----');

      state.model.attachments = data;
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          uploadAttachments: data,
          status: FormStatus.initial,
        ),
      );
    }

    emit(
      state.copyWith(
        eventId: eventIds,
        model: state.model,
        status: FormStatus.initial,
      ),
    );

    log('--state.status--3--${state.status}----');
  }

}
