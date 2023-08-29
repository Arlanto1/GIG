class GenericCreateResponse {
  GenericCreateResponse({
    this.message,
    this.guardingMasterDataID,
  });

  late final String? message;
  late final String? guardingMasterDataID;
  late final String? id;

  GenericCreateResponse.fromJson(Map<String, dynamic> json) {
    message = json['Message'] ?? json['message'];
    guardingMasterDataID = json['Guarding Master Data ID'] ??
        json['Guarding Rate Info ID'] ??
        json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Message'] = message;
    _data['Guarding Master Data ID'] = guardingMasterDataID;
    return _data;
  }
}
