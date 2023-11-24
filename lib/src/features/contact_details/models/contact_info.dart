import 'package:db_atom/src/models/organisation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_info.g.dart';

@JsonSerializable()
class ContactRecord {
  final int? id;
  final int? contactId;
  final String? email;
  final String? contactNo;
  final Organisation? rank;
  final int? type;

  ContactRecord({
    this.id,
    this.contactId,
    this.email,
    this.contactNo,
    this.rank,
    this.type,
  });

  factory ContactRecord.fromJson(Map<String, dynamic> json) =>
      _$ContactRecordFromJson(json);

  Map<String, dynamic> toJson() => _$ContactRecordToJson(this);
}
