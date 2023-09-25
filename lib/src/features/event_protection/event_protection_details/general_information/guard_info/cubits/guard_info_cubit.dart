import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';
import 'package:db_atom/src/features/lawenforcement/models/addQualifications.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/models/base_user.dart';
import 'package:db_atom/src/models/department.dart';
import 'package:db_atom/src/models/entity.dart';
import 'package:db_atom/src/models/location.dart';
import 'package:db_atom/src/models/responseModels/error_response_validation.dart';
import 'package:db_atom/src/models/responseModels/generic_creat_response.dart';
import 'package:db_atom/src/services/CommonServices.dart';

import 'package:equatable/equatable.dart';

import '../../../../../../models/entry_security.dart';
import '../models/guard_info_model.dart';

part 'guard_info_state.dart';

class GuardInfoCubit extends Cubit<GuardInfoState> {
  final EventProtectionServices services;
  final String id;
  final CommonServices commonServices;

  GuardInfoCubit({
    required this.services,
    required this.commonServices,
    required this.id,
  }) : super(
          GuardInfoState.initial(
              guardInfoModel: GuardInfoModel(),
              locations: GetLocations(),
              loggedInUserDetails: EntrySecurity(),
              users: const [],
              emailUsers: const [],
              errorMessage: '',
              loadAttachments: const [],
              eventId: null,
              departments: const [],
          ),
        );

  void onModelValueChange(GuardInfoModel guardInfoModel) {
    log('-onModelValueChange---');
    emit(state.copyWith(guardInfoModel: guardInfoModel, status: FormStatus.initial));
  }

  void onCheckBoxChange(GuardInfoModel guardInfoModel) {
    emit(state.copyWith(guardInfoModel: guardInfoModel, status: FormStatus.loading));

    emit(state.copyWith(guardInfoModel: guardInfoModel, status: FormStatus.initial));
  }

  Future<void> initializeValues() async {
    log('-status-1-${state.status}--');
    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
   // var userId = await SharedPrefs.getUserId();
    try {
      GuardInfoModel guardInfoModel = await services.getEPGuardInfo(id);

      GetLocations getLocationsData =
          await commonServices.getLocations(name: 'ATOM_LOCATIONS');

     // EntrySecurity loggedInUserDetails =
     //     await commonServices.getUserDetails(userId: userId);


      // Get Date of Creation
      //state.guardInfoModel.inputDate = Utils().getCurrentDate();

      //AddEntities entities =
      //    await commonServices.getEntities(name: 'ATOM_ENTITIES');

     // List<GetUserDetails> entrySecurities = await commonServices.getUsers();

     // EmployeeDepartments departments =
     //     await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');

      emit(
        state.copyWith(
          guardInfoModel: guardInfoModel,
         // loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          //departments: departments.employeeDepartments,
        ),
      );
    } catch (e) {
      log('initialization issue', error: e, name: 'Guard Info Cubit');
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
    //List<Entity>? entities,
    Location? location,
    BaseUser? user,
    BaseUser? guard,
    List<Department>? proposedVendors,
    int? status,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    ////Get Sl No from API
    //if (location != null) {
    //  SerialNumberModel slNo = await commonServices.getSlNo(
     //   locationId: location.id.toString(),
     //   moduleCode: Constants.guardingMasterDataModule,
      //);
   // }
   // state.model.status = status ?? state.model.status;
 //state.guardInfoModel.proposedVendors = proposedVendors ?? state.guardInfoModel.proposedVendors;

    //if (proposedVendors != null) {
    // state.guardInfoModel.proposedVendors = proposedVendors;
  // }

    emit(state.copyWith(
      guardInfoModel: state.guardInfoModel,
      status: FormStatus.initial,
    ));
  }

  void addAttachment({
    List<CreateImage>? data,
    List<CreateImage>? guardImages,

  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    int eventIds = math.Random.secure().nextInt(5);

    log('--guardImages---${guardImages?.length}----');
    if (guardImages != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardInfoModel: state.guardInfoModel,
          guardAttachments: guardImages,
          status: FormStatus.initial,
        ),
      );
    }


    emit(
      state.copyWith(
        eventId: eventIds,
        guardInfoModel: state.guardInfoModel,
        loadAttachments: data,
        guardAttachments: guardImages,
        status: FormStatus.initial,
      ),
    );

    log('--state.status--3--${state.status}----');
  }

  void submitForm({bool isSaveOnly = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (state.guardInfoModel.status == 0 || state.guardInfoModel.status == null) {
      state.guardInfoModel.status = 1;
    }
    // Setting time in milliseconds
   // state.guardInfoModel.inputDate =
    //    (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    // Create/Update API Call
    // GuardingMasterDataRequest request =
    //     GuardingMasterDataRequest(guardingMasterData: state.model);

    GenericCreateResponse response = GenericCreateResponse();
    try {
      if (isSaveOnly) {
        // response = (await services.createGuardingMasterData(
        //     body: request, isSubmit: false));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValid.message,
            ),
          );
          return;
        }
        // response = (await services.createGuardingMasterData(
        //     body: request, isSubmit: true));
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }

    log('---response--msg--${response.message}---');

    emit(
      state.copyWith(
        message: response.message,
        status: FormStatus.success,
      ),
    );
  }
}
