// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticketing_system_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketingSystemModel _$TicketingSystemModelFromJson(
        Map<String, dynamic> json) =>
    TicketingSystemModel(
      id: (json['id'] as num?)?.toInt(),
      statusName: json['statusName'] as String?,
      assigneeName: json['assigneeName'] as String?,
      priorityName: json['priorityName'] as String?,
      projectName: json['projectName'] as String?,
      assignee: json['assignee'] == null
          ? null
          : User.fromJson(json['assignee'] as Map<String, dynamic>),
      tracker: json['tracker'] == null
          ? null
          : Organisation.fromJson(json['tracker'] as Map<String, dynamic>),
      project: json['project'] == null
          ? null
          : Organisation.fromJson(json['project'] as Map<String, dynamic>),
      priority: json['priority'] == null
          ? null
          : Organisation.fromJson(json['priority'] as Map<String, dynamic>),
      description: json['description'] as String?,
      history: json['history'] as String?,
      createdOn: json['createdOn'] as String?,
      startDate: json['startDate'] as String?,
      dueDate: json['dueDate'] as String?,
      updatedOn: json['updatedOn'] as String?,
      createdBy: json['createdBy'] as String?,
      status: (json['status'] as num?)?.toInt(),
      title: json['title'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => ImageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String?,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$TicketingSystemModelToJson(
        TicketingSystemModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'statusName': instance.statusName,
      'assigneeName': instance.assigneeName,
      'priorityName': instance.priorityName,
      'projectName': instance.projectName,
      'assignee': instance.assignee,
      'tracker': instance.tracker,
      'project': instance.project,
      'priority': instance.priority,
      'description': instance.description,
      'history': instance.history,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'startDate': instance.startDate,
      'dueDate': instance.dueDate,
      'updatedOn': instance.updatedOn,
      'status': instance.status,
      'title': instance.title,
      'attachments': instance.attachments,
      'notes': instance.notes,
    };
