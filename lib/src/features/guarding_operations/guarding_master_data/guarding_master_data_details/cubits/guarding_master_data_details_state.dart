part of 'guarding_master_data_details_cubit.dart';

enum FormStatus { loading, initial, submitting, addAttachment, next, success, error }

class GuardingMasterDataDetailsState extends Equatable {
  final FormStatus status;

  final GuardingMastersDataModel guardingMasterData;
  final GetLocations? locations;
  final EntrySecurity? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<CreateImage>? loadAttachments;
  final int? eventId;
  final String? message;

  factory GuardingMasterDataDetailsState.initial({
    required GuardingMastersDataModel model,
    required GetLocations locations,
    required EntrySecurity loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required String errorMessage,
    required List<CreateImage> loadAttachments,
    required int? eventId,
  }) {
    return GuardingMasterDataDetailsState(
        status: FormStatus.initial,
        guardingMasterData: model,
        locations: locations,
        loggedInUserDetails: loggedInUserDetails,
        users: users,
        emailUsers: emailUsers,
        message: errorMessage,
        loadAttachments: loadAttachments,
        eventId: eventId);
  }

  /*ErrorResponse get isValid {
    if (guardingMasterData.location == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }*/

  @override
  List<Object?> get props => [guardingMasterData, status];

  const GuardingMasterDataDetailsState({
    required this.status,
    required this.guardingMasterData,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    this.loadAttachments,
    this.eventId,
    this.message,
  });

  GuardingMasterDataDetailsState copyWith({
    FormStatus? status,
    GuardingMastersDataModel? guardingMasterData,
    GetLocations? locations,
    EntrySecurity? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<CreateImage>? loadAttachments,
    int? eventId,
    String? message,
  }) {
    return GuardingMasterDataDetailsState(
      status: status ?? this.status,
      guardingMasterData: guardingMasterData ?? this.guardingMasterData,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      loadAttachments: loadAttachments ?? this.loadAttachments,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
    );
  }
}

class ErrorResponse {
  final bool status;
  final String message;

  const ErrorResponse({
    required this.status,
    required this.message,
  });
}
