part of 'guarding_master_data_details_cubit.dart';

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
  final List<CreateImage>? mSGBAttachments;
  final List<GetUserDetails>? entrySecurities;

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
    List<CreateImage>? mSGBAttachments,
    List<CreateImage>? medicalAttachments,
    List<GetUserDetails>? entrySecurities,
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
    if (guardingMasterData.status == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Status');
    }
    if (guardingMasterData.entity == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Entity');
    }
    if (guardingMasterData.vendor == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Vendor');
    }
    if (guardingMasterData.guard == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Name');
    }
    if (guardingMasterData.guardRank == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Rank');
    }
    if (guardingMasterData.guardingPOC == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Guarding Partner POC');
    }

    if (guardingMasterData.employeeCode == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Guarding Agency Employee Code');
    }
    if (guardingMasterData.dutyType == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Type of Duty');
    }
    if (guardingMasterData.gender == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Gender');
    }
    if (guardingMasterData.maritalStatus == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Marital Status');
    }
    if (guardingMasterData.contactNo == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Mobile Number ');
    }
    if (guardingMasterData.dateOfBirth == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Date of Birth');
    }
    if (guardingMasterData.dateOfJoining == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Date of Joining');
    }
    if (guardingMasterData.dependentsNo == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Dependents');
    }
    if (guardingMasterData.typeOfDeployment == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Deployment Type');
    }
    // if (guardingMasterData.deploymentOrderSubmitted == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please Select Deployment Order Submitted? ');
    // }
    if (guardingMasterData.height == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Height');
    }
    // if (guardingMasterData.physicallyFit == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter PhysicallyFit?');
    // }
    if (guardingMasterData.localLanguage == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Local language');
    }
    if (guardingMasterData.securityExperience == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Security Experience');
    }
    if (guardingMasterData.permanentAddress == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Permanent Address');
    }
    if (guardingMasterData.localAddress == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Local Address');
    }
    if (guardingMasterData.qualifications == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Qualification');
    }
    if (guardingMasterData.pvcIssuedDate == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter PVC Issued Date');
    }
    // if (guardingMasterData.trainingCertificateProvided == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Training Certificate');
    // }
    if (guardingMasterData.medicalCertificateValidUntil == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Medical Certificate Valid Until');
    }
    if (guardingMasterData.systemAccess == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter System Access');
    }
    if (guardingMasterData.covidFirstDoseDate == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Date of First Covid Dose');
    }
    if (guardingMasterData.covidSecondDoseDate == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Date of Second Covid Dose');
    }
    if (guardingMasterData.additionalInitiatives == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Additional Initiatives');
    }
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

  const GuardingMasterDataDetailsState({
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
