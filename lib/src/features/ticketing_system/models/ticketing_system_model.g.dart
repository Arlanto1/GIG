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
      title: json['title'] as String?,
      projectName: json['projectName'] as String?,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$TicketingSystemModelToJson(
        TicketingSystemModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'id': instance.id,
      'statusName': instance.statusName,
      'assigneeName': instance.assigneeName,
      'priorityName': instance.priorityName,
      'title': instance.title,
      'projectName': instance.projectName,
    };
