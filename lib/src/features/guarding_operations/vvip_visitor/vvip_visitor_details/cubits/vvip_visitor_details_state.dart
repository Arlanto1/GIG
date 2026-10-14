part of 'vvip_visitor_details_cubit.dart';

class VVIPVisitorDetailsState extends Equatable {
  final FormStatus status;
  final VIVPVisitorModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final String? message;
  final SlaUiLabels? labels;
  final GetLocationType  getLocationType;

  factory VVIPVisitorDetailsState.initial({
    required VIVPVisitorModel model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required String errorMessage,
    required GetLocationType getLocationType,

  }) {
    return VVIPVisitorDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      users: users,
      message: errorMessage,
      getLocationType:getLocationType,

    );
  }

  ErrorResponse get isValidDraft {
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }
    if (model.entrySecurity == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Entry Security');
    }
    if (model.inputDate == null) {
      return const ErrorResponse(
          status: false, message: 'Created Date is required');
    }
    if (model.location == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }

    if (model.slNo.isEmptyOrNull) {
      return const ErrorResponse(status: false, message: 'Please enter SL No');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    if (model.location == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    // if (model.vendor == null) {
    //   return const ErrorResponse(status: false, message: 'Please enter Vendor');
    // }
    // if (model.entity == null) {
    //   return const ErrorResponse(status: false, message: 'Please enter Entity');
    // }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const VVIPVisitorDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.message,
    this.labels,
    required this.getLocationType,

  });

  VVIPVisitorDetailsState copyWith({
    FormStatus? status,
    VIVPVisitorModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    String? message,
    SlaUiLabels? labels,
    GetLocationType? getLocationType,

  }) {
    return VVIPVisitorDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      message: message ?? this.message,
      labels: labels ?? this.labels,
      getLocationType:getLocationType??this.getLocationType,

    );
  }
}
