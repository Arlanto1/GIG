part of 'contact_info_cubit.dart';

class ContactInfoState extends Equatable {
  final FormStatus status;
  final ContactInfoModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<ImageContent>? loadAttachments;
  final List<ImageContent>? guardAttachments;
  final List<ImageContent>? deploymentAttachments;
  final List<ImageContent>? bioDataAttachments;
  final List<Organisation>? listOfEntities;
  final List<Organisation>? listOfQualifications;
  final List<Organisation> departments;
  final AddQualifications? getQualificationsResponse;
  final AddEntities? getEntitiesResponse;
  final List<String>? participationDates;
  final int? eventId;
  final String? message;
  final List<ImageContent>? permanentAddressAttachments;
  final List<ImageContent>? localAddressAttachments;
  final List<ImageContent>? pVCAttachments;
  final List<ImageContent>? trainingAttachments;
  final List<ImageContent>? medicalAttachments;
  final List<ImageContent>? mSGBAttachments;
  final List<User>? entrySecurities;

  factory ContactInfoState.initial({
    required ContactInfoModel model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Organisation>? listOfEntities,
    required final List<Organisation>? listOfQualifications,
    required final AddEntities? getEntitiesResponse,
    required final AddQualifications? getQualificationsResponse,
    required final List<Organisation> departments,
    required String errorMessage,
    required List<ImageContent> loadAttachments,
    List<ImageContent>? bioDataAttachments,
    List<ImageContent>? guardAttachments,
    List<ImageContent>? deploymentAttachments,
    List<ImageContent>? permanentAddressAttachments,
    List<ImageContent>? localAddressAttachments,
    List<ImageContent>? pVCAttachments,
    List<ImageContent>? trainingAttachments,
    List<ImageContent>? mSGBAttachments,
    List<ImageContent>? medicalAttachments,
    List<User>? entrySecurities,
    required int? eventId,
    List<String>? participationDate,
  }) {
    return ContactInfoState(
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
    // if (model.status == null) {
    //   return const ErrorResponse(status: false, message: 'Please enter Status');
    // }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const ContactInfoState({
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

  ContactInfoState copyWith({
    FormStatus? status,
    ContactInfoModel? model,
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
    return ContactInfoState(
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
