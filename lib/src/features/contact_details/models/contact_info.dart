import 'package:db_atom/src/models/organisation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_info.g.dart';

@JsonSerializable()
class ContactRecord {
  int? id;
  int? contactId;
  String? email;
  String? contactNo;
  Organisation? rank;
  int? type;

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
