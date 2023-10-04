import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/request/gm_rate_request.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/request/pay_rate_request.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/services/guarding_services.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../../../constants/constants.dart';
import '../../../../../../enums/form_status.dart';
import '../../../../../../models/entity.dart';
import '../../../../../../models/entry_security.dart';
import '../../../../../../models/organisation.dart';
import '../../../../../../models/responseModels/error_response_validation.dart';
import '../../../../../../models/responseModels/generic_creat_response.dart';
import '../../../../../../utils/shared_preferences.dart';
import '../../../../../createfound/models/emplyee_departments_model.dart';
import '../../../../../createfound/models/get_locations_model.dart';
import '../../../../../createfound/models/serial_number_model.dart';
import '../../../../../lawenforcement/models/addentities.dart';

part 'pay_rate_state.dart';

class PayRateCubit extends Cubit<PayRateState> {
  final GuardingServices services;
  final GMRate rate;
  final List<PayRate> payRates;

  PayRateCubit({
    required this.services,
    required this.rate,
    required this.payRates,
  }) : super(
          PayRateState.initial(
            payRates: payRates,
            rate: rate,
            message: '',
            newPayRate: PayRate(),
            loggedInUserDetails: EntrySecurity(),
            departments: const [],
          ),
        );

  CommonServices commonServices = CommonServices();

