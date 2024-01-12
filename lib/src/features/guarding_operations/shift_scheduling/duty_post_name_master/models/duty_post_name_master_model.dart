import 'package:db_atom/index.dart';

part 'duty_post_name_master_model.g.dart';

class DutyPostNameMasterResponse {
  List<DutyPostNameMasterModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  DutyPostNameMasterResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  DutyPostNameMasterResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) =>
                DutyPostNameMasterModel.fromJson(e as Map<String, dynamic>))
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
class DutyPostNameMasterModel extends BaseObject {
  int? id;
  String? slNo;
  Organisation? location;
  Organisation? locationRegion;
  String? inputDate;
  User? entrySecurity;
  String? modifiedDate;
  String? modifiedBy;
  int? status;
  List<DpName>? dpName;

  DutyPostNameMasterModel({
    this.id,
    this.slNo,
    this.location,
    this.locationRegion,
    this.inputDate,
    this.entrySecurity,
    this.modifiedDate,
    this.modifiedBy,
    this.status,
    this.dpName,
  });

  DutyPostNameMasterModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        locationRegion =
            (json['locationRegion'] as Map<String, dynamic>?) != null
                ? Organisation.fromJson(
                    json['locationRegion'] as Map<String, dynamic>)
                : null,
        inputDate = json['inputDate'] as String?,
        entrySecurity = (json['entrySecurity'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['entrySecurity'] as Map<String, dynamic>)
            : null,
        modifiedDate = json['modifiedDate'] as String?,
        modifiedBy = json['modifiedBy'] as String?,
        status = json['status'] as int?,
        dpName = (json['dpName'] as List?)
            ?.map((dynamic e) => DpName.fromJson(e as Map<String, dynamic>))
            .toList();

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'slNo': slNo,
        'location': location?.toJson(),
        'locationRegion': locationRegion?.toJson(),
        'inputDate': inputDate,
        'entrySecurity': entrySecurity?.toJson(),
        'modifiedDate': modifiedDate,
        'modifiedBy': modifiedBy,
        'status': status,
        'dpName': dpName?.map((e) => e.toJson()).toList(),
        'lock': lock
      };
}

class DpName {
  int? id;
  String? dutyPostName;
  Organisation? location;

  DpName({
    this.id,
    this.dutyPostName,
    this.location,
  });

  DpName.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        dutyPostName = json['dutyPostName'] as String?,
        location = (json['location'] as Map<String, dynamic>?) != null
            ? Organisation.fromJson(json['location'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'id': id, 'dutyPostName': dutyPostName, 'location': location?.toJson()};
}
