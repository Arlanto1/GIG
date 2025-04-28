
part of "article_found_details_cubit.dart";

class ArticleFoundDetailsState extends Equatable {
  final FormStatus status;
  final ArticleFoundModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
   final List<Organisation> articleType;
  final List<BaseUser>? emailUsers;
  final List<BaseUser>? employee;
  final List<BaseUser>? claimant;
  final List<BaseUser>? host;
  final List<Organisation> departments;
  final List<Organisation> claimantDepartments;
  final List<ImageContent> uploadAttachments;
  final String? message;
  final PMUiLabels? labels;

  factory ArticleFoundDetailsState.initial({
    required ArticleFoundModel model,
    required Locations locations,
    required List<Organisation> articleType,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required String errorMessage,
    required List<Organisation> departments,
    required List<Organisation> claimantDepartments,
    required List<ImageContent> uploadAttachments,
  }) {
    return ArticleFoundDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      articleType: articleType,
      emailUsers: emailUsers,
      message: errorMessage,
      departments: departments,
      claimantDepartments:claimantDepartments,
      uploadAttachments: uploadAttachments,
    );
  }

  ErrorResponse get isValidDraft {
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }
    if (model.entrySecurity == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Entry Security');
    }
    if (model.inputDate == null) {
      return const ErrorResponse(
          status: false, message: 'Created Date is required');
    }
    if (model.location == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }

    if (model.slNo.isEmptyOrNull) {
      return const ErrorResponse(status: false, message: 'Please enter SL No');
    }

    // if(model.employee?.employeeId != null && model.employee?.employeeId == model.host?.employeeId) {
    //   return const ErrorResponse(
    //       status: false, message: 'Same user selected in multiple lists');
    // }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }
    if (model.entrySecurity == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Entry Security');
    }
    if (model.inputDate == null) {
      return const ErrorResponse(
          status: false, message: 'Created Date is required');
    }
    if (model.location == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    if (model.slNo.isEmptyOrNull) {
      return const ErrorResponse(status: false, message: 'Please enter SL No');
    }

    // if (model.entities.isEmptyOrNull) {
    //   return const ErrorResponse(status: false, message: 'Please enter Entities');
    // }
    //
    // if (model.companyType == null) {
    //   return const ErrorResponse(status: false, message: 'Please select Company Type');
    // }
    //
    // if (model.companyName.isEmptyOrNull) {
    //   return const ErrorResponse(status: false, message: 'Please enter Company Name');
    // }

    // if ((model.companyType?.name =='FTE' || model.companyType?.name == 'CWR T1') && model.employee?.employeeId == null) {
    //   return const ErrorResponse(status: false, message: 'Please select  Employee ID');
    // }
    // if (( model.companyType?.name == 'CWR T2') && model.employeeId.isEmptyOrNull) {
    //   return const ErrorResponse(status: false, message: 'Please enter Employee Id');
    // }
    //
    // if (( model.companyType?.name == 'CWR T2' ||  model.companyType?.name == 'Exceptions') && model.employeeName.isEmptyOrNull) {
    //   return const ErrorResponse(status: false, message: 'Please enter Name');
    // }

    // if (( model.companyType?.name == 'CWR T2' || model.companyType?.name == 'CWR T1') && model.host?.employeeId == null) {
    //   return const ErrorResponse(status: false, message: 'Please select DB Sponsor Employee ID');
    // }
    //
    //
    // if (( model.companyType?.name == 'Exceptions') && model.host?.employeeId == null) {
    //   return const ErrorResponse(status: false, message: 'Please select Host Employee Id');
    // }
    //
    // if ( model.department == null) {
    //   return const ErrorResponse(status: false, message: 'Please select Department');
    // }
    // if ( model.dayPassReason == null) {
    //   return const ErrorResponse(status: false, message: 'Please select Reason for Day Pass');
    // }

    // if ( model.passInfo?.passNo == null) {
    //   return const ErrorResponse(status: false, message: 'Please select Day Pass No');
    // }
    //
    // if(model.employee?.employeeId != null && model.employee?.employeeId == model.host?.employeeId  ){
    //   return const ErrorResponse(status: false, message: 'Same user selected in multiple lists');
    //
    // }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const ArticleFoundDetailsState({
    required this.status,
    required this.model,
    this.locations,
    required this.articleType,
    this.loggedInUserDetails,
    this.emailUsers,
    required this.departments,
    required this.claimantDepartments,
    required this.uploadAttachments,
    this.message,
    this.labels,
    this.employee,
    this.claimant,
    this.host,
  });

  ArticleFoundDetailsState copyWith({
    FormStatus? status,
    ArticleFoundModel? model,
    Locations? locations,
    List<Organisation>? articleType,
    User? loggedInUserDetails,
    List<BaseUser>? emailUsers,
    List<BaseUser>? employee,
    List<BaseUser>? claimant,
    List<BaseUser>? host,
    List<BaseUser>? receiverEmailUsers,
    List<Organisation>? departments,
    List<Organisation>? claimantDepartments,
    List<ImageContent>? uploadAttachments,
    String? message,
    PMUiLabels? labels,
  }) {
    return ArticleFoundDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      articleType: articleType ?? this.articleType,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      emailUsers: emailUsers ?? this.emailUsers,
      employee: employee ?? this.employee,
      claimant: claimant ?? this.claimant,
      host: host ?? this.host,
      departments: departments ?? this.departments,
      claimantDepartments: claimantDepartments ?? this.claimantDepartments,
      uploadAttachments: uploadAttachments ?? this.uploadAttachments,
      message: message ?? this.message,
      labels: labels ?? this.labels,
    );
  }
}
