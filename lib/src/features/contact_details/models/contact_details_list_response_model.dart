import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/models/base_object.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../models/organisation.dart';

part 'contact_details_list_response_model.g.dart';

class ContactDetailsListResponseModel extends BaseObject {
  List<ContactDetailModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  ContactDetailsListResponseModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  ContactDetailsListResponseModel.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) =>
                ContactDetailModel.fromJson(e as Map<String, dynamic>))
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
class ContactDetailModel extends BaseObject {
  int? id;
  String? slNo;
  Organisation? location;
  Organisation? locationRegion;
  String? inputDate;
  User? entrySecurity;
  String? modifiedDate;
  String? modifiedBy;
  int? status;

  ContactDetailModel({
    this.id,
    this.slNo,
    this.location,
    this.locationRegion,
    this.inputDate,
    this.entrySecurity,
    this.modifiedDate,
    this.modifiedBy,
    this.status,
  });

  factory ContactDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ContactDetailModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContactDetailModelToJson(this);
}
