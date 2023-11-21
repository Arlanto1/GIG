import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/features/contact_details/models/contact_details_list_response_model.dart';
import 'package:db_atom/src/features/contact_details/models/requestModels/contact_details_gi_request.dart';
import 'package:db_atom/src/features/contact_details/services/contact_details_services.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/features/material_movement/models/quantity_units.dart';
import 'package:db_atom/src/models/image_content.dart';
import 'package:db_atom/src/models/language.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../constants/constants.dart';
import '../../../../enums/form_status.dart';
import '../../../../models/base_user.dart';
import '../../../../models/organisation.dart';
import '../../../../models/responseModels/error_response_validation.dart';
import '../../../../models/responseModels/generic_create_response.dart';
import '../../../createfound/models/emplyee_departments_model.dart';
import '../../../passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';

part 'contact_details_state.dart';

class ContactDetailsCubit extends Cubit<ContactDetailsState> {
  final ContactDetailsServices services;
  final ContactDetailModel? model;
  final CommonServices commonServices;

  ContactDetailsCubit({
    required this.services,
    required this.commonServices,
    this.model,
  }) : super(
          ContactDetailsState.initial(
            model: model ?? ContactDetailModel(),
            locations: Locations(),
            loggedInUserDetails: User(),
            users: const [],
            emailUsers: const [],
            errorMessage: '',
          ),
        );

  void onModelValueChange(ContactDetailModel model) {
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

      User loggedInUserDetails =
          await commonServices.getUserDetails(userId: userId);
      Analyst users =
          await commonServices.getUsersByRole(roleName: 'T1_Analyst');

      // Get Date of Creation
      state.model.inputDate = Utils().getCurrentDate();
      state.model.inputDate =
          DateFormat(Constants.fulldateFormat).format(DateTime.now());

      // log('--getlabels-----}--');
      //
      // MmUiLabels uilabels = await commonServices.getUiLabels(
      //     language: 'en', moduleCode: Constants.materialMovementModuleCode);
      //
      // log('--uilabels-----${uilabels.locale}--');
      // log('--uilabels---2232--${uilabels.locale.status}--');

      GetDepositor emailUsers =
          await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');


      state.model.entrySecurity = loggedInUserDetails;

      log('-emailUsers.atomStaticUser----init--${emailUsers.atomStaticUser?.length}---');
      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          users: users.t1Analyst,
          emailUsers: emailUsers.atomStaticUser,
          approver1Users: emailUsers.atomStaticUser,
          approver2Users: emailUsers.atomStaticUser,
          //  language: uilabels
        ),
      );
    } catch (e) {
      log('initialization issue',
          error: e, name: 'Contact Details Cubit');
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

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }


  Future<void> submitForm({
    bool isSaveOnly = false,
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
    ContactDetailsGiRequest request =
        ContactDetailsGiRequest(cdGi: state.model);

    // TODO: Need to change from Backend- Status should be handled from backend
    state.model.status ??= 0;
    try {
      GenericCreateResponse response = GenericCreateResponse();
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
          return;
        }
        response = await services.createContactDetailsGi(
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
          return;
        }
        response = await services.createContactDetailsGi(
            body: request, isSubmit: true);
      }

      log('---response--msg--${response.message}---');

      emit(
        state.copyWith(
          message: response.message,
          status: FormStatus.success,
        ),
      );
    } on Exception catch (e) {
      state.model.inputDate =
          DateFormat(Constants.fulldateFormat).format(DateTime.now());
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }
  }
}
