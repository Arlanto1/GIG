import 'package:db_atom/index.dart';

class DutyPostMasterResponse {
  List<DutyPostMasterModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  DutyPostMasterResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  DutyPostMasterResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) =>
                DutyPostMasterModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
        'data': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

@JsonSerializable()
class DutyPostMasterModel extends BaseObject {
  int? id;
  Organisation? location;
  Organisation? region;
  Organisation? dutyPostLocation;
  int? shiftA;
  int? shiftB;
  int? shiftC;
  int? shiftG;
  int? rankId;
  int? total;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;

  DutyPostMasterModel({
    this.id,
    this.location,
    this.region,
    this.dutyPostLocation,
    this.shiftA,
    this.shiftB,
    this.shiftC,
    this.shiftG,
    this.rankId,
    this.total,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
  });

  DutyPostMasterModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        region = (json['region'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['region'] as Map<String, dynamic>)
            : null,
        dutyPostLocation =
            (json['dutyPostLocation'] as Map<String, dynamic>?) != null
                ? Organisation.fromJson(
                    json['dutyPostLocation'] as Map<String, dynamic>)
                : null,
        shiftA = json['shiftA'] as int?,
        shiftB = json['shiftB'] as int?,
        shiftC = json['shiftC'] as int?,
        shiftG = json['shiftG'] as int?,
        rankId = json['rankId'] as int?,
        total = json['total'] as int?,
        createdDate = json['createdDate'] as String?,
        createdBy = json['createdBy'] as String?,
        modifiedDate = json['modifiedDate'] as String?,
        modifiedBy = json['modifiedBy'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'location': location?.toJson(),
        'region': region?.toJson(),
        'dutyPostLocation': dutyPostLocation?.toJson(),
        'shiftA': shiftA,
        'shiftB': shiftB,
        'shiftC': shiftC,
        'shiftG': shiftG,
        'rankId': rankId,
        'total': total,
        'createdDate': createdDate,
        'createdBy': createdBy,
        'modifiedDate': modifiedDate,
        'modifiedBy': modifiedBy
      };
}
