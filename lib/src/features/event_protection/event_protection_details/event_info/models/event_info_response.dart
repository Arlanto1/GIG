import 'dart:developer';

import 'package:db_atom/index.dart';

class EventInfoResponse {
  EventInfoResponse({
    this.id,
    this.status,
    this.date,
    this.emails,
    this.notification,
    this.images,
    this.location,
    this.email,
    this.startDate,
    this.lock,
    this.endDate,
    this.eventConcludedAt,
    this.eventStartedAt,
    this.totalAttendies
  });

  int? id;
  int? status;
  String? date;
  String? emails;
  String? email;
  String? notification;
  List<ImageContent>? images;
  String? lock;
  String? startDate;
  String? endDate;
  String? eventStartedAt;
  String? eventConcludedAt;
  Organisation? location;
  int? totalAttendies;

  EventInfoResponse.fromJson(Map<String, dynamic> json) {
    log('-json id--${json['id']}-');

    id = json['id'];
    status = json['status'];
    date = json['date'];
    emails = json['emails'];
    email=json['email'];
    lock = json['lock'];
    location = json["location"] == null
        ? null
        : Organisation.fromJson(json["location"]);
    startDate = json['startDate'];
    endDate = json['endDate'];
    eventStartedAt = json['eventStartedAt'];
    eventConcludedAt = json['eventConcludedAt'];
    notification = json['notification'];
    totalAttendies = json['totalAttendies'];
    images =
        List.from(json['images']).map((e) => ImageContent.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['lock'] = lock;
    data['date'] = date;
    data['location'] = location;
    data['emails'] = emails;
    data['email'] = email;
    data['notification'] = notification;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['eventStartedAt'] = eventStartedAt;
    data['eventConcludedAt'] = eventConcludedAt;
    data['totalAttendies'] = totalAttendies;
    data['images'] = images?.map((e) => e.toJson()).toList();
    return data;
  }
}
