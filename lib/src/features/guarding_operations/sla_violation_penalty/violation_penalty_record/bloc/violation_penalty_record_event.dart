part of 'violation_penalty_record_bloc.dart';

abstract class ViolationPenaltyRecordEvent extends Equatable {
  const ViolationPenaltyRecordEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends ViolationPenaltyRecordEvent {
  final int id;
  final int startPos;
  final int maxPos;

  const FetchData({
    required this.id,
    required this.startPos,
    required this.maxPos,
  });
}

class InitializeValues extends ViolationPenaltyRecordEvent {
  const InitializeValues();
}

class SaveRecord extends ViolationPenaltyRecordEvent {
  final ViolationPenaltyRecord violationPenaltyRecord;
  final int mainContactId;

  const SaveRecord(
    this.violationPenaltyRecord,
    this.mainContactId,
  );
}

class DeleteRecord extends ViolationPenaltyRecordEvent {
  final int id;
  final int mainContactId;

  const DeleteRecord(this.id, this.mainContactId);
}
