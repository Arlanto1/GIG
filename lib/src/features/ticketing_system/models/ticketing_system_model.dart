
import 'package:db_atom/index.dart';

part 'ticketing_system_model.g.dart';

@JsonSerializable()
class TicketingSystemModel extends BaseObject  {
  final int? id;
  final String? statusName;
  final String? assigneeName;
  final String? priorityName;
  final String? title;
  final String? projectName;

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
