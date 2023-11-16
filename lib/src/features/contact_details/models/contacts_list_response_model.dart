import 'package:db_atom/src/models/base_object.dart';

import '../../../models/organisation.dart';
import '../../createfound/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

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
  final List<Contacts>? contact;

  ContactsListModel({
    this.id,
    this.status,
    this.modifiedBy,
    this.contact,
  });


  factory ContactsListModel.fromJson(Map<String, dynamic> json) =>
      _$ContactsListModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContactsListModelToJson(this);

}

class Contacts  {
  final int? id;
  final String? email;
  final String? contactNo;
  final Organisation? generalRank;
  final int? type;

  Contacts({
    this.id,
    this.email,
    this.contactNo,
    this.generalRank,
    this.type,
  });

  Contacts.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        email = json['email'] as String?,
        contactNo = json['contactNo'] as String?,
        generalRank = (json['generalRank'] as Map<String,dynamic>?) != null ? Organisation.fromJson(json['generalRank'] as Map<String,dynamic>) : null,
        type = json['type'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'email' : email,
    'contactNo' : contactNo,
    'generalRank' : generalRank?.toJson(),
    'type' : type
  };
}


