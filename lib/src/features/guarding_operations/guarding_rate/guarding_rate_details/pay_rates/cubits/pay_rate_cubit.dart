import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/gr_ui_labels.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/services/guarding_services.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:intl/intl.dart';

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
            loggedInUserDetails: User(),
            departments: const [],
          ),
        );

  CommonServices commonServices = CommonServices();

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    List<Organisation>? entities =
        await commonServices.getOrganisations(name: 'ATOM_ENTITIES');
    Vendors getVendors = await commonServices.getVendors(name: 'ATOM_VENDORS');

    emit(
      state.copyWith(
        getEntitiesResponse: entities,
        listOfEntities: entities,
        status: FormStatus.initial,
        // emailUsers: emailUsers.atomStaticUser,
        vendors: getVendors.items,
      ),
    );
  }

  Future<void> initializeValues() async {
    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    var userId = await SharedPrefs.getUserId();
    User loggedInUserDetails =
        await commonServices.getUserDetails(userId: userId);
    state.model.entrySecurity ??= loggedInUserDetails;
    Locations getLocationsData =
        await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

    EmployeeDepartments departments =
        await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');

    Vendors vendors = await commonServices.getVendors(name: 'ATOM_VENDORS');

    // Get Date of Creation
    // state.model.inputDate =
    //     DateFormat(Constants.fulldateFormat).format(DateTime.now());
    state.model.inputDate = state.model.inputDate == null ? Utils().getCurrentDate() : Utils().formatUnixTimestamp(state.model.inputDate ?? '') ;

    List<Organisation>? entities =
        await commonServices.getOrganisations(name: 'ATOM_ENTITIES');

    if (state.model.location == null) {
      Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();
      if (defaultLocation != null) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: defaultLocation.id.toString(),
          moduleCode: Constants.guardingRatesModule,
        );
        state.model.location = defaultLocation;
        state.model.slNo = slNo.serialNo;
      }
    }

    try {
      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          model: rate,
          departments: departments.employeeDepartments,
          items: payRates,
          vendors: vendors.items,
          listOfEntities: entities,
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
    if (state.model.id != null) {
      emit(
        state.copyWith(
          status: FormStatus.loading,
        ),
      );
      GMRate rateResponse = await services.getRate(state.model.id!);
      emit(
        state.copyWith(
          model: rateResponse,
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
    List<Organisation>? entities,
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

      state.model.location = location;
      state.model.slNo = slNo.serialNo;
    }

    state.model.vendor = vendor ?? state.model.vendor;

    if (entities != null) {
      state.model.entities = entities;
    }

    emit(state.copyWith(
      model: state.model,
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

    if (newPayRate != null) {
      if (newPayRate.fromDate != null) {
        log('--newPayRate.fromDate--${newPayRate.fromDate}--');

        newPayRate.fromDate = Utils().formatTime(newPayRate.fromDate ?? '');
      }
      if (newPayRate.toDate != null) {
        newPayRate.toDate = Utils().formatTime(newPayRate.toDate ?? '');
      }

      switch (newPayRate.rankId) {
        case 1:
          state.model.securityGuardRates ?? [];
          state.model.securityGuardRates?.insert(0, newPayRate);
          break;
        case 2:
          state.model.securityOfficerRates ?? [];
          state.model.securityOfficerRates?.insert(0, newPayRate);
          break;

        case 3:
          state.model.securitySupervisorRates ?? [];
          state.model.securitySupervisorRates?.insert(0, newPayRate);
          break;

        case 4:
          state.model.securityFacilitatorRates ?? [];
          state.model.securityFacilitatorRates?.insert(0, newPayRate);
          break;

        case 5:
          state.model.securityGunManRates ?? [];
          state.model.securityGunManRates?.insert(0, newPayRate);
          break;

        default:
      }
    } else {
      state.model.securityGuardRates ??= [];
      state.model.securityOfficerRates ??= [];
      state.model.securitySupervisorRates ??= [];
      state.model.securityFacilitatorRates ??= [];
      state.model.securityGunManRates ??= [];
    }
    String createdDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    state.model.inputDate = createdDate;
    log('---inputDate--final-${state.model.inputDate}--ccc-$createdDate--');
    GMRateRequest request = GMRateRequest(guardingRateInfo: state.model);
    GenericResponse response = GenericResponse();

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
              griId: state.model.id.toString());
          newPayRate.id = int.parse(response.id ?? '');
        }
        response =
            await services.createGmRate(body: request, isSubmit: isSubmit);
        state.model.id = int.parse(response.id ?? '');
      } on GenericResponse catch (e) {
        emit(
          state.copyWith(
            message: e.message,
            status: FormStatus.error,
          ),
        );
        return;
      } catch (e) {
        log('$e');
        return;
      }
    } else {
      //Validating Fields
      if (!state.isValid.status) {
        emit(
          state.copyWith(
            model: state.model,
            status: FormStatus.error,
            message: state.isValid.message,
          ),
        );
        return;
      }

      try {
        if (newPayRate != null) {
          response = await services.createPayRate(
              body: payRateRequest,
              isSubmit: isSubmit,
              griId: state.model.id.toString());
          newPayRate.id = int.parse(response.id ?? '');
        } else {
          response =
              await services.createGmRate(body: request, isSubmit: isSubmit);
          state.model.id = int.parse(response.id ?? '');
        }
      } on GenericResponse catch (e) {
        emit(
          state.copyWith(
            message: e.message,
            status: FormStatus.error,
          ),
        );
        return;
      } on Exception catch (e) {
        log('--e.message-Exception-${e.toString()}---');
        emit(
          state.copyWith(
            message: e.toString(),
            status: FormStatus.error,
          ),
        );
        return;
      }
    }

    GMRate rateResponse = await services.getRate(state.model.id!);

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

    emit(
      state.copyWith(
        model: rateResponse,
        items: newRates,
        message: response.message,
        status: isSubmit ? FormStatus.success : FormStatus.next,
      ),
    );
  }
}
