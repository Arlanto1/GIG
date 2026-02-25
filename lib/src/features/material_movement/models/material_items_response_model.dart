
import '../../../../../index.dart';
import 'material_items_model.dart';

class MaterialItemsResponseModel extends BaseObject {
  final List<MaterialMovementItem>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  MaterialItemsResponseModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  MaterialItemsResponseModel.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
      ?.map((dynamic e) =>
      MaterialMovementItem.fromJson(e as Map<String, dynamic>))
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

class MaterialItemsListModel {
  final List<MaterialMovementItem>? vvipVisitorsRecord;

  MaterialItemsListModel({
    this.vvipVisitorsRecord,
  });

  MaterialItemsListModel.fromJson(Map<String, dynamic> json)
      : vvipVisitorsRecord = (json[''] as List<dynamic>?)
      ?.map((e) =>
      MaterialMovementItem.fromJson(e as Map<String, dynamic>))
      .toList();

  Map<String, dynamic> toJson() => {
    'materialMovementItem':
    vvipVisitorsRecord?.map((e) => e.toJson()).toList(),
  };
}
