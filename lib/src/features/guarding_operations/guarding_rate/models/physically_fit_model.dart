class PhysicallyFitModel {
  num? gender;
  num? height;
  num? weight;
  num? chest;
  bool? physicallyFit;

  PhysicallyFitModel({
    this.gender,
    this.height,
    this.weight,
    this.chest,
    this.physicallyFit,
  });

  PhysicallyFitModel.fromJson(Map<String, dynamic> json)
      : gender = json['gender'] as num?,
        height = json['height'] as num?,
        weight = json['weight'] as num?,
        chest = json['chest'] as num?,
        physicallyFit = json['physicallyFit'] as bool?;

  Map<String, dynamic> toJson() => {
    'gender' : gender,
    'height' : height,
    'weight' : weight,
    'chest' : chest,
    'physicallyFit' : physicallyFit
  };
}