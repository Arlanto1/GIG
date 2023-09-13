import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/contact_info/models/ci_model.dart';
import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';
import 'package:db_atom/src/features/lawenforcement/models/addQualifications.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/models/base_user.dart';
import 'package:db_atom/src/models/department.dart';
import 'package:db_atom/src/models/entity.dart';
import 'package:db_atom/src/models/location.dart';
import 'package:db_atom/src/models/responseModels/generic_creat_response.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';

import '../../../../../constants/constants.dart';
import '../../../../../enums/form_status.dart';
import '../../../../../models/entry_security.dart';
import '../../../../../models/responseModels/error_response_validation.dart';

part 'contact_info_state.dart';

class ContactInfoCubit extends Cubit<ContactInfoState> {
  final EventProtectionServices services;
  final String id;
  final CommonServices commonServices;

  ContactInfoCubit({
    required this.services,
    required this.commonServices,
    required this.id,
  }) : super(
          ContactInfoState.initial(
              model: CiModel(),
              locations: GetLocations(),
              loggedInUserDetails: EntrySecurity(),
              users: const [],
              emailUsers: const [],
              errorMessage: '',
              loadAttachments: const [],
              eventId: null,
              listOfEntities: const [],
              getEntitiesResponse: null,
              departments: const [],
              listOfQualifications: const [],
              getQualificationsResponse: null),
        );

  void onModelValueChange(CiModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(CiModel model) {
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
      CiModel model = CiModel();
      if(id.isNotEmpty) {
        model = await services.getCI(id);
      }
      GetLocations getLocationsData =
          await commonServices.getLocations(name: 'ATOM_LOCATIONS');

      EntrySecurity loggedInUserDetails =
          await commonServices.getUserDetails(userId: userId);

      Analyst users =
          await commonServices.getUsersByRole(roleName: 'T1_Analyst');


      AddEntities entities =
          await commonServices.getEntities(name: 'ATOM_ENTITIES');

      List<GetUserDetails> entrySecurities = await commonServices.getUsers();
      AddQualifications qualifications =
          await commonServices.getQualification(name: 'GUARD_QUALIFICATIONS');

      GetDepositor emailUsers =
          await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

      EmployeeDepartments departments =
          await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');

      emit(
        state.copyWith(
          model: model,
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          users: users.t1Analyst,
          departments: departments.employeeDepartments,
          entrySecurities: entrySecurities,
          emailUsers: emailUsers.atomStaticUser,
          listOfEntities: entities.atomEntities,
          getEntitiesResponse: entities,
          listOfQualifications: qualifications.guardQualifications,
          getQualificationsResponse: qualifications,
        ),
      );
    } catch (e) {
      log('initialization issue', error: e, name: 'Guarding Master Data Cubit');
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
    List<Entity>? entities,
    Location? location,
    GetUserDetails? user,
    Department? requesterDepartment,
    Bu1? bu1,
    Bu2? bu2,
    Department? bu1Dept,
    Department? bu2Dept,
    Department? proposedVendors,
    Srh1? subRegionalHead1,
    Srh2? subRegionalHead2,
    EpManager1? epManager1,
    EpManager2? epManager2,
    Lsm1? locationSecurityManager1,
    Lsm2? locationSecurityManager2,
    BaseUser? epOfficers,
    // List<Entity>? qualifications,
    int? status,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    state.model.bu1 = bu1 ?? state.model.bu1;
    state.model.bu2 = bu2 ?? state.model.bu2;
 //   state.model.requesterDepartment =
   //     requesterDepartment ?? state.model.requesterDepartment;

    // if (entities != null) {
    //   state.model.entities = entities;
    // }
   if (subRegionalHead1 != null) {
       state.model.srh1 = subRegionalHead1.email as Srh1?;
     }
     if (subRegionalHead2 != null) {
       state.model.srh2 = subRegionalHead2.name as Srh2?;
     }
     if (locationSecurityManager1 != null) {
       state.model.lsm1= locationSecurityManager1.email as Lsm1?;
     }
     if (locationSecurityManager2 != null) {
      state.model.lsm2 = locationSecurityManager2.email as Lsm2?;
     }

     if (bu1 != null) {
       state.model.bu1 = bu1.email as Bu1?;
     }
     if (bu2 != null) {
       state.model.bu1 = bu2.email as Bu1?;
     }

    if (epManager1 != null) {
      state.model.epManager1 = epManager1.email as EpManager1?;
    }

    if (epManager2 != null) {
      state.model.epManager2 = epManager2.email as EpManager2?;
    }

    if (epOfficers != null) {
      state.model.epOfficers = epOfficers.email;
    }
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void addAttachment({
    List<CreateImage>? data,
    List<CreateImage>? guardImages,
    List<CreateImage>? deploymentFiles,
    List<CreateImage>? bioDataFiles,
    List<CreateImage>? permanentAddressFiles,
    List<CreateImage>? localAddressFiles,
    List<CreateImage>? pVCFiles,
    List<CreateImage>? trainingFiles,
    List<CreateImage>? mSGBExemptionFiles,
    List<CreateImage>? medicalFiles,
    List<CreateImage>? mSGBAttachments,
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
          model: state.model,
          guardAttachments: guardImages,
          status: FormStatus.initial,
        ),
      );
    }

    if (deploymentFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          deploymentAttachments: deploymentFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (bioDataFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          bioDataAttachments: bioDataFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (permanentAddressFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          permanentAddressAttachments: permanentAddressFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (localAddressFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          localAddressAttachments: localAddressFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (pVCFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          pVCAttachments: pVCFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (trainingFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          trainingAttachments: trainingFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (mSGBExemptionFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          mSGBAttachments: mSGBExemptionFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (medicalFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          medicalAttachments: medicalFiles,
          status: FormStatus.initial,
        ),
      );
    }

    emit(
      state.copyWith(
        eventId: eventIds,
        model: state.model,
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
