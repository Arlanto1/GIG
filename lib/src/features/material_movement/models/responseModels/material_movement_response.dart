// class GenericCreateResponse {
//   GenericCreateResponse({
//      this.message,
//      this.materialMovementID,
//   });
//   String? message;
//   String? materialMovementID;
//   String? id;
//
//   GenericCreateResponse.fromJson(Map<String, dynamic> json){
//     message = json['Message']?? json['message'];
//     materialMovementID = json['Material Movement ID']??json['Guarding Rate Info ID']??json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['Message'] = message;
//     _data['Material Movement ID'] = materialMovementID;
//     return _data;
//   }
// }

class GenericCreateResponse {
  final String? id;
  final String? message;

  GenericCreateResponse({
    this.id,
    this.message,
  });

  GenericCreateResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        message = json['message'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'message' : message
  };
}