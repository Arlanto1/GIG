import 'package:db_atom/index.dart';

class NotificationsResponseModel {
  final List<NotificationModel>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  NotificationsResponseModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  NotificationsResponseModel.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) =>
                NotificationModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
        'data': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

class NotificationModel {
  final int? id;
  final String? email;
  final Content? content;
  final int? status;
  final String? createdDate;
  final List<ImageContent>? attachments;
  final int? moduleId;
  final String? moduleCode;

  NotificationModel({
    this.id,
    this.email,
    this.content,
    this.status,
    this.createdDate,
    this.attachments,
    this.moduleId,
    this.moduleCode,
  });

  NotificationModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        email = json['email'] as String?,
        content = (json['content'] as Map<String, dynamic>?) != null
            ? Content.fromJson(json['content'] as Map<String, dynamic>)
            : null,
        status = json['status'] as int?,
        createdDate = json['createdDate'] as String?,
        attachments = (json['attachments'] as List?)
            ?.map(
                (dynamic e) => ImageContent.fromJson(e as Map<String, dynamic>))
            .toList(),
        moduleId = json['moduleId'] as int?,
        moduleCode = json['moduleCode'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'content': content?.toJson(),
        'status': status,
        'createdDate': createdDate,
        'attachments': attachments?.map((e) => e.toJson()).toList(),
        'moduleId': moduleId,
        'moduleCode': moduleCode
      };
}

class Content {
  final int? id;
  final String? subject;
  final String? text;
  final int? transferDate;

  Content({
    this.id,
    this.subject,
    this.text,
    this.transferDate,
  });

  Content.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        subject = json['subject'] as String?,
        text = json['text'] as String?,
        transferDate = json['transferDate'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'subject': subject,
        'text': text,
        'transferDate': transferDate
      };
}
