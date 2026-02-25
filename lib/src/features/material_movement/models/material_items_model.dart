
import '../../../../index.dart';
class MaterialMovementItem {
  final int? id;
  String? materialDescription;
  int? quantity;
  Organisation? unit;
  String? modelInfo;


  MaterialMovementItem({
    this.id,
    this.materialDescription,
    this.quantity,
    this.unit,
    this.modelInfo
  });

  MaterialMovementItem.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        materialDescription = json['materialDescription'] as String?,
        quantity = json['quantity'] as int?,
        unit = (json['unit'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['unit'] as Map<String,dynamic>) : null,
        modelInfo = json['modelInfo'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'materialDescription' : materialDescription,
    'quantity' : quantity,
    'unit' : unit?.toJson(),
    'modelInfo': modelInfo,
  };
}
 