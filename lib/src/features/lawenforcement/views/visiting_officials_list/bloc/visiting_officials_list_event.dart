part of 'visiting_officials_list_bloc.dart';

abstract class VisitingOfficialListEvent extends Equatable {
  const VisitingOfficialListEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends VisitingOfficialListEvent {
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

class InitializeValues extends VisitingOfficialListEvent {
  const InitializeValues();
}

class SaveRecord extends VisitingOfficialListEvent {
  final LawVisitingOfficial model;
  final int parentId;

  const SaveRecord({required this.model, required this.parentId});
}

class DeleteRecord extends VisitingOfficialListEvent {
  final int id;
  final int parentId;
  final int type;

  const DeleteRecord(this.id, this.type, this.parentId);
}
