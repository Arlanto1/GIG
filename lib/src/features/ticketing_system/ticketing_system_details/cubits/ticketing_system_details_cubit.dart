import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/ticketing_system/models/assignee_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/priority_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/projects_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/requestModel/ticketing_system_request_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/trackers_model.dart';
import 'package:intl/intl.dart';

// import '../../models/requestModels/ticketing_system_request_model.dart';
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
            attachments: const [],
            projects: const [],
            trackers: const [],
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
    log('-status-1-${state.status}--');
    // Show Loader and emit loading state
    emit(state.copyWith(status: FormStatus.loading));

log('StartDate ${state.model.startDate}');
    log('StartDate1 ${Utils().getCurrentDate()}');

    // state.model.startDate = state.model.startDate ?? Utils().getCurrentDate();
    state.model.startDate = state.model.startDate == null
        ? Utils().getCurrentDate()
        : Utils().formatUnixTimestamp(state.model.startDate ?? '');

    var userId = await SharedPrefs.getUserId();
    try {
      // Perform multiple asynchronous operations concurrently
      final List<dynamic> results = await Future.wait([
        services.getProjects(),
        services.getPriorities(),
        services.getAssignee(),
        services.getTrackers(),
      ]);

      // Assign results to variables with explicit data types
      Projects projects = results[0];
      Priorities priorities = results[1];
      Assignee assignee = results[2];
      Trackers trackers = results[3];
      emit(state.copyWith(
        model: model,
        status: FormStatus.initial,
        projects: projects.items,
        priorities: priorities.items,
        assignee: assignee.items,
        trackers: trackers.items,
      ));
    } catch (e) {
      log('initialization issue', error: e, name: 'General Information Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
          // TODO: error message should be dynamic
          status: FormStatus.error,
        ),
      );
    }
  }

  Future<void> updateDropdownValues({
    Organisation? location,
    Organisation? projects,
    Organisation? priority,
    Organisation? trackers,
    BaseUser? assignee,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    state.model.project = projects ?? state.model.project;
    if (projects == null && state.model.project == null) {
      state.model.project =
          Organisation(id: 8); // Set default Organisation if needed
    }

    state.model.priority = priority ?? state.model.priority;

    if (priority == null && state.model.priority == null) {
      state.model.priority =
          Organisation(id: 1); // Set default Organisation if needed
    }
    state.model.tracker = trackers ?? state.model.tracker;

    if (trackers == null && state.model.tracker == null) {
      state.model.tracker =
          Organisation(id: 1); // Set default Organisation if needed
    }

    if (assignee != null) {
      User userDetails = User(
        name: assignee.name,
        userId: assignee.id,
        // userName: assignee.name,
      );
      state.model.assignee = userDetails;
    }
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void submitForm() async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (state.model.status == 0 || state.model.status == null) {
      state.model.status = 0;
    }
    // Setting time in milliseconds

    // state.model.startDate = state.model.startDate == null
    //     ? Utils().getCurrentDate()
    //     : Utils().formatUnixTimestamp(state.model.startDate ?? '');

    state.model.startDate = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();


    // Create/Update API Call
    TicketingSystemRequest request =
        TicketingSystemRequest(ticketingSystemModel: state.model);

    GenericResponse response = GenericResponse();
    try {
      if (!state.isValidDraft.status) {
        emit(
          state.copyWith(
            status: FormStatus.formError,
            message: state.isValidDraft.message,
          ),
        );
        return;
      }
      response = (await services.createTicketingSystem(body: request));
    } on GenericResponse catch (e) {
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

  void addAttachment(
      {List<ImageContent>? data, List<ImageContent>? attachment}) async {
    log('--state.status-1---${state.status}----');
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    int eventIds = math.Random.secure().nextInt(5);
    if (data != null) {
      // for (ImageContent image in data) {
      //   image.type = 0;
      // }
      state.model.attachments = data;
      emit(
        state.copyWith(
          model: state.model,
          attachments: data,
          status: FormStatus.initial,
        ),
      );
    }
  }
}
