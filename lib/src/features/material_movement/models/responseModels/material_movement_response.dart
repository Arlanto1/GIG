class MaterialMovementResponse {
  MaterialMovementResponse({
     this.message,
     this.materialMovementID,
  });
  late final String? message;
  late final String? materialMovementID;
  late final String? id;

  MaterialMovementResponse.fromJson(Map<String, dynamic> json){
    message = json['Message']?? json['message'];
    materialMovementID = json['Material Movement ID']??json['Guarding Rate Info ID']??json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Message'] = message;
    _data['Material Movement ID'] = materialMovementID;
    return _data;
  }
}