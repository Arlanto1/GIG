import '../../../../../../index.dart';


// class EventNotificationResponse {
//   final List<EventNotificationModel>? items;
//   final int? totalCount;
//   final int? currentPageNo;
//   final int? totalPageCount;
//
//   EventNotificationResponse({
//     this.items,
//     this.totalCount,
//     this.currentPageNo,
//     this.totalPageCount,
//   });
//
//   EventNotificationResponse.fromJson(Map<String, dynamic> json)
//       : items = (json['data'] as List?)
//       ?.map((dynamic e) =>
//       EventNotificationModel.fromJson(e as Map<String, dynamic>))
//       .toList(),
//         totalCount = json['totalCount'] as int?,
//         currentPageNo = json['currentPageNo'] as int?,
//         totalPageCount = json['totalPageCount'] as int?;
//
//   Map<String, dynamic> toJson() => {
//     'data': items?.map((e) => e.toJson()).toList(),
//     'totalCount': totalCount,
//     'currentPageNo': currentPageNo,
//     'totalPageCount': totalPageCount
//   };
// }

class EventNotificationResponse {
  final List<EventNotificationModel>? data;

  EventNotificationResponse({this.data});

  factory EventNotificationResponse.fromJson(Map<String, dynamic> json) {
    return EventNotificationResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => EventNotificationModel.fromJson(e))
          .toList(),
    );
  }
}

// class EventNotificationModel {
//   int? id;
//   int? status;
//   String? emails;
//   String? notification;
//   List<ImageContent>? images;
//   String? startDate;
//   Organisation? location;
//
//   EventNotificationModel({
//     this.id,
//     this.status,
//     this.emails,
//     this.notification,
//     this.images,
//     this.location,
//     this.startDate,
//   });
//
//   EventNotificationModel.fromJson(Map<String, dynamic> json) {
//     final data = json['eventNotification'] as Map<String, dynamic>?;
//     id = data?['id'] as int?;
//     status = data?['status'] as int?;
//     emails = data?['emails'] as String?;
//     notification = data?['notification'] as String?;
//     startDate = data?['startDate'] as String?;
//     location = (json['location'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['location'] as Map<String,dynamic>) : null;
//     images = (json['images'] as List?)?.map((dynamic e) => ImageContent.fromJson(e as Map<String,dynamic>)).toList();
//   }
//
//   Map<String, dynamic> toJson() => {
//     'id':id,
//     'status': status,
//     'emails': emails,
//     'notification': notification,
//     'startDate': startDate,
//     'location': location,
//     'images':images,
//   };
// }
class EventNotificationModel {
  int? id;
  int? status;
  String? emails;
  String? notification;
  List<ImageContent>? images;
  String? startDate;
  Organisation? location;

  EventNotificationModel({
    this.id,
    this.status,
    this.emails,
    this.notification,
    this.images,
    this.location,
    this.startDate,
  });

  EventNotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    emails = json['emails'];
    notification = json['notification'];
    startDate = json['startDate'];

    location = json['location'] != null
        ? Organisation.fromJson(json['location'])
        : null;

    images = (json['images'] as List?)
        ?.map((e) => ImageContent.fromJson(e))
        .toList();
  }
}

