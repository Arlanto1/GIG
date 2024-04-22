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
  final int parentId;

  const SaveRecord(
    this.keyIssuanceProcessRecord,
    this.parentId,
  );
}

class DeleteRecord extends KeyIssuanceProcessRecordEvent {
  final int id;
  final int parentId;

  const DeleteRecord(this.id, this.parentId);
}

class GetKeyDescription extends KeyIssuanceProcessRecordEvent {
  final int keyDescriptionId;
  final bool isMasterKey;

  const GetKeyDescription(this.keyDescriptionId, this.isMasterKey);
}

class SaveKeyLostRecord extends KeyIssuanceProcessRecordEvent {
  final KeyHistoryModel keyHistoryModel;
  final int kmId;

  const SaveKeyLostRecord(
      this.keyHistoryModel,
      this.kmId,
      );
}
