part of 'selfPacedTrainingDetailsCubit.dart';

class SelfPacedTrainingDetailsState extends Equatable {
  final FormStatus status;
  final SelfPacedTrainingModel model;
  final User? loggedInUserDetails;
  final String? message;
  final List<User>? entrySecurities;
  final IMUiLabels? labels;

  factory SelfPacedTrainingDetailsState.initial({
    required SelfPacedTrainingModel model,
    required User? loggedInUserDetails,
    required String errorMessage,
    List<User>? entrySecurities,
  }) {
    return SelfPacedTrainingDetailsState(
      status: FormStatus.initial,
      model: model,
      message: errorMessage,
      entrySecurities: entrySecurities,
    );
  }

  ErrorResponse get isValidDraft {
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    log('---isValid--1--');
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const SelfPacedTrainingDetailsState({
    required this.status,
    required this.model,
    this.message,
    this.entrySecurities,
    this.loggedInUserDetails, this.labels,
  });

  SelfPacedTrainingDetailsState copyWith({
    FormStatus? status,
    SelfPacedTrainingModel? model,
    User? loggedInUserDetails,
    String? message,
    List<User>? entrySecurities,
  }) {
    return SelfPacedTrainingDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      message: message ?? this.message,
      entrySecurities: entrySecurities ?? this.entrySecurities,
    );
  }
}
