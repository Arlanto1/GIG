import 'dart:developer';

import 'package:db_atom/index.dart';

class TransportEmailNotificationResponse {
  final List<TransportEmailNotificationModel>? data;

  TransportEmailNotificationResponse({this.data});

  factory TransportEmailNotificationResponse.fromJson(Map<String, dynamic> json) {
    return TransportEmailNotificationResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TransportEmailNotificationModel.fromJson(e))
          .toList(),
    );
  }
}
class TransportEmailNotificationModel {
  TransportEmailNotificationModel({
    this.id,
    this.status,
    this.emails,
    this.notification,
    this.images,
    this.location,
    this.email,
    this.lock,
  });

  int? id;
  int? status;
  String? emails;
  String? email;
  String? notification;
  List<ImageContent>? images;
  String? lock;
  Organisation? location;

  TransportEmailNotificationModel.fromJson(Map<String, dynamic> json) {
    log('-json id--${json['id']}-');

    id = json['id'];
    status = json['status'];
    emails = json['emails'];
    email=json['email'];
    lock = json['lock'];
    location = json["location"] == null
        ? null
        : Organisation.fromJson(json["location"]);

    notification = json['notification'];
    images =
        List.from(json['images']).map((e) => ImageContent.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['lock'] = lock;
    data['location'] = location;
    data['emails'] = emails;
    data['email'] = email;
    data['notification'] = notification;
    data['images'] = images?.map((e) => e.toJson()).toList();
    return data;
  }
}
