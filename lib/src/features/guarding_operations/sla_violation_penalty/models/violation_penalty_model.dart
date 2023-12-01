import 'package:db_atom/src/models/organisation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'violation_penalty_model.g.dart';

@JsonSerializable()
class ViolationPenaltyRecord {
  num? id;
  num? svpId;
  Organisation? violation;
  double? penaltyAmount;
  num? totalViolations;
  num? staffCategory;
  double? totalPenaltyAmount;

  ViolationPenaltyRecord({
    this.id,
    this.svpId,
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
   // class Violation {
   // Violation({
   // required this.id,
   // required this.name,
   // required this.keyname,
   // required this.description,
   // });
   // late final int id;
   // late final String name;
   // late final String keyname;
   // late final String description;
   //
   // Violation.fromJson(Map<String, dynamic> json){
   // id = json['id'];
   // name = json['name'];
   // keyname = json['keyname'];
   // description = json['description'];
   // }
   //
   // Map<String, dynamic> toJson() {
   // final _data = <String, dynamic>{};
   // _data['id'] = id;
   // _data['name'] = name;
   // _data['keyname'] = keyname;
   // _data['description'] = description;
   // return _data;
   // }
//}



