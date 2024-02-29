class PowerFailureModel {
  final dynamic id;
  final dynamic powerFailureStartDate;
  final dynamic powerFailureEndDate;

  PowerFailureModel({
    this.id,
    this.powerFailureStartDate,
    this.powerFailureEndDate,
  });

  PowerFailureModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        powerFailureStartDate = json['powerFailureStartDate'],
        powerFailureEndDate = json['powerFailureEndDate'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'powerFailureStartDate' : powerFailureStartDate,
    'powerFailureEndDate' : powerFailureEndDate
  };
}