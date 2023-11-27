part of 'violation_penalty_record_bloc.dart';

abstract class ViolationPenaltyRecordEvent extends Equatable {
  const ViolationPenaltyRecordEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends ViolationPenaltyRecordEvent {
  final int id;
  final int type;
  final int startPos;
  final int maxPos;

  const FetchData({
    required this.id,
    required this.type,
    required this.startPos,
    required this.maxPos,
  });
}

class InitializeValues extends ViolationPenaltyRecordEvent {
  const InitializeValues();
}

class SaveRecord extends ViolationPenaltyRecordEvent {
  final ViolationPenaltyRecord contactInfo;
  final int mainContactId;
  final int type;
  const SaveRecord(this.contactInfo, this.mainContactId, this.type);
}

class DeleteRecord extends ViolationPenaltyRecordEvent {
  final int id;
  final int mainContactId;
  final int type;

  const DeleteRecord(this.id, this.type, this.mainContactId);
}
