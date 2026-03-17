import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/ticketing_system/models/activityNote_model.dart';

part 'ticketing_system_model.g.dart';

@JsonSerializable()
class TicketingSystemModel extends BaseObject {
  int? id;
  String? ticketNo;
  Organisation? location;
  List<Organisation>? modulesName;
  User? createdBy;
  int? ticketType;
  String? inputDate;
  String? fromDate;
  String? toDate;
  int? priorityType;
  int? status;
  String? title;
  String? assignee;
  String? bugDescription;
  String? cancelReason;
  List<ImageContent>? attachments;
  String? modifiedDate;
  String? modifiedBy;
  int? issuedForm;
  int? ragStatus;
  List<ActivityNote>? activityNotes;

  TicketingSystemModel({
    this.id,
    this.ticketNo,
    this.location,
    this.modulesName,
    this.createdBy,
    this.ticketType,
    this.inputDate,
    this.fromDate,
    this.toDate,
    this.priorityType,
    this.status,
    this.title,
    this.assignee,
    this.bugDescription,
    this.cancelReason,
    this.attachments,
    this.modifiedDate,
    this.modifiedBy,
    this.issuedForm,
    this.ragStatus,
    this.activityNotes,
  });

  factory TicketingSystemModel.fromJson(Map<String, dynamic> json) =>
      _$TicketingSystemModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TicketingSystemModelToJson(this);

}
