import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
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
      emailUsers: const [],
      errorMessage: '',
      priorities: const [],
      loadAttachments: const [],
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
    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
        loadAttachments: state.model.attachments,
      ),
    );
    var userId = await SharedPrefs.getUserId();
    try {
      User loggedInUserDetails =
      await commonServices.getUserDetails(userId: userId);

      // state.model.inputDate = state.model.inputDate == null
      //     ? Utils().getCurrentDate()
      //     : Utils.timestampToDateConversion(
      //     int.tryParse(state.model.inputDate ?? '0'),
      //     Constants.fulldateFormat);
      //
      // // Get Date of Creation
      // // state.model.inputDate = Utils().getCurrentDate();
      // state.model.modifiedDate = Utils().getCurrentDate();

      // state.model.inputDate =
      //     (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.slaViolationPenaltyDetailsModuleCode);
      SlaUiLabels labels = SlaUiLabels.fromJson(responseLabels);

      // if (state.model.location == null) {
      //   Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();
      //   if (defaultLocation != null) {
      //     SerialNumberModel slNo = await commonServices.getSlNo(
      //       locationId: defaultLocation.id.toString(),
      //       moduleCode: Constants.vipVisitorsDetailsModule,
      //     );
      //     state.model.location = defaultLocation;
      //     state.model.slNo = slNo.serialNo;
      //   }
      // }

      // state.model.entrySecurity ??= loggedInUserDetails;
      // state.model.modifiedBy ??= (loggedInUserDetails.firstName ?? "") +
      //     (loggedInUserDetails.lastName ?? "");

      emit(
        state.copyWith(
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          labels: labels,
          loadAttachments: state.model.attachments,
        ),
      );
    } catch (e) {
      log('initialization issue', error: e, name: 'VVIP Visitor Details Cubit');
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

    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.createdOn!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.createdOn!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.createdOn = inputDate.toString();
    }
    // Create/Update API Call
    TicketingSystemRequest request = TicketingSystemRequest(ticketingSystemModel: state.model);

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
        response =
        await services.createTicketingSystem(body: request);
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
        response =
        await services.createTicketingSystem(body: request);
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

  void addAttchment(List<ImageContent>? data) async {
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