class PhysicallyFitModel {
  int? gender;
  int? height;
  int? weight;
  int? chest;
  bool? physicallyFit;

  PhysicallyFitModel({
    this.gender,
    this.height,
    this.weight,
    this.chest,
    this.physicallyFit,
  });

  PhysicallyFitModel.fromJson(Map<String, dynamic> json)
      : gender = json['gender'] as int?,
        height = json['height'] as int?,
        weight = json['weight'] as int?,
        chest = json['chest'] as int?,
        physicallyFit = json['physicallyFit'] as bool?;

  Map<String, dynamic> toJson() => {
    'gender' : gender,
    'height' : height,
    'weight' : weight,
    'chest' : chest,
    'physicallyFit' : physicallyFit
  };
}