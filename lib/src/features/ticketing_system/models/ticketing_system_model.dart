import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/ticketing_system/models/activityNote_model.dart';

part 'ticketing_system_model.g.dart';

@JsonSerializable()
class TicketingSystemModel extends BaseObject {
  int? id;
  String? statusName;
  String? assigneeName;
  String? priorityName;
  String? projectName;
  User? assignee;
  Organisation? tracker;
  Organisation? project;
  Organisation? priority;
  String? description;
  String? history;
  String? createdBy;
  String? createdOn;
  String? startDate;
  String? dueDate;
  String? updatedOn;
  int? status;
  String? title;
  List<ImageContent>? attachments;
  String? notes;


  TicketingSystemModel({
    this.id,
    this.statusName,
    this.assigneeName,
    this.priorityName,
    this.projectName,
    this.assignee,
    this.tracker,
    this.project,
    this.priority,
    this.description,
    this.history,
    this.createdOn,
    this.startDate,
    this.dueDate,
    this.updatedOn,
    this.createdBy,
    this.status,
    this.title,
    this.attachments,
    this.notes,
  });

  factory TicketingSystemModel.fromJson(Map<String, dynamic> json) =>
      _$TicketingSystemModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TicketingSystemModelToJson(this);
}
