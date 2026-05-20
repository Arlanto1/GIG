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
    this.totalAttendance,
    this.cctvSystemOffline,
    this.cctvSystemOfflineStartDate,
    this.cctvSystemOfflineEndDate,
    this.accessSystemOffline,
    this.accessSystemOfflineStartDate,
    this.accessSystemOfflineEndDate,
    this.intruderSystemOffline,
    this.intruderSystemOfflineStartDate,
    this.intruderSystemOfflineEndDate,
    this.additionalInformation,
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
  int? totalAttendance;
  bool? cctvSystemOffline;
  String? cctvSystemOfflineStartDate;
  String? cctvSystemOfflineEndDate;
  bool? accessSystemOffline;
  String? accessSystemOfflineStartDate;
  String? accessSystemOfflineEndDate;
  bool? intruderSystemOffline;
  String? intruderSystemOfflineStartDate;
  String? intruderSystemOfflineEndDate;
  String? additionalInformation;
  EventInfoResponse.fromJson(Map<String, dynamic> json) {
    log('-json id--${json['id']}-');

    id = json['id'];
    status = json['status'];
    date = json['date'];
    emails = json['emails'];
    email = json['email'];
    lock = json['lock'];
    location = json["location"] == null
        ? null
        : Organisation.fromJson(json["location"]);
    startDate = json['startDate'];
    endDate = json['endDate'];
    eventStartedAt = json['eventStartedAt'];
    eventConcludedAt = json['eventConcludedAt'];
    notification = json['notification'];
    totalAttendance = json['totalAttendance'];
    cctvSystemOffline = json['cctvSystemOffline'];
    cctvSystemOfflineStartDate = json['cctvSystemOfflineStartDate'];
    cctvSystemOfflineEndDate = json['cctvSystemOfflineEndDate'];
    accessSystemOffline = json['accessSystemOffline'];
    accessSystemOfflineStartDate= json['accessSystemOfflineStartDate'];
    accessSystemOfflineEndDate= json['accessSystemOfflineEndDate'];
    intruderSystemOffline = json['intruderSystemOffline'];
    intruderSystemOfflineStartDate= json['intruderSystemOfflineStartDate'];
    intruderSystemOfflineEndDate= json['intruderSystemOfflineEndDate'];
    images =
        List.from(json['images']).map((e) => ImageContent.fromJson(e)).toList();
    additionalInformation = json['additionalInformation'];
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
    data['totalAttendance'] = totalAttendance;
    data['cctvSystemOffline'] = cctvSystemOffline;
    data['cctvSystemOfflineStartDate'] = cctvSystemOfflineStartDate;
    data['cctvSystemOfflineEndDate'] = cctvSystemOfflineEndDate;
    data['accessSystemOffline'] = accessSystemOffline;
    data['accessSystemOfflineStartDate'] = accessSystemOfflineStartDate;
    data['accessSystemOfflineEndDate'] = accessSystemOfflineEndDate;
    data['intruderSystemOffline'] = intruderSystemOffline;
    data['intruderSystemOfflineStartDate'] = intruderSystemOfflineStartDate;
    data['intruderSystemOfflineEndDate'] = intruderSystemOfflineEndDate;
    data['images'] = images?.map((e) => e.toJson()).toList();
    data['additionalInformation'] = additionalInformation;
    return data;
  }
}
