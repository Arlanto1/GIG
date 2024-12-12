part of 'attendance_shifts_cubit.dart';

class AttendanceShiftsState extends Equatable {
  final FormStatus status;
  final ShiftModel model;
  final String? message;
  final List<String>? locationNames;
  final List<String>? briefingPoints;
  final CdUiLabels? labels;

  final List<Organisation>? ranks;
  final List<Organisation>? shifts;
  final Organisation? selectedRank;
  final Organisation? selectedShift;

  final List<SlaList>? shiftSlaList;

  factory AttendanceShiftsState.initial({
    required ShiftModel model,
    required String errorMessage,
    List<String>? dutyPostLocationNames,
  }) {
    return AttendanceShiftsState(
      status: FormStatus.initial,
      model: model,
      message: errorMessage,
      locationNames: dutyPostLocationNames,
    );
  }

  ErrorResponse get isValidDraft {

    if (model.briefingPoints == null && model.attdStatus == 1) {
      return const ErrorResponse(
          status: false, message: 'Please select/enter Briefing Points');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    if (model.briefingPoints == null && model.attdStatus == 1) {
      return const ErrorResponse(
          status: false, message: 'Please select/enter Briefing Points');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const AttendanceShiftsState({
    required this.status,
    required this.model,
    this.locationNames,
    this.message,
    this.briefingPoints,
    this.labels,
    this.ranks,
    this.shifts,
    this.selectedRank,
    this.selectedShift,
    this.shiftSlaList,
  });

  AttendanceShiftsState copyWith({
    FormStatus? status,
    ShiftModel? model,
    String? message,
    List<String>? briefingPoints,
    List<SlaList>? shiftSlaList,
    List<User>? entrySecurities,
    List<Organisation>? ranks,
    List<Organisation>? shifts,
    Organisation? selectedRank,
    Organisation? selectedShift,
    final CdUiLabels? labels,
  }) {
    return AttendanceShiftsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locationNames: locationNames ?? this.locationNames,
      message: message ?? this.message,
      briefingPoints: briefingPoints ?? this.briefingPoints,
      labels: labels ?? this.labels,
      ranks: ranks ?? this.ranks,
      shifts: shifts ?? this.shifts,
      selectedRank: selectedRank ?? this.selectedRank,
      selectedShift: selectedShift ?? this.selectedShift,
      shiftSlaList: shiftSlaList ?? shiftSlaList,
    );
  }
}
