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
    this.cctvSystemOfflineHours,
    this.cctvSystemOfflineStartDate,
    this.cctvSystemOfflineEndDate,
    this.accessSystemOffline,
    this.accessSystemOfflineHours,
    this.accessSystemOfflineStartDate,
    this.accessSystemOfflineEndDate,
    this.intruderSystemOffline,
    this.intruderSystemOfflineHours,
    this.intruderSystemOfflineStartDate,
    this.intruderSystemOfflineEndDate,
    this.additionalInformation,
    this.canEdit,
    this.readOnly
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
  int? cctvSystemOfflineHours;
  String? cctvSystemOfflineStartDate;
  String? cctvSystemOfflineEndDate;
  bool? accessSystemOffline;
  int? accessSystemOfflineHours;
  String? accessSystemOfflineStartDate;
  String? accessSystemOfflineEndDate;
  bool? intruderSystemOffline;
  int? intruderSystemOfflineHours;

  String? intruderSystemOfflineStartDate;
  String? intruderSystemOfflineEndDate;
  String? additionalInformation;
  bool? canEdit;
  bool? readOnly;
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
    cctvSystemOfflineHours = json['cctvSystemOfflineHours'];
    cctvSystemOfflineStartDate = json['cctvSystemOfflineStartDate'];
    cctvSystemOfflineEndDate = json['cctvSystemOfflineEndDate'];
    accessSystemOffline = json['accessSystemOffline'];
    accessSystemOfflineHours = json['accessSystemOfflineHours'];
    accessSystemOfflineStartDate= json['accessSystemOfflineStartDate'];
    accessSystemOfflineEndDate= json['accessSystemOfflineEndDate'];
    intruderSystemOffline = json['intruderSystemOffline'];
    intruderSystemOfflineHours = json['intruderSystemOfflineHours'];
    intruderSystemOfflineStartDate= json['intruderSystemOfflineStartDate'];
    intruderSystemOfflineEndDate= json['intruderSystemOfflineEndDate'];
    images =
        List.from(json['images']).map((e) => ImageContent.fromJson(e)).toList();
    additionalInformation = json['additionalInformation'];
    canEdit = json['canEdit'];
    readOnly = json['readOnly'];
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
    data['cctvSystemOfflineHours'] = cctvSystemOfflineHours;
    data['cctvSystemOfflineStartDate'] = cctvSystemOfflineStartDate;
    data['cctvSystemOfflineEndDate'] = cctvSystemOfflineEndDate;
    data['accessSystemOffline'] = accessSystemOffline;
    data['accessSystemOfflineHours'] = accessSystemOfflineHours;
    data['accessSystemOfflineStartDate'] = accessSystemOfflineStartDate;
    data['accessSystemOfflineEndDate'] = accessSystemOfflineEndDate;
    data['intruderSystemOffline'] = intruderSystemOffline;
    data['intruderSystemOfflineHours'] = intruderSystemOfflineHours;
    data['intruderSystemOfflineStartDate'] = intruderSystemOfflineStartDate;
    data['intruderSystemOfflineEndDate'] = intruderSystemOfflineEndDate;
    data['images'] = images?.map((e) => e.toJson()).toList();
    data['additionalInformation'] = additionalInformation;
    data['canEdit'] = canEdit;
    data['readOnly'] = readOnly;
    return data;
  }
}
