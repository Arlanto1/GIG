part of 'transport_medical_details_cubit.dart';

class TransportMedicalDetailsState extends Equatable {
  final FormStatus status;
  final TransportMedicalModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? escortGuard;
  final List<BaseUser>? accompaniedEmployee;
  final List<BaseUser>? accompaniedEmployee1;
  final List<BaseUser>? emailUsers;
  final List<BaseUser>? employees;
  final List<Organisation>? listOfEntities;
  final List<Organisation> departments;
  final List<Organisation> vendors;
  final List<Organisation>? getEntitiesResponse;
  final List<String>? participationDates;
  final int? eventId;
  final String? message;
  final List<User>? entrySecurities;
  final List<ImageContent> loadAttachments;
  final List<ImageContent> mapAttachments;
  final IMUiLabels? labels;
  final bool showEmployees;
  final User? selectedEmployee;
  final List<Map<String, dynamic>>? emailTemplates;
  final bool? isTemplateLoading ;
  final String? draftTemplateHtml;
  final TransportEmailNotificationModel? emailModel;
  final bool? showPopup;

  factory TransportMedicalDetailsState.initial({
    required TransportMedicalModel model,
    required Locations locations,
    required List<BaseUser>? users,
    required User? loggedInUserDetails,
    final List<BaseUser>? emailUsers,
    final List<BaseUser>? escortGuard,
    final List<BaseUser>? accompaniedEmployee,
    final List<BaseUser>? accompaniedEmployee1,
    // final List<BaseUser>? employees,
    required final List<Organisation>? listOfEntities,
    required final List<Organisation>? getEntitiesResponse,
    required final List<Organisation> departments,
    required final List<Organisation> vendors,
    required String errorMessage,
    required List<ImageContent> loadAttachments,
    required List<ImageContent> mapAttachments,
    List<User>? entrySecurities,
    required int? eventId,
    List<String>? participationDate,
    bool? showEmployees,
    List<Map<String, dynamic>>? emailTemplates,
    bool? isTemplateLoading,
    required String? draftTemplateHtml,
    required TransportEmailNotificationModel? emailModel,
    bool? showPopup,
  }) {
    return TransportMedicalDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      listOfEntities: listOfEntities,
      departments: departments,
      vendors: vendors,
      getEntitiesResponse: getEntitiesResponse,
      escortGuard: escortGuard,
      accompaniedEmployee: accompaniedEmployee,
      accompaniedEmployee1: accompaniedEmployee1,
      users: users,
      emailUsers: emailUsers,
      // employees: employees,
      message: errorMessage,
      eventId: eventId,
      participationDates: participationDate,
      entrySecurities: entrySecurities,
      loadAttachments:loadAttachments,
      mapAttachments:mapAttachments,
      isTemplateLoading:isTemplateLoading,
      emailTemplates:emailTemplates,
        emailModel:emailModel,
        showPopup:showPopup,
    );
  }

  ErrorResponse get isValidDraft {
    log('-model.status---${model.status}--');

    if (model.location == null) {
      log('-model.location-----isValidDraft-');
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
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
    if (model.entities == null || model.entities!.isEmpty) {
      return const ErrorResponse(status: false, message: 'Please add Entities');
    }

    if (model.map == null ) {
      return const ErrorResponse(status: false, message: 'Please add map Attachment');
    }
    if (model.escortGuard?.email != null &&
        (model.employees?.any((emp) => emp.email == model.escortGuard?.email) ?? false)) {
      return const ErrorResponse(status: false, message: 'Please select other user');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  const TransportMedicalDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.users,
    this.emailUsers,
    this.escortGuard,
    this.accompaniedEmployee,
    this.accompaniedEmployee1,
    this.employees,
    this.listOfEntities,
    required this.departments,
    required this.vendors,
    this.getEntitiesResponse,
    this.participationDates,
    this.eventId,
    this.message,
    this.entrySecurities,
    this.loggedInUserDetails,
    required this.loadAttachments,
    required this.mapAttachments,
    this.labels,
    this.showEmployees = false,
    this.selectedEmployee,
    this.emailTemplates,
    this.isTemplateLoading,
    this.draftTemplateHtml,
    this.emailModel,
    this.showPopup = false,
  });

  TransportMedicalDetailsState copyWith({
    FormStatus? status,
    TransportMedicalModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? escortGuard,
    List<BaseUser>? accompaniedEmployee,
    List<BaseUser>? accompaniedEmployee1,
    List<BaseUser>? emailUsers,
    List<BaseUser>? employees,
    List<Organisation>? listOfEntities,
    List<Organisation>? departments,
    List<Organisation>? vendors,
    List<Organisation>? getEntitiesResponse,
    List<String>? participationDates,
    int? eventId,
    String? message,
    List<User>? entrySecurities,
    List<ImageContent>? loadAttachments,
    List<ImageContent>?  mapAttachments,
    final IMUiLabels? labels,
    bool? showEmployees,
    final User? selectedEmployee,
    List<Map<String, dynamic>>? emailTemplates,
    bool? isTemplateLoading,
    String? draftTemplateHtml,
    TransportEmailNotificationModel? emailModel,
    final bool? showPopup,

  }) {
    return TransportMedicalDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      escortGuard: escortGuard ?? this.escortGuard,
      accompaniedEmployee: accompaniedEmployee ?? this.accompaniedEmployee,
      accompaniedEmployee1: accompaniedEmployee1 ?? this.accompaniedEmployee1,
      emailUsers: emailUsers ?? this.emailUsers,
      employees: employees ?? this.employees,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      departments: departments ?? this.departments,
      vendors: vendors ?? this.vendors,
      getEntitiesResponse: getEntitiesResponse ?? this.getEntitiesResponse,
      participationDates: participationDates ?? this.participationDates,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
      entrySecurities: entrySecurities ?? this.entrySecurities,
      labels: labels ?? this.labels,
      loadAttachments:loadAttachments??this.loadAttachments,
      mapAttachments:mapAttachments??this.mapAttachments,
      showEmployees: showEmployees ?? this.showEmployees,
      emailTemplates: emailTemplates ?? this.emailTemplates,
      isTemplateLoading: isTemplateLoading ?? this.isTemplateLoading,
      draftTemplateHtml:draftTemplateHtml?? this.draftTemplateHtml,
        emailModel:emailModel?? this.emailModel,
        showPopup:showPopup??showPopup,
    );
  }


  @override
  List<Object?> get props => [
    model,
    status,
    loadAttachments,
    locations,
    loggedInUserDetails,
    users,
    emailUsers,
    eventId,
    message,
    emailTemplates,
    isTemplateLoading,
    draftTemplateHtml,
    showPopup
  ];
}
