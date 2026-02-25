
import '../material_items_model.dart';

class MaterialItemsRequest{
  MaterialMovementItem? items;

  MaterialItemsRequest({
    this.items,
  });

  MaterialItemsRequest.fromJson(Map<String, dynamic> json)
      : items = (json['materialMovementItem'] as Map<String, dynamic>?) != null
      ? MaterialMovementItem.fromJson(
      json['materialMovementItem'] as Map<String, dynamic>)
      : null;

  Map<String, dynamic> toJson() => {'materialMovementItem': items?.toJson()};
}
