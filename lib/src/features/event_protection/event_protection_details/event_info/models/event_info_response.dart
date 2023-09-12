import 'dart:developer';

import '../../../../createfound/models/create_found_request.dart';

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
  List<CreateImage>? image;

  EventInfoResponse.fromJson(Map<String, dynamic> json) {

    log('-json id--${json['id']}-');

    id = json['id'];
    status = json['status'];
    date = json['date'];
    emails = json['emails'];
    email = json['email'];
    image =
        List.from(json['image']).map((e) => CreateImage.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['date'] = date;
    data['emails'] = emails;
    data['email'] = email;
    data['image'] = image?.map((e) => e.toJson()).toList();
    return data;
  }
}
