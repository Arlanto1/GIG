part of 'visiting_officials_bloc.dart';

abstract class VisitingOfficialsEvent extends Equatable {
  const VisitingOfficialsEvent();

  @override
  List<Object?> get props => [];
}

class FetchVisitingOfficialsData extends VisitingOfficialsEvent {
  final int id;
  final int startPos;
  final int maxPos;

  const FetchVisitingOfficialsData({
    required this.id,
    required this.startPos,
    required this.maxPos,
  });
}

class InitializeValues extends VisitingOfficialsEvent {
  const InitializeValues();
}

class SaveRecord extends VisitingOfficialsEvent {
  final VisitingOfficialsModel visitingOfficialsModel;
  final int mainContactId;

  const SaveRecord(
      this.visitingOfficialsModel,
      this.mainContactId,
      );
}

class DeleteRecord extends VisitingOfficialsEvent {
  final int id;
  final int mainContactId;

  const DeleteRecord(this.id, this.mainContactId);
}
