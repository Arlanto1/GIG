part of 'pay_rate_cubit.dart';

class PayRateState extends Equatable {
  final FormStatus status;
  final GMRate rate;
  final List<PayRate> items;
  final PayRate newPayRate;
  final String? message;
  final EntrySecurity? loggedInUserDetails;
  final GetLocations? locations;
  final List<Department> departments;
  final List<Entity>?  listOfEntities;
  final AddEntities? getEntitiesResponse;
  final int? eventId;

  factory PayRateState.initial({
    required List<PayRate> payRates,
    required GMRate rate,
    required String? message,
    required newPayRate,
    required EntrySecurity loggedInUserDetails,
    required List<Department> departments,
  }) {
    return PayRateState(
      status: FormStatus.initial,
      items: payRates,
      message: message,
      rate: rate,
      newPayRate: newPayRate,
      departments: departments,
      loggedInUserDetails: loggedInUserDetails,
    );
  }

  @override
  List<Object?> get props => [rate, status];

  const PayRateState({
    required this.status,
    required this.rate,
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
    List<PayRate>? items,
    PayRate? newPayRate,
    String? message,
    EntrySecurity? loggedInUserDetails,
    GetLocations? locations,
    List<Department>? departments,
    List<Entity>? listOfEntities,
    AddEntities? getEntitiesResponse,
    int? eventId,
  }) {
    return PayRateState(
      status: status ?? this.status,
      rate: rate ?? this.rate,
      items: items ?? this.items,
      newPayRate: newPayRate ?? this.newPayRate,
      message: message ?? this.message,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      locations: locations ?? this.locations,
      departments: departments ?? this.departments,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      getEntitiesResponse: getEntitiesResponse ?? this.getEntitiesResponse,
      eventId: eventId ?? this.eventId,
    );
  }
}
