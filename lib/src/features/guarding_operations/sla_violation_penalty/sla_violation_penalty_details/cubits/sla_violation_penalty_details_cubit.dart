import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/features/contact_details/models/contact_details_list_response_model.dart';
import 'package:db_atom/src/features/contact_details/models/requestModels/contact_details_gi_request.dart';
import 'package:db_atom/src/features/contact_details/services/contact_details_services.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../constants/constants.dart';
import '../../../../../enums/form_status.dart';
import '../../../../../models/base_user.dart';
import '../../../../../models/organisation.dart';
import '../../../../../models/responseModels/error_response_validation.dart';
import '../../../../../models/responseModels/generic_response.dart';
import '../../../../createfound/models/vendors_model.dart';
import '../../../../lawenforcement/models/addentities.dart';
import '../../../../passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import '../../models/requestModels/sla_violation_penalty_request.dart';
import '../../models/sla_violation_penalty_response_model.dart';
import '../../services/sla_violation_penalty_services.dart';

part 'sla_violation_penalty_details_state.dart';

class SLAViolationPenaltyDetailsCubit extends Cubit<SLAViolationPenaltyDetailsState> {
  final SLAViolationPenaltyServices services;
  final SLAViolationPenaltyModel? model;
  final CommonServices commonServices;

  SLAViolationPenaltyDetailsCubit({
    required this.services,
    required this.commonServices,
    this.model,
  }) : super(
    SLAViolationPenaltyDetailsState.initial(
      model: model ?? SLAViolationPenaltyModel(),
      locations: Locations(),
      loggedInUserDetails: User(),
      users: const [],
      emailUsers: const [],
      listOfEntities: const [],
      vendors: const [],
      errorMessage: '',
    ),
  );

  void onModelValueChange(SLAViolationPenaltyModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }
  void onCheckBoxChange(SLAViolationPenaltyModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<void> initializeValues() async {
    log('-status-1-${state.status}--');
    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    var userId = await SharedPrefs.getUserId();
    try {
      Locations getLocationsData =
      await commonServices.getLocations(name: 'ATOM_LOCATIONS');

      AddEntities entities =
      await commonServices.getEntities(name: 'ATOM_ENTITIES');

      Vendors vendors = await commonServices.getVendors(name: 'ATOM_VENDORS');

      User loggedInUserDetails =
      await commonServices.getUserDetails(userId: userId);
      Analyst users =
      await commonServices.getUsersByRole(roleName: 'T1_Analyst');

      // Get Date of Creation
      state.model.inputDate = Utils().getCurrentDate();
      state.model.inputDate =
          DateFormat(Constants.fulldateFormat).format(DateTime.now());

      if (state.model.location == null) {
        Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();
        if (defaultLocation != null) {
          SerialNumberModel slNo = await commonServices.getSlNo(
            locationId: defaultLocation.id.toString(),
            moduleCode: Constants.eventProtectionModule,
          );
          state.model.location = defaultLocation;
          state.model.slNo = slNo.serialNo;
        }
      }

      state.model.entrySecurity = loggedInUserDetails;

      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          users: users.t1Analyst,
          listOfEntities: entities.atomEntities,
          vendors: vendors.items,

        ),
      );
    } catch (e) {
      log('initialization issue', error: e, name: 'Contact Details Cubit');
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
    List<Organisation>? entities,
    List<Organisation>? vendors,
    Organisation? location,
    BaseUser? user,
    BaseUser? approver,
    BaseUser? receiverEmailUser,
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
        moduleCode: Constants.contactDetailsModule,
      );
      state.model.location = location;
      state.model.slNo = slNo.serialNo;
    }
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: location.id.toString(),
          moduleCode: Constants.contactDetailsModule);
      state.model.location = location;
      state.model.slNo = slNo.serialNo;
    }
    if (entities != null) {
      state.model.entity = entities;
    }
    if (vendors != null) {
      state.model.vendor = vendors;
    }
    if (user != null) {
      User userDetails = User(
        name: user.name,
        userId: user.id,
        userName: user.name,
      );
      state.model.entrySecurity = userDetails;
    }

    if (user != null) {
      User userDetails = User(
        name: user.name,
        userId: user.id,
        userName: user.name,
      );
      state.model.approver = userDetails;
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
    state.model.inputDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    // Create/Update API Call
    SLAViolationPenaltyRequest request =
    SLAViolationPenaltyRequest(svpGi: state.model);

    // TODO: Need to change from Backend- Status should be handled from backend
    state.model.status ??= 0;
    try {
      GenericResponse response = GenericResponse();
      if (isSaveOnly) {
        //Validating Fields
        if (!state.isValidDraft.status) {
          state.model.inputDate =
              DateFormat(Constants.fulldateFormat).format(DateTime.now());
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValidDraft.message,
            ),
          );
          return false;
        }
        response = await services.createSLAViolationPenaltyGi(
            body: request, isSubmit: false);
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          state.model.inputDate =
              DateFormat(Constants.fulldateFormat).format(DateTime.now());
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValid.message,
            ),
          );
          return false;
        }
        response = await services.createSLAViolationPenaltyGi(
            body: request, isSubmit: true);
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
      return true;
    } on Exception catch (e) {
      state.model.inputDate =
          DateFormat(Constants.fulldateFormat).format(DateTime.now());
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
      return false;
    }
  }
}
