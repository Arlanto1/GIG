part of 'pay_rate_cubit.dart';

class PayRateState extends Equatable {
  final FormStatus status;
  final GMRate model;
  final List<PayRate> items;
  final PayRate newPayRate;
  final String? message;
  final User? loggedInUserDetails;
  final GetLocations? locations;
  final List<Organisation> departments;
  final List<Organisation>? listOfEntities;
  final AddEntities? getEntitiesResponse;
  final int? eventId;

  factory PayRateState.initial({
    required List<PayRate> payRates,
    required GMRate rate,
    required String? message,
    required newPayRate,
    required User loggedInUserDetails,
    required List<Organisation> departments,
  }) {
    return PayRateState(
      status: FormStatus.initial,
      items: payRates,
      message: message,
      model: rate,
      newPayRate: newPayRate,
      departments: departments,
      loggedInUserDetails: loggedInUserDetails,
    );
  }

  @override
  List<Object?> get props => [model, status];

  ErrorResponse get isValid {
    if (model.entities == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Guarding Rating Information.');
    }
    if (model.securityGuardRates == null || model.securityGuardRates!.isEmpty) {
      return const ErrorResponse(
          status: false, message: 'Please enter Security Guard Rates');
    }

    if (model.securitySupervisorRates == null ||
        model.securitySupervisorRates!.isEmpty) {
      return const ErrorResponse(
          status: false, message: 'Please enter Security Supervisor Rates');
    }
    if (model.securityOfficerRates == null ||
        model.securityOfficerRates!.isEmpty) {
      return const ErrorResponse(
          status: false, message: 'Please enter Security Officer Rates');
    }
    if (model.securityFacilitatorRates == null ||
        model.securityFacilitatorRates!.isEmpty) {
      return const ErrorResponse(
          status: false, message: 'Please enter Security Facilitator Rates');
    }
    if (model.securityGunManRates == null || model.securityGunManRates!.isEmpty) {
      return const ErrorResponse(
          status: false, message: 'Please enter Security Gun Man Rates');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  const PayRateState({
    required this.status,
    required this.model,
    required this.items,
    required this.newPayRate,
    this.message,
    this.loggedInUserDetails,
    this.locations,
    required this.departments,
    this.listOfEntities,
    this.getEntitiesResponse,
    this.eventId,
  });

  PayRateState copyWith({
    FormStatus? status,
    GMRate? rate,
    List<Organisation>? vendors,
    List<PayRate>? items,
    PayRate? newPayRate,
    String? message,
    User? loggedInUserDetails,
    GetLocations? locations,
    List<Organisation>? departments,
    List<Organisation>? listOfEntities,
    AddEntities? getEntitiesResponse,
    int? eventId,
  }) {
    return PayRateState(
      status: status ?? this.status,
      model: rate ?? this.model,
      departments: vendors ?? this.departments,
      items: items ?? this.items,
      newPayRate: newPayRate ?? this.newPayRate,
      message: message ?? this.message,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      locations: locations ?? this.locations,
     // departments: departments ?? this.departments,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      getEntitiesResponse: getEntitiesResponse ?? this.getEntitiesResponse,
      eventId: eventId ?? this.eventId,
    );
  }
}
