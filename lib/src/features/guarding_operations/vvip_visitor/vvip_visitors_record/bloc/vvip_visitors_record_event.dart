part of 'vvip_visitors_record_bloc.dart';

abstract class VVIPVisitorsRecordEvent extends Equatable {
  const VVIPVisitorsRecordEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends VVIPVisitorsRecordEvent {
  final int id;
  final int startPos;
  final int maxPos;

  const FetchData({
    required this.id,
    required this.startPos,
    required this.maxPos,
  });
}

class InitializeValues extends VVIPVisitorsRecordEvent {
  const InitializeValues();
}

class SaveRecord extends VVIPVisitorsRecordEvent {
  final VIVPVisitorRecords vViPVisitorRecordModel;
  final int mainContactId;

  const SaveRecord(
      this.vViPVisitorRecordModel,
      this.mainContactId,
      );
}

class DeleteRecord extends VVIPVisitorsRecordEvent {
  final int id;
  final int mainContactId;

  const DeleteRecord(this.id, this.mainContactId);
}
