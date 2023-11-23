import 'package:db_atom/src/models/organisation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_info_g.dart';

@JsonSerializable()
class ContactInfo {
  final int? id;
  final int? contactId;
  final String? email;
  final String? contactNo;
  final Organisation? rank;
  final int? type;

  ContactInfo({
    this.id,
    this.contactId,
    this.email,
    this.contactNo,
    this.rank,
    this.type,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) =>
      _$ContactInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ContactInfoToJson(this);
}
