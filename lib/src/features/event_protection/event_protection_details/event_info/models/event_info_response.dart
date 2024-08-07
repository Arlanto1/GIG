import 'dart:developer';

import 'package:db_atom/src/models/image_content.dart';

class EventInfoResponse {
  EventInfoResponse({
    this.id,
    this.status,
    this.date,
    this.emails,
    this.email,
    this.image,
  });

  int? id;
  int? status;
  String? date;
  String? emails;
  String? email;
  List<ImageContent>? image;
  String? lock;
  String? startDate;
  String? endDate;

  EventInfoResponse.fromJson(Map<String, dynamic> json) {
    log('-json id--${json['id']}-');

    id = json['id'];
    status = json['status'];
    date = json['date'];
    emails = json['emails'];
    lock = json['lock'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    email = json['email'];
    image =
        List.from(json['image']).map((e) => ImageContent.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['lock'] = lock;
    data['date'] = date;
    data['emails'] = emails;
    data['email'] = email;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['image'] = image?.map((e) => e.toJson()).toList();
    return data;
  }
}
