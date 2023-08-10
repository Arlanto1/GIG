import 'dart:io';

class ServiceModel {
  ServiceModel({this.status, this.value, this.error});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
        status: json['status'] ?? false,
        value: json['value'],
        error: json['error']);
  }

  bool? status;
  HttpClientResponse? value;
  SocketException? error;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['status'] = status;
    map['value'] = value;
    map['error'] = error;
    return map;
  }
}
