part of 'material_items_bloc.dart';

abstract class MaterialItemsEvent extends Equatable {
  const MaterialItemsEvent();

  @override
  List<Object?> get props => [];
}

class FetchItemData extends MaterialItemsEvent {
  final int id;
  final int startPos;
  final int maxPos;

  const FetchItemData({
    required this.id,
    required this.startPos,
    required this.maxPos,
  });
}

class InitializeValues extends MaterialItemsEvent {
  const InitializeValues();
}

class SaveRecord extends MaterialItemsEvent {
  final MaterialMovementItem itemsModel;
  final int mainContactId;

  const SaveRecord(
      this.itemsModel,
      this.mainContactId,
      );
}

class DeleteRecord extends MaterialItemsEvent {
  final int id;
  final int mainContactId;

  const DeleteRecord(this.id, this.mainContactId);
}
 