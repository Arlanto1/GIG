part of 'key_issuance_process_record_bloc.dart';

abstract class KeyIssuanceProcessRecordEvent extends Equatable {
  const KeyIssuanceProcessRecordEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends KeyIssuanceProcessRecordEvent {
  final int id;
  final int startPos;
  final int maxPos;

  const FetchData({
    required this.id,
    required this.startPos,
    required this.maxPos,
  });
}

class InitializeValues extends KeyIssuanceProcessRecordEvent {
  const InitializeValues();
}

class SaveRecord extends KeyIssuanceProcessRecordEvent {
  final KeyIssuanceProcessRecord keyIssuanceProcessRecord;
  final int mainIssuanceId;

  const SaveRecord(
    this.keyIssuanceProcessRecord,
    this.mainIssuanceId,
  );
}

class DeleteRecord extends KeyIssuanceProcessRecordEvent {
  final int id;
  final int mainIssuanceId;

  const DeleteRecord(this.id, this.mainIssuanceId);
}
