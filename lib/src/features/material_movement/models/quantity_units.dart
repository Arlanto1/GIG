class QuantityUnits {
  final List<QuantityUnit>? units;

  QuantityUnits({
    this.units,
  });

  QuantityUnits.fromJson(Map<String, dynamic> json)
      : units = (json['ATOM_MATERIAL_MOVEMENT_UNIT'] as List?)?.map((dynamic e) => QuantityUnit.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'Unit' : units?.map((e) => e.toJson()).toList()
  };
}

class QuantityUnit {
  final int? id;
  final String? name;

  QuantityUnit({
    this.id,
    this.name,
  });

  QuantityUnit.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name
  };
}