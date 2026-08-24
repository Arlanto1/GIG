
part of "article_found_details_cubit.dart";

class ArticleFoundDetailsState extends Equatable {
  final FormStatus status;
  final ArticleFoundModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
   final List<Organisation> articleType;
  final List<Organisation> articleCategory;
  final List<BaseUser>? emailUsers;
  final List<BaseUser>? employee;
  final List<BaseUser>? claimant;
  final List<BaseUser>? host;
  final List<Organisation> departments;
  final List<Organisation> claimantDepartments;
  final List<ImageContent> uploadAttachments;
  final List<BaseUser>? idCardManger;
  final List<BaseUser>? idCardEmployee;
  final String? message;
  final AFUiLabels? labels;
  final bool isReceiverSignEditable;
  factory ArticleFoundDetailsState.initial({
    required ArticleFoundModel model,
    required Locations locations,
    required List<Organisation> articleType,
    required List<Organisation> articleCategory,
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
      articleCategory:articleCategory,
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


    if (model.claimantSign == null && model.status == 1) {
      return const ErrorResponse(status: false, message: 'Claimant Signature is Mandatory');
    }

    // if((model.typeOfArticle.name!.toLowerCase().contains('id') ||
    //     model.typeOfArticle?.name!.toLowerCase().contains('card')) && (model.idCardManager?.employeeId == model.idCardEmployee?.employeeId)){
    //   return const ErrorResponse(status: false, message: 'Manager Name and Employee Name should be different, Please select other user');
    // }

    // if(model.claimant?.employeeId!=null && model.idCardManager?.employeeId!= null && (model.idCardManager?.employeeId == model.claimant?.employeeId)){
    //   return const ErrorResponse(status: false, message: 'Manager Name and Claimant Name should be different, Please select other user');
    // }
    //
    if(model.idCardEmployee?.employeeId !=null && model.idCardManager?.employeeId !=null  && (model.idCardEmployee?.employeeId == model.idCardManager?.employeeId)){
      return const ErrorResponse(status: false, message: 'Employee Name and Manager Name should be different, Please select other user');
    }

    if(model.idCardEmployee?.employeeId !=null && model.depositor?.employeeId !=null  && (model.idCardEmployee?.employeeId == model.depositor?.employeeId)){
      return const ErrorResponse(status: false, message: 'Employee Name and Depositor Name should be different, Please select other user');
    }

    if(model.idCardManager?.employeeId !=null && model.depositor?.employeeId !=null  && (model.idCardManager?.employeeId == model.depositor?.employeeId)){
      return const ErrorResponse(status: false, message: 'Manager Name and Depositor Name should be different, Please select other user');
    }

    // if((model.typeOfArticle!.name!.toLowerCase().contains('id') ||
    //     model.typeOfArticle!.name!.toLowerCase().contains('card')) && model.depositor?.employeeId !=null && model.idCardManager?.employeeId !=null && (model.depositor?.employeeId == model.idCardManager?.employeeId)){
    //   return const ErrorResponse(status: false, message: 'Depositor Name and Manager Name should be different, Please select other user');
    // }
    //
    // if((model.typeOfArticle!.name!.toLowerCase().contains('id') ||
    //     model.typeOfArticle!.name!.toLowerCase().contains('card')) && model.depositor?.employeeId != null && model.idCardEmployee?.employeeId !=null && (model.depositor?.employeeId == model.idCardEmployee?.employeeId)){
    //   return const ErrorResponse(status: false, message: 'Depositor Name and Employee Name should be different, Please select other user');
    // }
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
  List<Object?> get props => [model, status, isReceiverSignEditable];

  const ArticleFoundDetailsState({
    required this.status,
    required this.model,
    this.locations,
    required this.articleType,
    required this.articleCategory,
    this.loggedInUserDetails,
    this.emailUsers,
    required this.departments,
    required this.claimantDepartments,
    required this.uploadAttachments,
    this.message,
    this.labels,
    this.employee,
    this.claimant,
    this.idCardManger,
    this.idCardEmployee,
    this.host,
    this.isReceiverSignEditable = false,
  });

  ArticleFoundDetailsState copyWith({
    FormStatus? status,
    ArticleFoundModel? model,
    Locations? locations,
    List<Organisation>? articleType,
    List<Organisation>? articleCategory,
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
    List<BaseUser>? idCardManger,
    List<BaseUser>? idCardEmployee,
    bool? isReceiverSignEditable,
    AFUiLabels? labels,
  }) {
    return ArticleFoundDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      articleType: articleType ?? this.articleType,
      articleCategory:articleCategory??this.articleCategory,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      emailUsers: emailUsers ?? this.emailUsers,
      employee: employee ?? this.employee,
      claimant: claimant ?? this.claimant,
      host: host ?? this.host,
      departments: departments ?? this.departments,
      claimantDepartments: claimantDepartments ?? this.claimantDepartments,
      uploadAttachments: uploadAttachments ?? this.uploadAttachments,
      message: message ?? this.message,
      idCardEmployee: idCardEmployee ?? this.idCardEmployee,
      idCardManger: idCardManger ?? this.idCardManger,
      labels: labels ?? this.labels,
    );
  }
}
