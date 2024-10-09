// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticketing_system_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketingSystemModel _$TicketingSystemModelFromJson(
        Map<String, dynamic> json) =>
    TicketingSystemModel(
      id: (json['id'] as num?)?.toInt(),
      priorityName: json['priorityName'] as String?,
      title: json['title'] as String?,
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
      createdOn: json['createdOn'] as String?,
      startDate: json['startDate'] as String?,
      updatedOn: json['updatedOn'] as String?,
      status: (json['status'] as num?)?.toInt(),
      description: json['description'] as String?,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$TicketingSystemModelToJson(
        TicketingSystemModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'priorityName': instance.priorityName,
      'title': instance.title,
      'projectName': instance.projectName,
      'assignee': instance.assignee,
      'tracker': instance.tracker,
      'project': instance.project,
      'priority': instance.priority,
      'createdOn': instance.createdOn,
      'startDate': instance.startDate,
      'updatedOn': instance.updatedOn,
      'status': instance.status,
      'description': instance.description,
    };
