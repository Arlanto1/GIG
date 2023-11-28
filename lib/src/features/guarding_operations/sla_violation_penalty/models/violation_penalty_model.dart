import 'package:db_atom/src/models/organisation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'violation_penalty_model.g.dart';

@JsonSerializable()
class ViolationPenaltyRecord {
  // final int? id;
  // final int? contactId;
  // final String? email;
  // final String? contactNo;
  // final Organisation? violation;
  // final int? type;
  final int? id;
  final Violation? violation;
  final int? penaltyAmount;
  final int? totalViolations;
  final int? staffCategory;
  final int? totalPenaltyAmount;

  ViolationPenaltyRecord({
    this.id,
    this.violation,
    this.penaltyAmount,
    this.totalViolations,
    this.staffCategory,
    this.totalPenaltyAmount,
  });

  factory ViolationPenaltyRecord.fromJson(Map<String, dynamic> json) =>
      _$ViolationPenaltyRecordFromJson(json);

  Map<String, dynamic> toJson() => _$ViolationPenaltyRecordToJson(this);

}
   class Violation {
   Violation({
   required this.id,
   required this.name,
   required this.keyname,
   required this.description,
   });
   late final int id;
   late final String name;
   late final String keyname;
   late final String description;

   Violation.fromJson(Map<String, dynamic> json){
   id = json['id'];
   name = json['name'];
   keyname = json['keyname'];
   description = json['description'];
   }

   Map<String, dynamic> toJson() {
   final _data = <String, dynamic>{};
   _data['id'] = id;
   _data['name'] = name;
   _data['keyname'] = keyname;
   _data['description'] = description;
   return _data;
   }
}



