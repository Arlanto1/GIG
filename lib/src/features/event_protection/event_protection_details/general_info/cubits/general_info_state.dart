part of 'general_info_cubit.dart';

class GeneralInfoState extends Equatable {
  final FormStatus status;
  final GiModel model;
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
  final List<CreateImage>? mSGBAttachments;
  final List<GetUserDetails>? entrySecurities;

  factory GeneralInfoState.initial({
    required GiModel model,
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
    List<CreateImage>? mSGBAttachments,
    List<CreateImage>? medicalAttachments,
    List<GetUserDetails>? entrySecurities,
    required int? eventId,
    List<String>? participationDate,
  }) {
    return GeneralInfoState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      listOfEntities: listOfEntities,
      listOfQualifications: listOfQualifications,
      departments: departments,
      getEntitiesResponse: getEntitiesResponse,
      getQualificationsResponse: getQualificationsResponse,
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
      mSGBAttachments: mSGBAttachments,
      entrySecurities: entrySecurities,
    );
  }

  ErrorResponse get isValid {
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const GeneralInfoState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    this.loadAttachments,
    this.guardAttachments,
    this.deploymentAttachments,
    this.bioDataAttachments,
    this.listOfEntities,
    this.listOfQualifications,
    required this.departments,
    this.getQualificationsResponse,
    this.getEntitiesResponse,
    this.participationDates,
    this.eventId,
    this.message,
    this.permanentAddressAttachments,
    this.localAddressAttachments,
    this.pVCAttachments,
    this.trainingAttachments,
    this.medicalAttachments,
    this.entrySecurities,
    this.mSGBAttachments,
  });

  GeneralInfoState copyWith({
    FormStatus? status,
    GiModel? model,
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
    List<GetUserDetails>? entrySecurities,
  }) {
    return GeneralInfoState(
      status: status ?? this.status,
      model: model ?? this.model,
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
      getQualificationsResponse:
          getQualificationsResponse ?? this.getQualificationsResponse,
      getEntitiesResponse: getEntitiesResponse ?? this.getEntitiesResponse,
      participationDates: participationDates ?? this.participationDates,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
      permanentAddressAttachments:
          permanentAddressAttachments ?? this.permanentAddressAttachments,
      localAddressAttachments:
          localAddressAttachments ?? this.localAddressAttachments,
      pVCAttachments: pVCAttachments ?? this.pVCAttachments,
      trainingAttachments: trainingAttachments ?? this.trainingAttachments,
      medicalAttachments: medicalAttachments ?? this.medicalAttachments,
      entrySecurities: entrySecurities ?? this.entrySecurities,
    );
  }
}
