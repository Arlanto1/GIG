import 'package:db_atom/src/models/organisation.dart';

class QuantityUnits {
  final List<Organisation>? units;

  QuantityUnits({
    this.units,
  });

  QuantityUnits.fromJson(Map<String, dynamic> json)
      : units = (json['ATOM_MATERIAL_MOVEMENT_UNIT'] as List?)
            ?.map(
                (dynamic e) => Organisation.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'Unit': units?.map((e) => e.toJson()).toList()};
}


class MaterialItem {
  String? materialDescription;
  int? quantity;
  Organisation? unit;
  String? equipmentNo;
  MaterialItem({
    this.materialDescription,
    this.quantity,
    this.unit,
    this.equipmentNo,
  });
}
