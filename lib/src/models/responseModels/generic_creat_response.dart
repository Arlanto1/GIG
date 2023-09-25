class GenericCreateResponse {
  GenericCreateResponse({
     this.id,
     this.message,
  });
 String? id;
 String? message;

  GenericCreateResponse.fromJson(Map<String, dynamic> json){
    id = json['id'];
    message = json['message']??json['msg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['message'] = message;
    return _data;
  }
}