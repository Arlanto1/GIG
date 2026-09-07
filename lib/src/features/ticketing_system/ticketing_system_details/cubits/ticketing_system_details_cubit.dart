
import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/ticketing_system/models/projects_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/requestModel/ticketing_system_request_model.dart';
import 'package:intl/intl.dart';
import '../../models/priorities_model.dart';
import '../../models/ticketing_system_model.dart';
import '../../models/trackers_model.dart';
import '../../services/ticketing_system_services.dart';

part 'ticketing_system_details_state.dart';

class TicketingSystemDetailsCubit extends Cubit<TicketingSystemDetailsState> {
  final TicketingSystemServices services;
  final TicketingSystemModel? model;
  final CommonServices commonServices;

  // The fixed "Atom Support" user id, as returned by the assignee API.
  static const int defaultAssigneeId = 22;
  static const String defaultAssigneeName = 'Atom Support';

  // The fixed default project ("ATOM-V2"), as returned by the projects API.
  static const int defaultProjectId = 12;
  static const String defaultProjectName = 'ATOM-V2';

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

  /// Builds the default "Atom Support" User to assign a new ticket to.
  /// Prefers the real record (with correct id) from a fetched assignee
  /// list when available; falls back to a hardcoded id/name otherwise.
  User _buildDefaultAssignee([List<BaseUser>? assigneeList]) {
    if (assigneeList != null) {
      final match = assigneeList.where((u) => u.id == defaultAssigneeId).toList();
      if (match.isNotEmpty) {
        return User()
          ..userId = match.first.id
          ..name = match.first.name;
      }
    }
    return User()
      ..userId = defaultAssigneeId
      ..name = defaultAssigneeName;
  }


  Organisation _buildDefaultProject(List<Organisation> projectsList) {
    final match = projectsList.where((p) => p.id == defaultProjectId).toList();
    if (match.isNotEmpty) {
      return match.first;
    }
    return Organisation(id: defaultProjectId, name: defaultProjectName);
  }

  /// Computes dueDate = startDate + tatMinutes (in Constants.fulldateFormat)
  void _recalculateDueDate(int? tatMinutes) {

    if (tatMinutes == null) {
      log('_recalculateDueDate: tatMinutes is null, aborting', name: 'Ticketing System Cubit');
      return;
    }
    final startDateStr = state.model.startDate;
    if (startDateStr == null || startDateStr.isEmpty) {
      log('_recalculateDueDate: startDate is null/empty, aborting', name: 'Ticketing System Cubit');
      return;
    }

    try {
      DateTime start = DateFormat(Constants.fulldateFormat).parse(startDateStr);
      DateTime due = start.add(Duration(minutes: tatMinutes));
      state.model.dueDate = DateFormat(Constants.fulldateFormat).format(due);
      log('_recalculateDueDate: new dueDate=${state.model.dueDate}', name: 'Ticketing System Cubit');
    } catch (e) {
      log('Failed to recalculate due date', error: e, name: 'Ticketing System Cubit');
    }
  }

