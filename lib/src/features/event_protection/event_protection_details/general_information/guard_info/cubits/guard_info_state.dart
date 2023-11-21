part of 'guard_info_cubit.dart';

class GuardInfoState extends Equatable {
  final FormStatus status;
  final GuardInfoModel guardInfoModel;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<Organisation> departments;
  final int? eventId;
  final String? message;

  factory GuardInfoState.initial({
    required GuardInfoModel guardInfoModel,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Organisation> departments,
    required String errorMessage,
    required List<ImageContent> loadAttachments,
    required int? eventId,
    List<String>? participationDate,
  }) {
    return GuardInfoState(
      status: FormStatus.initial,
      guardInfoModel: guardInfoModel,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      departments: departments,
      message: errorMessage,
    );
  }

  ErrorResponse get isValid {
    if (guardInfoModel.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [guardInfoModel, status];

  const GuardInfoState({
    required this.status,
    required this.guardInfoModel,
    this.locations,
    this.loggedInUserDetails,
    required this.departments,
    this.eventId,
    this.message,
  });

  GuardInfoState copyWith({
    FormStatus? status,
    GuardInfoModel? guardInfoModel,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<ImageContent>? loadAttachments,
    List<ImageContent>? guardAttachments,
    List<ImageContent>? deploymentAttachments,
    List<ImageContent>? bioDataAttachments,
    List<Organisation>? listOfEntities,
    List<Organisation>? listOfQualifications,
    List<Organisation>? departments,
    AddQualifications? getQualificationsResponse,
    AddEntities? getEntitiesResponse,
    List<String>? participationDates,
    int? eventId,
    String? message,
    List<ImageContent>? permanentAddressAttachments,
    List<ImageContent>? localAddressAttachments,
    List<ImageContent>? pVCAttachments,
    List<ImageContent>? trainingAttachments,
    List<ImageContent>? medicalAttachments,
    List<ImageContent>? mSGBAttachments,
    List<User>? entrySecurities,
  }) {
    return GuardInfoState(
      status: status ?? this.status,
      guardInfoModel: guardInfoModel ?? this.guardInfoModel,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      departments: departments ?? this.departments,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
    );
  }
}
