import 'package:db_atom/src/models/base_object.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../models/organisation.dart';

part 'contacts_list_response_model.g.dart';

class ContactListResponseModel extends BaseObject {
  List<ContactsListModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  ContactListResponseModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  ContactListResponseModel.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) =>
                ContactsListModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  @override
  Map<String, dynamic> toJson() => {
        'data': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

@JsonSerializable()
class ContactsListModel extends BaseObject {
  final int? id;
  final int? status;
  final String? modifiedBy;
  @JsonKey(name: 'contact')
  final List<Contact>? contacts;

  ContactsListModel({
    this.id,
    this.status,
    this.modifiedBy,
    this.contacts,
  });

  factory ContactsListModel.fromJson(Map<String, dynamic> json) =>
      _$ContactsListModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContactsListModelToJson(this);
}

class Contact {
  final int? id;
  final String? email;
  final String? contactNo;
  final Organisation? rank;
  final int? type;

  Contact({
    this.id,
    this.email,
    this.contactNo,
    this.rank,
    this.type,
  });

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        email = json['email'] as String?,
        contactNo = json['contactNo'] as String?,
        rank = (json['generalRank'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['generalRank'] as Map<String, dynamic>)
            : null,
        type = json['type'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'contactNo': contactNo,
        'generalRank': rank?.toJson(),
        'type': type
      };
}
