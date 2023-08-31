import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/models/requestModels/guarding_master_data_request.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/models/responseModels/guarding_master_data_responses.dart';
import 'package:db_atom/src/models/entity.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../../constants/constants.dart';
import '../../../../../models/base_user.dart';
import '../../../../../models/entry_security.dart';
import '../../../../createfound/models/serial_number_model.dart';
import '../../../../passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import '../../models/guarding_master_data_model.dart';
import '../../services/guarding_master_data_services.dart';

part 'guarding_master_data_details_state.dart';

class GuardingMasterDataDetailsCubit
    extends Cubit<GuardingMasterDataDetailsState> {
  final GuardingMasterDataServices guardingMasterDataServices;
  final GuardingMastersDataModel? model;
  final CommonServices commonServices;

  GuardingMasterDataDetailsCubit({
    required this.guardingMasterDataServices,
    required this.commonServices,
    required this.model,
  }) : super(
    GuardingMasterDataDetailsState.initial(
        model: model ?? GuardingMastersDataModel(
          deploymentOrders: [],
          qualifications: [],
          pvc: [],
          trainingCertificates: [],
          medicalCertificates: [],
          history: [],
          physicallyFit: true,
          deploymentOrderSubmitted: true,
        ),
        locations: GetLocations(),
        loggedInUserDetails: EntrySecurity(),
        users: const [],
        emailUsers: const [],
        errorMessage: '',
        loadAttachments: const [],
        eventId: null),
  );

  void onModelValueChange(GuardingMastersDataModel model) {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    emit(state.copyWith(guardingMasterData: model, status: FormStatus.initial));
  }

  String _getCurrentDate() {
    return DateFormat(Constants.fulldateFormat).format(DateTime.now());
  }

  Future<void> initializeValues() async {
    print('-status-1-${state.status}--');
    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    var userId = await SharedPrefs.getUserId();
    try {
      GetLocations getLocationsData =
      await commonServices.getLocations(name: 'ATOM_LOCATIONS');

      EntrySecurity loggedInUserDetails =
      await commonServices.getUserDetails(userId: userId);

      Analyst users =
      await commonServices.getUsersByRole(roleName: 'T1_Analyst');

      // Get Date of Creation
      state.guardingMasterData.inputDate = _getCurrentDate();

      GetDepositor emailUsers =
      await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

      state.guardingMasterData.entrySecurity = loggedInUserDetails;

      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          guardingMasterData: state.guardingMasterData,
          users: users.t1Analyst,
          emailUsers: emailUsers.atomStaticUser,
        ),
      );
    } catch (e) {
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
    Entity? location,
    BaseUser? user,
    BaseUser? entity,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    ////Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.materialMovementInwardNonReturnableModule,
      );

      state.guardingMasterData.location = location;
      state.guardingMasterData.slNo = slNo.serialNo;
    }
    if (entity != null) {
      state.guardingMasterData.entity = entity.email as Entity? ;
    }

    emit(state.copyWith(
      guardingMasterData: state.guardingMasterData,
      status: FormStatus.initial,
    ));
  }
  void addAttchment(List<CreateImage>? data) async {
    print('--state.status-1---${state.status}----');

    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    int eventIds = Random.secure().nextInt(5);

    print('--data----${data?.length}----');
    print('--state.status-2---${state.status}----');

    emit(state.copyWith(
      eventId: eventIds,
      guardingMasterData: state.guardingMasterData,
      loadAttachments: data,
      status: FormStatus.initial,
    ));

    print('--state.status--3--${state.status}----');
  }

  void showFields({ bool? deploymentOrderSubmitted,bool? trainingCertificateProvided}) {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    if (deploymentOrderSubmitted != null) {
      state.guardingMasterData.deploymentOrderSubmitted =
          deploymentOrderSubmitted;
    }
    if (trainingCertificateProvided != null) {
      state.guardingMasterData.trainingCertificateProvided =
          trainingCertificateProvided;
    }
    emit(state.copyWith(
      guardingMasterData: state.guardingMasterData,
      status: FormStatus.initial,
    ));
  }

  void submitForm({bool isSaveOnly = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    // Setting time in milliseconds
    state.guardingMasterData.inputDate = (DateTime
        .now()
        .millisecondsSinceEpoch / 1000).toString();

    // Create/Update API Call
    GuardingMasterDataRequest request =
    GuardingMasterDataRequest(guardingMasterData: state.guardingMasterData);

    try {
      GenericCreateResponse response = GenericCreateResponse();
      if (isSaveOnly) {
        response = (await guardingMasterDataServices.createGuardingMasterData(
            body: request, isSubmit: false)) as GenericCreateResponse;
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
        response = (await guardingMasterDataServices.createGuardingMasterData(
            body: request, isSubmit: true)) as GenericCreateResponse;
      }

      print('---response--msg--${response.message}---');

      emit(
        state.copyWith(
          message: response.message,
          status: FormStatus.success,
        ),
      );

      // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //   Utils.dynamicAlert(
      //       context, lawcreateFoundresponse.message ?? '', title, '');
      // });
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }
  }
}
