part of 'contact_record_bloc.dart';

abstract class ContactRecordEvent extends Equatable {
  const ContactRecordEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends ContactRecordEvent {
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

class InitializeValues extends ContactRecordEvent {
  const InitializeValues();
}

class SaveRecord extends ContactRecordEvent {
  final ContactRecord contactInfo;
  final int mainContactId;
  final int type;

  const SaveRecord(this.contactInfo, this.mainContactId, this.type);
}

class DeleteRecord extends ContactRecordEvent {
  final int id;
  final int mainContactId;
  final int type;

  const DeleteRecord(this.id, this.type, this.mainContactId);
}

class RefreshContactRecordsList extends ContactRecordEvent {
  const RefreshContactRecordsList();
}
