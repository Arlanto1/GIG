// part of 'key_history_record_bloc.dart';
//
// abstract class KeyHistoryRecordEvent extends Equatable {
//   const KeyHistoryRecordEvent();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class FetchData extends KeyHistoryRecordEvent {
//   final int id;
//   final int type;
//   final int startPos;
//   final int maxPos;
//
//   const FetchData({
//     required this.id,
//     required this.type,
//     required this.startPos,
//     required this.maxPos,
//   });
// }
//
// class InitializeValues extends KeyHistoryRecordEvent {
//   const InitializeValues();
// }
//
// class SaveRecord extends KeyHistoryRecordEvent {
//   final ContactRecord contactInfo;
//   final int mainContactId;
//   final int type;
//
//   const SaveRecord(this.contactInfo, this.mainContactId, this.type);
// }
//
// class DeleteRecord extends KeyHistoryRecordEvent {
//   final int id;
//   final int mainContactId;
//   final int type;
//
//   const DeleteRecord(this.id, this.type, this.mainContactId);
// }
