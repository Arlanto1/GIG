//
// class MaterialMovementItemsModel {
//   List<MaterialDetails>? materialDetails;
//
//   MaterialMovementItemsModel({this.materialDetails});
//
//   factory MaterialMovementItemsModel.fromJson(Map<String, dynamic> json) {
//     return MaterialMovementItemsModel(
//       materialDetails: (json['materialDetails'] as List<dynamic>?)
//           ?.map((e) => MaterialDetails.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
//
// class MaterialDetails {
//   final int? id;
//   final String? materialDescription;
//   final int? quantity;
//   final Unit? unit;
//   final String? unitName;
//
//   MaterialDetails({
//     this.id,
//     this.materialDescription,
//     this.quantity,
//     this.unit,
//     this.unitName,
//   });
//
//   MaterialDetails.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         materialDescription = json['materialDescription'] as String?,
//         quantity = json['quantity'] as int?,
//         unit = (json['unit'] as Map<String,dynamic>?) != null ? Unit.fromJson(json['unit'] as Map<String,dynamic>) : null,
//         unitName = json['unitName'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'materialDescription' : materialDescription,
//     'quantity' : quantity,
//     'unit' : unit?.toJson(),
//     'unitName' : unitName
//   };
// }
//
// class Unit {
//   final int? id;
//   final String? name;
//   final String? keyname;
//   final String? description;
//
//   Unit({
//     this.id,
//     this.name,
//     this.keyname,
//     this.description,
//   });
//
//   Unit.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         name = json['name'] as String?,
//         keyname = json['keyname'] as String?,
//         description = json['description'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'name' : name,
//     'keyname' : keyname,
//     'description' : description
//   };
// }

class MaterialDetails {
  final MaterialMovementItem? materialMovementItem;

  MaterialDetails({
    this.materialMovementItem,
  });

  MaterialDetails.fromJson(Map<String, dynamic> json)
      : materialMovementItem = (json['materialMovementItem'] as Map<String,dynamic>?) != null ? MaterialMovementItem.fromJson(json['materialMovementItem'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'materialMovementItem' : materialMovementItem?.toJson()
  };
}

class MaterialMovementItem {
  final int? id;
  final String? materialDescription;
  final int? quantity;
  final Unit? unit;

  MaterialMovementItem({
    this.id,
    this.materialDescription,
    this.quantity,
    this.unit,
  });

  MaterialMovementItem.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        materialDescription = json['materialDescription'] as String?,
        quantity = json['quantity'] as int?,
        unit = (json['unit'] as Map<String,dynamic>?) != null ? Unit.fromJson(json['unit'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'materialDescription' : materialDescription,
    'quantity' : quantity,
    'unit' : unit?.toJson()
  };
}

class Unit {
  final int? id;

  Unit({
    this.id,
  });

  Unit.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id
  };
}