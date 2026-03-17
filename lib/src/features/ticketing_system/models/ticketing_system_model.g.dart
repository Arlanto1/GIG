// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticketing_system_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketingSystemModel _$TicketingSystemModelFromJson(
        Map<String, dynamic> json) =>
    TicketingSystemModel(
      id: (json['id'] as num?)?.toInt(),
      ticketNo: json['ticketNo'] as String?,
      location: json['location'] == null
          ? null
          : Organisation.fromJson(json['location'] as Map<String, dynamic>),
      modulesName: (json['modulesName'] as List<dynamic>?)
          ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdBy: json['createdBy'] == null
          ? null
          : User.fromJson(json['createdBy'] as Map<String, dynamic>),
      ticketType: (json['ticketType'] as num?)?.toInt(),
      inputDate: json['inputDate'] as String?,
      fromDate: json['fromDate'] as String?,
      toDate: json['toDate'] as String?,
      priorityType: (json['priorityType'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      title: json['title'] as String?,
      assignee: json['assignee'] as String?,
      bugDescription: json['bugDescription'] as String?,
      cancelReason: json['cancelReason'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      modifiedDate: json['modifiedDate'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
      issuedForm: (json['issuedForm'] as num?)?.toInt(),
      ragStatus: (json['ragStatus'] as num?)?.toInt(),
      activityNotes: (json['activityNotes'] as List<dynamic>?)
          ?.map((e) => ActivityNote.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$TicketingSystemModelToJson(
        TicketingSystemModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'ticketNo': instance.ticketNo,
      'location': instance.location,
      'modulesName': instance.modulesName,
      'createdBy': instance.createdBy,
      'ticketType': instance.ticketType,
      'inputDate': instance.inputDate,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'priorityType': instance.priorityType,
      'status': instance.status,
      'title': instance.title,
      'assignee': instance.assignee,
      'bugDescription': instance.bugDescription,
      'cancelReason': instance.cancelReason,
      'attachments': instance.attachments,
      'modifiedDate': instance.modifiedDate,
      'modifiedBy': instance.modifiedBy,
      'issuedForm': instance.issuedForm,
      'ragStatus': instance.ragStatus,
      'activityNotes': instance.activityNotes,
    };
