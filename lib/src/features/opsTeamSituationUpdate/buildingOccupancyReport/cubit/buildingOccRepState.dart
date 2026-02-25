part of 'buildingOccRepCubit.dart';

class BuildingOccRepState extends Equatable {
  final FormStatus status;
  final LsmOccupancyReport model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<Organisation>? listOfEntities;
  final List<Organisation>? getEntitiesResponse;
  final List<Organisation> vendors;
  final List<Organisation> typeOfServices;
  final List<Organisation>? dutyPosts;
  final String? message;
  final List<String>? pocs;
  final SlaUiLabels? labels;

  factory BuildingOccRepState.initial({
    required LsmOccupancyReport model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Organisation>? listOfEntities,
    required final List<Organisation>? getEntitiesResponse,
    required final List<Organisation> vendors,
    required final List<Organisation> typeOfServices,
    required String errorMessage,
    final List<String>? pocs,
  }) {
    return BuildingOccRepState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      users: users,
      emailUsers: emailUsers,
      listOfEntities: listOfEntities,
      getEntitiesResponse: getEntitiesResponse,
      vendors: vendors,
      typeOfServices: typeOfServices,
      message: errorMessage,
      pocs: pocs,
    );
  }

  ErrorResponse get isValidDraft {
  //   if (model.status == null) {
  //     return const ErrorResponse(status: false, message: 'Please enter Status');
  //   }
  //   if (model.entrySecurity == null) {
  //     return const ErrorResponse(
  //         status: false, message: 'Please enter Entry Security');
  //   }
  //   if (model.inputDate == null) {
  //     return const ErrorResponse(
  //         status: false, message: 'Created Date is required');
  //   }
  //   if (model.location == null) {
  //     return const ErrorResponse(
  //         status: false, message: 'Please enter Location');
  //   }
  //
  //   if (model.slNo.isEmptyOrNull) {
  //     return const ErrorResponse(status: false, message: 'Please enter SL No');
  //   }
  //
  //   return const ErrorResponse(status: true, message: 'Form is Valid');
  // }
  //
  // ErrorResponse get isValid {
  //   if (model.location == null) {
  //     return const ErrorResponse(
  //         status: false, message: 'Please enter Location');
  //   }


    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const BuildingOccRepState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.listOfEntities,
    this.getEntitiesResponse,
    required this.vendors,
    required this.typeOfServices,
    this.dutyPosts,
    this.users,
    this.emailUsers,
    this.message,
    this.pocs,
    this.labels,
  });

  BuildingOccRepState copyWith({
    FormStatus? status,
    LsmOccupancyReport? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<Organisation>? listOfEntities,
    List<Organisation>? getEntitiesResponse,
    List<Organisation>? vendors,
    List<Organisation>? typeOfServices,
    List<Organisation>? dutyPosts,
    List<String>? pocs,
    String? message,
    SlaUiLabels? labels,
  }) {
    return BuildingOccRepState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      vendors: vendors ?? this.vendors,
      typeOfServices: typeOfServices ?? this.typeOfServices,
      dutyPosts: dutyPosts ?? this.dutyPosts,
      message: message ?? this.message,
      pocs: pocs ?? this.pocs,
      labels: labels ?? this.labels,
      emailUsers: emailUsers ?? this.emailUsers,
    );
  }
}
