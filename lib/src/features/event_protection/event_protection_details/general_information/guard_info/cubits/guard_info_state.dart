part of 'guard_info_cubit.dart';

class GuardInfoState extends Equatable {
  final FormStatus status;
  final GuardInfoModel guardInfoModel;
  final GetLocations? locations;
  final EntrySecurity? loggedInUserDetails;
  final List<Organisation> departments;
  final int? eventId;
  final String? message;

  factory GuardInfoState.initial({
    required GuardInfoModel guardInfoModel,
    required GetLocations locations,
    required EntrySecurity loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Organisation> departments,
    required String errorMessage,
    required List<CreateImage> loadAttachments,
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
    GetLocations? locations,
    EntrySecurity? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<CreateImage>? loadAttachments,
    List<CreateImage>? guardAttachments,
    List<CreateImage>? deploymentAttachments,
    List<CreateImage>? bioDataAttachments,
    List<Entity>? listOfEntities,
    List<Entity>? listOfQualifications,
    List<Organisation>? departments,
    AddQualifications? getQualificationsResponse,
    AddEntities? getEntitiesResponse,
    List<String>? participationDates,
    int? eventId,
    String? message,
    List<CreateImage>? permanentAddressAttachments,
    List<CreateImage>? localAddressAttachments,
    List<CreateImage>? pVCAttachments,
    List<CreateImage>? trainingAttachments,
    List<CreateImage>? medicalAttachments,
    List<CreateImage>? mSGBAttachments,
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
