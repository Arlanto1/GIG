
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/key_issuance_process_model.dart';

import '../../../../../../index.dart';

part 'key_issuance_process_list_model.g.dart';

class KeyManagementProcessListResponseModel extends BaseObject {
  List<KeyManagementProcessListModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  KeyManagementProcessListResponseModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  KeyManagementProcessListResponseModel.fromJson(Map<String, dynamic> json)
      : items = (json[''] as List?)
      ?.map((dynamic e) =>
      KeyManagementProcessListModel.fromJson(e as Map<String, dynamic>))
      .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  @override
  Map<String, dynamic> toJson() => {
    '': items?.map((e) => e.toJson()).toList(),
    'totalCount': totalCount,
    'currentPageNo': currentPageNo,
    'totalPageCount': totalPageCount
  };
}

@JsonSerializable()
class KeyManagementProcessListModel extends BaseObject {
  final List<KeyIssuanceProcessRecord>? keyIssuanceProcessRecord;

  KeyManagementProcessListModel({
    this.keyIssuanceProcessRecord,
  });

  factory KeyManagementProcessListModel.fromJson(Map<String, dynamic> json) =>
      _$KeyManagementProcessListModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$KeyManagementProcessListModelToJson(this);
}

