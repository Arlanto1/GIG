class PowerFailureModel {
  int? id;
  String? powerFailureStartDate;
  String? powerFailureEndDate;

  PowerFailureModel({
    this.id,
    this.powerFailureStartDate,
    this.powerFailureEndDate,
  });

  PowerFailureModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        powerFailureStartDate = json['powerFailureStartDate'] as String?,
        powerFailureEndDate = json['powerFailureEndDate'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'powerFailureStartDate': powerFailureStartDate,
        'powerFailureEndDate': powerFailureEndDate
      };
}

class StringResponse {
  String? comments;

  StringResponse({
    this.comments,
  });

  StringResponse.fromJson(Map<String, dynamic> json)
      : comments = json['comments'] as String?;

  Map<String, dynamic> toJson() => {
        'comments': comments,
      };
}
