import 'package:db_atom/index.dart';

part 'ticketing_system_model.g.dart';

@JsonSerializable()
class TicketingSystemModel extends BaseObject {
  int? id;
  String? priorityName;
  String? title;
  String? projectName;
  User? assignee;
  Organisation? tracker;
  Organisation? project;
  Organisation? priority;
  String? createdOn;
  String? startDate;
  String? updatedOn;
  int? status;
  String? description;

  TicketingSystemModel({
    this.id,
    this.priorityName,
    this.title,
    this.projectName,
    this.assignee,
    this.tracker,
    this.project,
    this.priority,
    this.createdOn,
    this.startDate,
    this.updatedOn,
    this.status,
    this.description,
  });

  factory TicketingSystemModel.fromJson(Map<String, dynamic> json) =>
      _$TicketingSystemModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TicketingSystemModelToJson(this);
}
