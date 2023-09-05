part of 'guarding_master_data_details_cubit.dart';

enum FormStatus {
  loading,
  initial,
  submitting,
  addAttachment,
  next,
  success,
  error,
}

class GuardingMasterDataDetailsState extends Equatable {
  final FormStatus status;
  final GuardingMastersDataModel guardingMasterData;
  final GetLocations? locations;
  final EntrySecurity? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<CreateImage>? loadAttachments;
  final List<CreateImage>? guardAttachments;
  final List<CreateImage>? deploymentAttachments;
  final List<CreateImage>? bioDataAttachments;
  final List<Entity>? listOfEntities;
  final List<Entity>? listOfQualifications;
  final List<Department> departments;
  final AddQualifications? getQualificationsResponse;
  final AddEntities? getEntitiesResponse;
  final List<String>? participationDates;
  final int? eventId;
  final String? message;
  final List<CreateImage>? permanentAddressAttachments;
  final List<CreateImage>? localAddressAttachments;
  final List<CreateImage>? pVCAttachments;
  final List<CreateImage>? trainingAttachments;
  final List<CreateImage>? medicalAttachments;

  factory GuardingMasterDataDetailsState.initial({
    required GuardingMastersDataModel model,
    required GetLocations locations,
    required EntrySecurity loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Entity>? listOfEntities,
    required final List<Entity>? listOfQualifications,
    required final AddEntities? getEntitiesResponse,
    required final AddQualifications? getQualificationsResponse,
    required final List<Department> departments,
    required String errorMessage,
    required List<CreateImage> loadAttachments,
    List<CreateImage>? bioDataAttachments,
    List<CreateImage>? guardAttachments,
    List<CreateImage>? deploymentAttachments,
    List<CreateImage>? permanentAddressAttachments,
    List<CreateImage>? localAddressAttachments,
    List<CreateImage>? pVCAttachments,
    List<CreateImage>? trainingAttachments,
    List<CreateImage>? medicalAttachments,
    required int? eventId,
    List<String>? participationDate,
  }) {
    return GuardingMasterDataDetailsState(
      status: FormStatus.initial,
      guardingMasterData: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      listOfEntities: listOfEntities,
      listOfQualifications: listOfQualifications,
      departments: departments,
      getEntitiesResponse: getEntitiesResponse,
      getQualificationsResponse:getQualificationsResponse,
      users: users,
      emailUsers: emailUsers,
      message: errorMessage,
      loadAttachments: loadAttachments,
      guardAttachments: guardAttachments,
      deploymentAttachments: deploymentAttachments,
      eventId: eventId,
      participationDates: participationDate,
      bioDataAttachments: bioDataAttachments,
      localAddressAttachments: localAddressAttachments,
      medicalAttachments: medicalAttachments,
      permanentAddressAttachments: permanentAddressAttachments,
      pVCAttachments: pVCAttachments,
      trainingAttachments: trainingAttachments,
    );
  }

  ErrorResponse get isValid {
    if (guardingMasterData.location == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    if (guardingMasterData.additionalInitiatives == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Additional Initiatives');
    }
    if (guardingMasterData.localAddress == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Local Address');
    }
    if (guardingMasterData.permanentAddress == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Permanent Address');
    }
    if (guardingMasterData.securityExperience == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Security Experience');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [guardingMasterData, status];

  const GuardingMasterDataDetailsState( {
    required this.status,
    required this.guardingMasterData,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    this.loadAttachments,
    this.guardAttachments,
    this.deploymentAttachments,
    this.bioDataAttachments,
    this.listOfEntities,
    required this.departments,
    this.getEntitiesResponse,
    this.participationDates,
    this.listOfQualifications, this.getQualificationsResponse,
    this.eventId,
    this.message,
    this.permanentAddressAttachments,
    this.localAddressAttachments,
    this.pVCAttachments,
    this.trainingAttachments,
    this.medicalAttachments,
  });

  GuardingMasterDataDetailsState copyWith({
    FormStatus? status,
    GuardingMastersDataModel? guardingMasterData,
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
    List<Department>? departments,
    AddEntities? getEntitiesResponse,
    AddQualifications? getQualificationsResponse,
    List<String>? participationDates,
    int? eventId,
    String? message,
    List<CreateImage>? permanentAddressAttachments,
    List<CreateImage>? localAddressAttachments,
    List<CreateImage>? pVCAttachments,
    List<CreateImage>? trainingAttachments,
    List<CreateImage>? medicalAttachments,
  }) {
    return GuardingMasterDataDetailsState(
      status: status ?? this.status,
      guardingMasterData: guardingMasterData ?? this.guardingMasterData,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      loadAttachments: loadAttachments ?? this.loadAttachments,
      guardAttachments: guardAttachments ?? this.guardAttachments,
      deploymentAttachments:
          deploymentAttachments ?? this.deploymentAttachments,
      bioDataAttachments: bioDataAttachments ?? this.bioDataAttachments,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      listOfQualifications: listOfQualifications ?? this.listOfQualifications,
      departments: departments ?? this.departments,
      getEntitiesResponse: getEntitiesResponse ?? this.getEntitiesResponse,
      getQualificationsResponse: getQualificationsResponse ?? this.getQualificationsResponse,
      participationDates: participationDates ?? this.participationDates,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
      permanentAddressAttachments:
          permanentAddressAttachments ?? this.permanentAddressAttachments,
      localAddressAttachments: localAddressAttachments ?? this.localAddressAttachments,
      pVCAttachments: pVCAttachments ?? this.pVCAttachments,
      trainingAttachments: trainingAttachments ?? this.trainingAttachments,
      medicalAttachments: medicalAttachments ?? this.medicalAttachments,
    );
  }
}
