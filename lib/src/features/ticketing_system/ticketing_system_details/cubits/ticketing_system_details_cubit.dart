import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/ticketing_system/models/projects_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/requestModel/ticketing_system_request_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/ticketing_new_list_model.dart';
import 'package:intl/intl.dart';
import '../../models/assignee_model.dart';
import '../../models/priorities_model.dart';
import '../../models/ticketing_system_model.dart';
import '../../models/trackers_model.dart';
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
      eventId: null,
      locations: Locations(),
      listOfModules: const [],
      getStatus: const [],
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

    // if (state.model.location == null && defaultLocation != null) {
    //   String moduleCode = Constants.ticketingSystemModuleCode;
    //   SerialNumberModel slNo = await commonServices.getSlNo(
    //     locationId: defaultLocation.id.toString(),
    //     moduleCode: moduleCode,
    //   );
    //   state.model.location = defaultLocation;
    //   state.model.ticketNo = slNo.serialNo;
    // }

    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'), //0
        commonServices.getUserDetails(userId: userId), //1
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.ticketingSystemModuleCode), //2
        SharedPrefs.getDefaultLocation(), //3
        commonServices.getOrganisations(name: 'ATOM_MODULES_NAME_LIST'), //4
        commonServices.getStatusesByModuleId(
          module: Constants.ticketingSystemModuleCode,
        ), //5
        services.getPriorityList(), //6
        services.getProjects(), //7
        services.getTrackers(), //8
        services.getAssignee(), //8

      ]);
      Locations locations = futures[0];
      User loggedInUserDetails = futures[1];
      dynamic responseLabels = futures[2];
      Organisation? defaultLocation = futures[3];
      List<Organisation> listOfModules = futures[4];
      List<Organisation> getStatus = futures[5];

      // futures[6] resolves to a `Priorities` object, NOT a List<Organisation>.
      Priorities priorityResponse = futures[6];
      List<Organisation> priorityList = priorityResponse.items ?? [];


      Projects projectsResponse = futures[7];
      List<Organisation> projects = projectsResponse.items ?? [];


      Trackers trackerResponse = futures[8];
      List<Organisation> trackers = trackerResponse.items ?? [];

      Assignee assigneeResponse = futures[9];
      List<BaseUser> assignee = assigneeResponse.items ?? [];
      // Get Date of Creation
      state.model.createdOn = state.model.createdOn == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.createdOn ?? '0'),
          Constants.fulldateFormat);

      state.model.startDate = state.model.startDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.startDate ?? '0'),
          Constants.fulldateFormat);

      state.model.dueDate = state.model.dueDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.dueDate ?? '0'),
          Constants.fulldateFormat);

      state.model.updatedOn = state.model.updatedOn == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.updatedOn ?? '0'),
          Constants.fulldateFormat);

      // PMUiLabels labels = PMUiLabels.fromJson(responseLabels);

      state.model.createdBy ??= loggedInUserDetails.userInfo;
      state.model.assigneeName ??= 'support@arlanto.com';

      // Set default priority (e.g. "P3 (Medium)") only if one hasn't
      // already been set (editing an existing ticket keeps its own value).
      if (state.model.priority == null && priorityList.isNotEmpty) {
        state.model.priority = priorityList.firstWhere(
              (item) => item.isDefault == true,
          orElse: () => priorityList.first,
        );
      }

      if (state.model.project == null && projects.isNotEmpty) {
        state.model.project = projects.firstWhere(
              (item) => item.isDefault == true,
          orElse: () => projects.first,
        );
      }

      if (state.model.tracker == null && trackers.isNotEmpty) {
        state.model.tracker = trackers.firstWhere(
              (item) => item.isDefault == true,
          orElse: () => trackers.first,
        );
      }


      if (state.model.id == null && state.model.assignee == null) {
        state.model.assignee?.name = 'Atom Support';
      }
      emit(
        state.copyWith(
            locations: locations,
            loggedInUserDetails: loggedInUserDetails,
            status: FormStatus.initial,
            model: state.model,
            listOfModules: listOfModules,
            getStatus: getStatus,
            priorities: priorityList,
            projects:projects,
        assignee: assignee,
        trackers: trackers),
      );
    } catch (e) {
      log('Initialization issue', error: e, name: 'Ticketing System Cubit');
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
    // int? status,
// Organisation? status,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    if (priority != null) {
      state.model.priority = priority;
    }
    if (trackers != null) {
      state.model.tracker = trackers;
    }
    if (status != null) {
      state.model.status = status;
    }

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

    if (state.model.status == 0 || state.model.status == null) {
      state.model.status = 0;
    }

    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.createdOn!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.createdOn!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.createdOn = inputDate.toString();
    }

    if (!Utils().isTimestamp(state.model.startDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.startDate!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.startDate = inputDate.toString();
    }

    if (!Utils().isTimestamp(state.model.dueDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.dueDate!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.dueDate = inputDate.toString();
    }


    if (!Utils().isTimestamp(state.model.updatedOn!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.updatedOn!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.updatedOn = inputDate.toString();
    }

    if (state.model.assignee == null) {
      state.model.assignee?.name = 'Atom Support';
    }
    // Setting time in milliseconds

    // state.model.startDate = state.model.startDate == null
    //     ? Utils().getCurrentDate()
    //     : Utils().formatUnixTimestamp(state.model.startDate ?? '');

    state.model.createdOn =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

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
          state.model.createdOn = state.model.createdOn == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.createdOn ?? '0'),
              Constants.fulldateFormat);
          state.model.startDate = state.model.startDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.startDate ?? '0'),
              Constants.fulldateFormat);
          return;
        }
        response = (await services.createTicketingSystem(
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
          state.model.createdOn = state.model.createdOn == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.createdOn ?? '0'),
              Constants.fulldateFormat);
          state.model.startDate = state.model.startDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.startDate ?? '0'),
              Constants.fulldateFormat);
          return;
        }
        response = (await services.createTicketingSystem(
            body: request, isSubmit: true));
      }
      state.model.createdOn = state.model.createdOn == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.createdOn ?? '0'),
          Constants.fulldateFormat);
      state.model.startDate = state.model.startDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.startDate ?? '0'),
          Constants.fulldateFormat);
    } on GenericResponse catch (e) {
      state.model.createdOn = state.model.createdOn == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.createdOn ?? '0'),
          Constants.fulldateFormat);
      state.model.startDate = state.model.startDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model.startDate ?? '0'),
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