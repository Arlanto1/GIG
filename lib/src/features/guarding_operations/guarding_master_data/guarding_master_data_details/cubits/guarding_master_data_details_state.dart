part of 'guarding_master_data_details_cubit.dart';

class GuardingMasterDataDetailsState extends Equatable {
  final FormStatus status;
  final GuardingMastersDataModel model;
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
  final List<Organisation>? getEntitiesResponse;
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
  final GmUiLabels? labels;

  factory GuardingMasterDataDetailsState.initial({
    required GuardingMastersDataModel model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required final List<Organisation>? listOfEntities,
    required final List<Organisation>? listOfQualifications,
    required final List<Organisation>? getEntitiesResponse,
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
    return GuardingMasterDataDetailsState(
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

  ErrorResponse get isValidDraft {
    log('-model.status---${model.status}--');

    if (model.location == null) {
      log('-model.location-----isValidDraft-');
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    if (model.entrySecurity == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Entry Security');
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
    // if (model.entity == null) {
    //   return const ErrorResponse(status: false, message: 'Please enter Entity');
    // }
    // if (model.vendor == null) {
    //   return const ErrorResponse(status: false, message: 'Please enter Vendor');
    // }
    // if (model.guard == null) {
    //   return const ErrorResponse(status: false, message: 'Please enter Name');
    // }
    if (model.guardRank == null) {
      return const ErrorResponse(status: false, message: 'Please enter Rank');
    }
    if (model.guardingPOC == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Guarding Partner POC');
    }

    if (model.employeeCode == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Guarding Agency Employee Code');
    }
    if (model.dutyType == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Type of Duty');
    }
    if (model.gender == null) {
      return const ErrorResponse(status: false, message: 'Please enter Gender');
    }

    if (model.qualifications == null || model.qualifications!.isEmpty) {
      return const ErrorResponse(
          status: false, message: 'Please enter Qualifications');
    }
    if (model.maritalStatus == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Marital Status');
    }
    if (model.contactNo == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Mobile Number ');
    }
    if (model.dateOfBirth == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Date of Birth');
    }
    if (model.dateOfJoining == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Date of Joining');
    }
    // if (model.dependentsNo == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Dependents');
    // }
    if (model.typeOfDeployment == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Deployment Type');
    }
    // if (guardingMasterData.deploymentOrderSubmitted == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please Select Deployment Order Submitted? ');
    // }
    // if (model.height == null) {
    //   return const ErrorResponse(status: false, message: 'Please enter Height');
    // }
    // if (guardingMasterData.physicallyFit == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter PhysicallyFit?');
    // }
    if (model.localLanguage == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Local language');
    }
    if (model.securityExperience == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Security Experience');
    }
    if (model.permanentAddress == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Permanent Address');
    }
    if (model.localAddress == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Local Address');
    }
    if (model.qualifications == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Qualification');
    }
    if (model.pvcIssuedDate == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter PVC Issued Date');
    }
    // if (guardingMasterData.trainingCertificateProvided == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Training Certificate');
    // }
    if (model.medicalCertificateValidUntil == null) {
      return const ErrorResponse(
          status: false,
          message: 'Please enter Medical Certificate Valid Until');
    }
    if (model.systemAccess == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter System Access');
    }
    // if (model.covidFirstDoseDate == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Date of First Covid Dose');
    // }
    // if (model.covidSecondDoseDate == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Date of Second Covid Dose');
    // }
    if (model.additionalInitiatives == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Additional Initiatives');
    }
    if (model.location == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    if (model.additionalInitiatives == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Additional Initiatives');
    }
    if (model.localAddress == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Local Address');
    }
    if (model.permanentAddress == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Permanent Address');
    }
    if (model.securityExperience == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Security Experience');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const GuardingMasterDataDetailsState({
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
    this.labels,
  });

  GuardingMasterDataDetailsState copyWith({
    FormStatus? status,
    GuardingMastersDataModel? model,
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
    List<Organisation>? vendors,
    AddQualifications? getQualificationsResponse,
    List<Organisation>? getEntitiesResponse,
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
    final GmUiLabels? labels,
  }) {
    return GuardingMasterDataDetailsState(
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
      departments: vendors ?? departments,
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
      labels: labels ?? this.labels,
    );
  }
}