  Future<void> initializeValues() async {
    // Show Loader and emit loading state
    emit(
      state.copyWith(status: FormStatus.loading),
    );

    var userId = await SharedPrefs.getUserId();

    Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();

    try {
      // Each call is individually guarded so ONE failing endpoint
      // (e.g. a 404 with an empty body causing a FormatException)
      final futures = await Future.wait([
        commonServices
            .getRegionsWithLocations(name: 'ATOM_LOCATIONS') //0
            .catchError((e) {
          log('getRegionsWithLocations failed', error: e, name: 'Ticketing System Cubit');
          return Locations();
        }),
        commonServices.getUserDetails(userId: userId).catchError((e) { //1
          log('getUserDetails failed', error: e, name: 'Ticketing System Cubit');
          return User();
        }),
        commonServices
            .getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.ticketingSystemModuleCode) //2
            .catchError((e) {
          log('getUiLabels failed', error: e, name: 'Ticketing System Cubit');
          return null;
        }),
        SharedPrefs.getDefaultLocation(), //3
        commonServices
            .getOrganisations(name: 'ATOM_MODULES_NAME_LIST') //4
            .catchError((e) {
          log('getOrganisations(modules) failed', error: e, name: 'Ticketing System Cubit');
          return <Organisation>[];
        }),
        commonServices
            .getStatusesByModuleId(
          module: Constants.ticketingSystemModuleCode,
        ) //5
            .catchError((e) {
          log('getStatusesByModuleId failed', error: e, name: 'Ticketing System Cubit');
          return <Organisation>[];
        }),
        services.getPriorityList().catchError((e) { //6
          log('getPriorityList failed', error: e, name: 'Ticketing System Cubit');
          return Priorities(items: []);
        }),
        services.getProjects().catchError((e) { //7
          log('getProjects failed', error: e, name: 'Ticketing System Cubit');
          return Projects(items: []);
        }),
        services.getTrackers().catchError((e) { //8
          log('getTrackers failed', error: e, name: 'Ticketing System Cubit');
          return Trackers(items: []);
        }),
      ]);

      Locations locations = futures[0];
      User loggedInUserDetails = futures[1];
      dynamic responseLabels = futures[2];
      Organisation? defaultLoc = futures[3];
      List<Organisation> listOfModules = futures[4];
      List<Organisation> getStatus = futures[5];

      // futures[6] resolves to a `Priorities` object, NOT a List<Organisation>.
      Priorities priorityResponse = futures[6];
      List<Organisation> priorityList = priorityResponse.items ?? [];

      Projects projectsResponse = futures[7];
      List<Organisation> projects = projectsResponse.items ?? [];

      Trackers trackerResponse = futures[8];
      List<Organisation> trackers = trackerResponse.items ?? [];

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

      // NEW: seed dueDate from the (just-resolved) priority's tatMinutes,
      // but only for a brand-new ticket so an existing ticket's saved
      // dueDate is never overwritten on load.
      if (state.model.id == null) {
        _recalculateDueDate(state.model.priority?.tatMinutes);
      }

      // if (state.model.project == null && projects.isNotEmpty) {
      //   state.model.project = projects.firstWhere(
      //         (item) => item.isDefault == true,
      //     orElse: () => projects.first,
      //   );
      // }

      if (state.model.tracker == null && trackers.isNotEmpty) {
        state.model.tracker = trackers.firstWhere(
              (item) => item.isDefault == true,
          orElse: () => trackers.first,
        );
      }

      // Assignee list depends on the resolved project, so fetch it
      // separately (also guarded) once we know the project.
      List<BaseUser> assignee = [];
      if (state.model.project != null) {
        try {
          final assigneeResponse = await services.getAssignee(
            int.tryParse(state.model.project!.id.toString()) ?? 0,
            state.model.project!.name ?? '',
          );
          assignee = assigneeResponse.items ?? [];
        } catch (e) {
          log('Failed to load assignees', error: e, name: 'Ticketing System Cubit');
        }
      }

      // Now we assign a real default User with the correct id (22) so it
      // round-trips correctly through the create/update API.
      if (state.model.id == null && state.model.assignee == null) {
        state.model.assignee = _buildDefaultAssignee(assignee);
      }

      if (state.model.id == null && state.model.project == null) {
        state.model.project = _buildDefaultProject(projects);
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
          projects: projects,
          assignee: assignee,
          trackers: trackers,
        ),
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
  }) async {
    emit(state.copyWith(status: FormStatus.loading));

    if (priority != null) {
      state.model.priority = priority;
      // NEW: whenever the priority dropdown changes, recompute
      // dueDate = startDate + priority.tatMinutes so the UI reflects it.
      _recalculateDueDate(priority.tatMinutes);
    }
    if (trackers != null) {
      state.model.tracker = trackers;
    }
    if (status != null) {
      state.model.status = status;
    }
    if (assignee != null) {
      // assignee (picked from dropdown) is BaseUser; state.model.assignee is User.
      state.model.assignee = (state.model.assignee ?? User())
        ..userId = assignee.id
        ..name = assignee.name;
    }

    List<BaseUser>? newAssigneeList;
    if (projects != null) {
      state.model.project = projects;
      // Project changed -> assignee options depend on the project, refetch.
      try {
        final assigneeResponse = await services.getAssignee(
          int.tryParse(projects.id.toString()) ?? 0,
          projects.name ?? '',
        );
        newAssigneeList = assigneeResponse.items ?? [];
      } catch (e) {
        log('Failed to refresh assignees', error: e, name: 'Ticketing System Cubit');
        newAssigneeList = [];
      }
      // Reset to default (Atom Support, id 22) until the user explicitly
      // picks someone for the new project.
      state.model.assignee = _buildDefaultAssignee(newAssigneeList);
    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
      assignee: newAssigneeList ?? state.assignee,
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

    // Same fix as initializeValues — assign a real default User (id 22,
    // "Atom Support") instead of a no-op `?.name =` on a null reference.
    // We don't have the freshly-fetched assignee list here, so fall back
    // to the hardcoded id/name.
    if (state.model.id == null && state.model.assignee == null) {
      state.model.assignee = _buildDefaultAssignee();
    }

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