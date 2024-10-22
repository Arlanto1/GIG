import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/ticketing_system/models/projects_model.dart';
import 'package:db_atom/src/features/ticketing_system/models/requestModel/ticketing_system_request_model.dart';
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
            loadAttachments: const [], projects: [],
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

    var userId = await SharedPrefs.getUserId();

    // Initialize model outside of Future.wait
    // AnnualPowerShutdownListModel model = id.isNotEmpty
    //     ? await services.getById(id)
    //     : AnnualPowerShutdownListModel();

    try {
      // Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();
      //
      // if (model.location == null && defaultLocation != null) {
      //   SerialNumberModel slNo = await commonServices.getSlNo(
      //     locationId: defaultLocation.id.toString(),
      //     moduleCode: Constants.annualPowerShutDownModuleCode,
      //   );
      //   model.location = defaultLocation;
      //   model.slNo = slNo.serialNo;
      // }

      // Perform multiple asynchronous operations concurrently
      final List<dynamic> results = await Future.wait([
        services.getProjects(),
        services.getAssigneeList(),
        // commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),
        // // TODO: remove the and change the number
        // SharedPrefs.getDefaultLocation(),
        // commonServices.getUserDetails(userId: userId),
        // commonServices.getUiLabels(
        //     language: await SharedPrefs.getLanguageCode(),
        //     moduleCode: Constants.eventProtectionModuleCode),
        // // commonServices.getUsersByRole(roleName: 'T1_Analyst'),
        // commonServices.getBaseUsers(
        //     roleName: ConstantUserRoles.atomStaticUser,
        //     isDbUser: true,
        //     locationId: model.location!.id!),
        // commonServices.getOrganisations(name: 'ATOM_ENTITIES'),
        // commonServices.getVendors(name: 'ATOM_VENDORS'),
        // commonServices.getUsers(),
        // commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS'),
        // commonServices.getBaseUsers(
        //     roleName: ConstantUserRoles.atomSubRegionalHeadUser,
        //     isDbUser: true,
        //     locationId: model.location!.id!),
        // commonServices.getBaseUsers(
        //     roleName:
        //     ConstantUserRoles.atomSecurityAndSeniorSecurityManagerUser,
        //     isDbUser: true,
        //
        //     locationId: model.location!.id!),
      ]);

      // Assign results to variables with explicit data types
      Projects projects = results[0];
      // List<BaseUser>? emailUsers = results[1];
      // Locations getLocationsData = results[0];
      // Organisation? defaultLocationRemove =
      // results[1]; // TODO: remove the and change the number
      // User loggedInUserDetails = results[2];
      // // Analyst users = results[4];
      // List<BaseUser>? emailUsers = results[4];
      // List<Organisation>? entities = results[5];
      // Vendors vendors = results[6];
      // List<User> entrySecurities = results[7];
      // EmployeeDepartments departments = results[8];
      // List<BaseUser>? srh = results[9];
      // List<BaseUser>? lsm = results[10];

      // model.inputDate = model.inputDate == null
      //     ? Utils().getCurrentDate()
      //     : Utils().formatUnixTimestamp(model.inputDate ?? '');

      // model.inputDate = model.inputDate == null
      //     ? Utils().getCurrentDate()
      //     : Utils.timestampToDateConversion(
      //     int.tryParse(model.inputDate ?? '0'), Constants.fulldateFormat);
      //
      // model.createdBy ??= loggedInUserDetails;
      // state.model.proposedVendors ??= [];
      // Update the model and emit the updated state
      emit(state.copyWith(
        model: model,
        // locations: getLocationsData,
        // loggedInUserDetails: loggedInUserDetails,
        status: FormStatus.initial,
        // srh: srh,
        // lsm: lsm,
        // users: emailUsers,
        // epOfficers: emailUsers,
        // departments: departments.employeeDepartments,
        projects: projects.items,
        // entrySecurities: entrySecurities,
        // listOfEntities: entities,
        // getEntitiesResponse: entities,
        // labels: EpUiLabels.fromJson(responseLabels),
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
    BaseUser? user,
    Organisation? projects,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    // Get Sl No from API
    // if (location != null) {
    //   SerialNumberModel slNo = await commonServices.getSlNo(
    //     locationId: location.id.toString(),
    //     moduleCode: Constants.vipVisitorsDetailsModule,
    //   );
    //   state.model.location = location;
    //   state.model.slNo = slNo.serialNo;
    // }
    // if (location != null) {
    //   SerialNumberModel slNo = await commonServices.getSlNo(
    //       locationId: location.id.toString(),
    //       moduleCode: Constants.vipVisitorsDetailsModule);
    //   state.model.location = location;
    //   state.model.slNo = slNo.serialNo;
    // }

    state.model.project =
        projects ?? state.model.project;
    if (user != null) {
      User userDetails = User(
        name: user.name,
        userId: user.id,
        userName: user.name,
      );
      state.model.assignee = userDetails;
    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  Future<bool> submitForm({
    bool isSaveOnly = false,
    bool navigateToNextScreen = false,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    // Setting time in milliseconds
    // state.model.inputDate =
    //     (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    // DateTime dateTime;
    // if (!Utils().isTimestamp(state.model.startDate!)) {
    //   dateTime =
    //       DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.startDate!);
    //   int startDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
    //   state.model.startDate = startDate.toString();
    // }

    state.model.startDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    state.model.updatedOn =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    // Create/Update API Call
    TicketingSystemRequest request =
        TicketingSystemRequest(ticketingSystemModel: state.model);

    // TODO: Need to change from Backend- Status should be handled from backend
    state.model.status ??= 0;
    try {
      GenericResponse response = GenericResponse();
      if (isSaveOnly) {
        //Validating Fields
        if (!state.isValidDraft.status) {
          state.model.createdOn = state.model.createdOn == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
                  int.tryParse(state.model.createdOn ?? '0'),
                  Constants.fulldateFormat);
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValidDraft.message,
            ),
          );
          return false;
        }
        response = await services.createTicketingSystem(body: request);
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          state.model.createdOn = state.model.createdOn == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
                  int.tryParse(state.model.createdOn ?? '0'),
                  Constants.fulldateFormat);
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return false;
        }
        response = await services.createTicketingSystem(body: request);
      }

      log('---response--msg--${response.message}---');

      if (response.id != null) {
        int? id = int.tryParse(response.id!);
        if (id != null) {
          state.model.id = id;
        }
      }
      emit(
        state.copyWith(
          model: state.model,
          message: response.message,
          status: navigateToNextScreen
              ? FormStatus.navigateToNextScreen
              : FormStatus.success,
        ),
      );
      state.model.createdOn = state.model.createdOn == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.createdOn ?? '0'),
              Constants.fulldateFormat);
      return true;
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      state.model.createdOn = state.model.createdOn == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.createdOn ?? '0'),
              Constants.fulldateFormat);
      return false;
    } on Exception catch (e) {
      state.model.createdOn = state.model.createdOn == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.createdOn ?? '0'),
              Constants.fulldateFormat);
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
      return false;
    }
  }

  void updateStatus({required String id}) {
    commonServices.updateRecordStatus(
        id: id, module: Constants.vipVisitorsDetailsModule);
  }

  void addAttachment(List<ImageContent>? data) async {
    log('--state.status-1---${state.status}----');
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    int eventIds = math.Random.secure().nextInt(5);
    if (data != null) {
      for (ImageContent image in data) {
        image.type = 0;
      }
      log('--data----${data.length}----');

      state.model.attachments = data;
      emit(
        state.copyWith(
          model: state.model,
          loadAttachments: data,
          status: FormStatus.initial,
        ),
      );

      log('--state.status--3--${state.status}----');
    }
  }
}
