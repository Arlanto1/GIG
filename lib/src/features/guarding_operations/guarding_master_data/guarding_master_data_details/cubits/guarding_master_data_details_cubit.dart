import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../../constants/constants.dart';
import '../../../../../models/base_user.dart';
import '../../../../../models/location.dart';
import '../../../../createfound/models/serial_number_model.dart';
import '../../../../material_movement/models/material_movements_model.dart';
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
              model: model ?? GuardingMastersDataModel(),
              locations: GetLocations(),
              loggedInUserDetails: EntrySecurity(),
              users: const [],
              emailUsers: const [],
              errorMessage: '',
              loadAttachments: const [],
              eventId: null),
        );

  void onModelValueChange(GuardingMastersDataModel model) {
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

      EntrySecurity loggedInUserDetails = (await commonServices.getUserDetails(
          userId: userId)) as EntrySecurity;

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
    Location? location,
    BaseUser? user,
    //BaseUser? name,
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
        moduleCode: '',
      );

      state.guardingMasterData.location = location;
      state.guardingMasterData.slNo = slNo.serialNo;
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

  void showFields(
      {bool? isOriginalReceiverReceiving, bool? isMaterialPhysicallyChecked}) {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    // final updatedMaterialMovement = materialMovement.copyWith(state.materialMovement.originalReceiver: isOriginalReceiverReceiving);

    // emit(state.copyWith(
    //  materialMovement: state.materialMovement,
    //status: FormStatus.initial,
    //));
    //}
  }

  void submitForm({bool isSaveOnly = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
  }
}
