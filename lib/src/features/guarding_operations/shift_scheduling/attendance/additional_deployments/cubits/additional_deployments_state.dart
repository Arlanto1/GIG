

part of 'additional_deployments_cubit.dart';

class AdditionalDeploymentsState extends Equatable {
  final FormStatus status;
  final AttendanceModel model;
  final Locations? locations;
  final List<Organisation> vendors;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final String? message;
  final List<String>? locationNames;
  final List<User>? entrySecurities;
  final GmUiLabels? labels;
  final int? parentId;

  final AdhocAttendanceGiModel? adhocModel;

  // Dropdown source lists for the deployment form cards.
  final List<Organisation> designations;
  final List<Organisation> shifts;
  final List<Organisation> dutyHoursList;
  final List<Organisation> guardsList;
  final List<Organisation> dutyPostList;
  factory AdditionalDeploymentsState.initial({
    required AttendanceModel model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Organisation> departments,
    required String errorMessage,
    List<User>? entrySecurities,
    List<String>? dutyPostLocationNames,
    AdhocAttendanceGiModel? adhocModel,
    List<Organisation>? designations,
    List<Organisation>? shifts,
    List<Organisation>? dutyHoursList,
    List<Organisation>? guardsList,
    List<Organisation>? dutyPostList,
  }) {
    return AdditionalDeploymentsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      users: users,
      emailUsers: emailUsers,
      message: errorMessage,
      locationNames: dutyPostLocationNames,
      entrySecurities: entrySecurities,
      vendors: departments,
      adhocModel: adhocModel,
      designations: designations ?? const [],
      shifts: shifts ?? const [],
      dutyHoursList: dutyHoursList ?? const [],
      guardsList: guardsList ?? const [],
        dutyPostList:dutyPostList ?? const []
    );
  }

  ErrorResponse get isValidDraft {
    log('-model.status---${model.status}--');

    if (model.location == null) {
      log('-model.location-----isValidDraft-');
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props =>
      [model, status, adhocModel, designations, shifts, dutyHoursList, dutyPostList];

  const AdditionalDeploymentsState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    this.locationNames,
    this.message,
    this.entrySecurities,
    this.labels,
    required this.vendors,
    this.parentId,
    this.adhocModel,
    this.designations = const [],
    this.shifts = const [],
    this.dutyHoursList = const [],
    this.guardsList = const [],
    this.dutyPostList = const [],
  });

  AdditionalDeploymentsState copyWith({
    FormStatus? status,
    AttendanceModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<String>? locationNames,
    List<Organisation>? vendors,
    String? message,
    List<DutyPostModel>? dutyPosts,
    List<User>? entrySecurities,
    final GmUiLabels? labels,
    int? parentId,
    AdhocAttendanceGiModel? adhocModel,
    List<Organisation>? designations,
    List<Organisation>? shifts,
    List<Organisation>? dutyHoursList,
    List<Organisation>? guardsList,
    List<Organisation>? dutyPostList,

  }) {
    return AdditionalDeploymentsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      locationNames: locationNames ?? this.locationNames,
      message: message ?? this.message,
      entrySecurities: entrySecurities ?? this.entrySecurities,
      labels: labels ?? this.labels,
      vendors: vendors ?? this.vendors,
      parentId: parentId ?? this.parentId,
      adhocModel: adhocModel ?? this.adhocModel,
      designations: designations ?? this.designations,
      shifts: shifts ?? this.shifts,
      dutyHoursList: dutyHoursList ?? this.dutyHoursList,
      guardsList: guardsList ?? this.guardsList,
        dutyPostList: dutyPostList?? this.dutyPostList,

    );
  }
}