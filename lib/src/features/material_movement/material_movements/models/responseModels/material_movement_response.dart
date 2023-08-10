class MaterialMovementResponse {
  MaterialMovementResponse({
    required this.message,
    required this.materialMovementID,
  });
  late final String message;
  late final String materialMovementID;

  MaterialMovementResponse.fromJson(Map<String, dynamic> json){
    message = json['Message'];
    materialMovementID = json['Material Movement ID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Message'] = message;
    _data['Material Movement ID'] = materialMovementID;
    return _data;
  }
}