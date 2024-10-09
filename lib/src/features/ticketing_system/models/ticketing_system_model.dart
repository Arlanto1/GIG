import 'package:db_atom/index.dart';

part 'ticketing_system_model.g.dart';

@JsonSerializable()
class TicketingSystemModel extends BaseObject {
  int? id;
  String? statusName;
  String? assigneeName;
  String? priorityName;
  String? title;
  String? projectName;

  TicketingSystemModel({
    this.id,
    this.statusName,
    this.assigneeName,
    this.priorityName,
    this.title,
    this.projectName,
  });

  factory TicketingSystemModel.fromJson(Map<String, dynamic> json) =>
      _$TicketingSystemModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TicketingSystemModelToJson(this);
}