  Future<void> initializeValues() async {
    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    var userId = await SharedPrefs.getUserId();
    EntrySecurity loggedInUserDetails =
        await commonServices.getUserDetails(userId: userId);
    state.rate.entrySecurity ??= loggedInUserDetails;
    GetLocations getLocationsData =
        await commonServices.getLocations(name: 'ATOM_LOCATIONS');

    EmployeeDepartments departments =
        await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');

    // Get Date of Creation
    state.rate.inputDate =
        DateFormat(Constants.fulldateFormat).format(DateTime.now());

    AddEntities entities =
        await commonServices.getEntities(name: 'ATOM_ENTITIES');

    try {
      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          rate: rate,
          departments: departments.employeeDepartments,
          items: payRates,
          listOfEntities: entities.atomEntities,
          getEntitiesResponse: entities,
          status: FormStatus.initial,
        ),
      );
    } catch (e) {
      log('Caught an error', error: e);
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.error,
        ),
      );
    }
  }

  Future<void> updateModelValue() async {
    if(state.rate.id != null) {
      emit(
        state.copyWith(
          status: FormStatus.loading,
        ),
      );
      GMRate rateResponse = await services.getRate(state.rate.id!);
      emit(
        state.copyWith(
          rate: rateResponse,
          status: FormStatus.initial,
        ),
      );
    }
  }

  void onModelValueChange(PayRate model) {
    emit(state.copyWith(newPayRate: model, status: FormStatus.initial));
  }

  Future<void> updateDropdownValues({
    Organisation? location,
    Organisation? vendor,
    List<Entity>? entities,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    /// Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.guardingRatesModule,
      );

      state.rate.location = location;
      state.rate.slNo = slNo.serialNo;
    }

    if (vendor != null) {
      state.rate.vendor = vendor;
    }

    if (entities != null) {
      state.rate.entities = entities;
    }

    emit(state.copyWith(
      rate: state.rate,
      status: FormStatus.initial,
    ));
  }

  Future<void> onSave({
    bool isSubmit = false,
    PayRate? newPayRate,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );


    if(newPayRate != null) {
      if (newPayRate.fromDate != null) {

        log('--newPayRate.fromDate--${newPayRate.fromDate}--');

        newPayRate.fromDate = Utils().formatTime(newPayRate.fromDate ?? '');
      }
      if (newPayRate.toDate != null) {
        newPayRate.toDate = Utils().formatTime(newPayRate.toDate ?? '');
      }

      switch (newPayRate.rankId) {
        case 1:
          state.rate.securityGuardRates ?? [];
          state.rate.securityGuardRates?.insert(0, newPayRate);
          break;
        case 2:
          state.rate.securityOfficerRates ?? [];
          state.rate.securityOfficerRates?.insert(0, newPayRate);
          break;

        case 3:
          state.rate.securitySupervisorRates ?? [];
          state.rate.securitySupervisorRates?.insert(0, newPayRate);
          break;

        case 4:
          state.rate.securityFacilitatorRates ?? [];
          state.rate.securityFacilitatorRates?.insert(0, newPayRate);
          break;

        case 5:
          state.rate.securityGunManRates ?? [];
          state.rate.securityGunManRates?.insert(0, newPayRate);
          break;

        default:

      }
    } else{
      state.rate.securityGuardRates ??= [];
      state.rate.securityOfficerRates ??= [];
      state.rate.securitySupervisorRates ??= [];
      state.rate.securityFacilitatorRates ??= [];
      state.rate.securityGunManRates ??= [];
    }
    String createdDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    state.rate.inputDate = createdDate;
    log('---inputDate--final-${state.rate.inputDate}--ccc-$createdDate--');
    GMRateRequest request = GMRateRequest(guardingRateInfo: state.rate);
    GenericCreateResponse response = GenericCreateResponse();

    log('---newPayRate------$newPayRate-');

    PayRateRequest payRateRequest = PayRateRequest();
    payRateRequest.guardingRate = newPayRate;

    if (!isSubmit) {
      try {
        if (newPayRate != null) {
          PayRateRequest payRateRequest = PayRateRequest();
          payRateRequest.guardingRate = newPayRate;
          response = await services.createPayRate(
              body: payRateRequest,
              isSubmit: isSubmit,
              griId: state.rate.id.toString());
          newPayRate.id = int.parse(response.id ?? '');
        }
        response =
            await services.createGmRate(body: request, isSubmit: isSubmit);
        state.rate.id = int.parse(response.id ?? '');
      } catch (e) {
        log('$e');
        return;
      }
    } else {
      //Validating Fields
      if (!state.isValid.status) {
        emit(
          state.copyWith(
            rate: state.rate,
            status: FormStatus.error,
            message: state.isValid.message,
          ),
        );
        return;
      }

      if (newPayRate != null) {
        response = await services.createPayRate(
            body: payRateRequest,
            isSubmit: isSubmit,
            griId: state.rate.id.toString());
        newPayRate.id = int.parse(response.id ?? '');
      } else {
        response =
            await services.createGmRate(body: request, isSubmit: isSubmit);
        state.rate.id = int.parse(response.id ?? '');
      }
    }

    log('-@@@@@@-----');
    GMRate rateResponse = await services.getRate(state.rate.id!);
    log('-@@@@2222@@---${newPayRate?.rankId}----');

    List<PayRate>? newRates = [];
    if (newPayRate != null) {
      switch (newPayRate.rankId) {
        case 1:
          log('Adding Rate for Security Guard', name: 'PayRateCubit');
          newRates = rateResponse.securityGuardRates;
          break;
        case 2:
          log('Adding Rate for Security Officer', name: 'PayRateCubit');
          newRates = rateResponse.securityOfficerRates;
          break;

        case 3:
          log('Adding Rate for Security Supervisor', name: 'PayRateCubit');
          newRates = rateResponse.securitySupervisorRates;
          break;

        case 4:
          log('Adding Rate for Security Facilitator', name: 'PayRateCubit');
          newRates = rateResponse.securityFacilitatorRates;
          break;

        case 5:
          log('Adding Rate for Gun Man', name: 'PayRateCubit');
          newRates = rateResponse.securityGunManRates;
          break;

        default:
      }
    }
    log('-@@@@@@---#####--');

    emit(
      state.copyWith(
        rate: rateResponse,
        items: newRates,
        message: response.message,
        status: isSubmit ? FormStatus.success : FormStatus.next,
      ),
    );
  }
}
