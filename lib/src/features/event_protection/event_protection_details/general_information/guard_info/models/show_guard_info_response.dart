class ShowGuardInfoResponse {
  ShowGuardInfoResponse({
    required this.showGuardInfo,
    required this.id,
  });
  bool? showGuardInfo;
  int? id;

  ShowGuardInfoResponse.fromJson(Map<String, dynamic> json){
    showGuardInfo = json['showGuardInfo'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['showGuardInfo'] = showGuardInfo;
    data['id'] = id;
    return data;
  }
}