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

  DutyPostNameMasterModel(
      {this.id,
      this.slNo,
      this.location,
      this.locationRegion,
      this.inputDate,
      this.entrySecurity,
      this.modifiedDate,
      this.modifiedBy,
      this.status,
      this.dpName});

  factory DutyPostNameMasterModel.fromJson(Map<String, dynamic> json) =>
      _$DutyPostNameMasterModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DutyPostNameMasterModelToJson(this);
}

class DpName {
  int? id;
  String? dutyPostName;
  bool? transportShift;

  DpName({
    this.id,
    this.dutyPostName,
    this.transportShift,
  });

  DpName.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        dutyPostName = json['dutyPostName'] as String?,
        transportShift = json['transportShift'] as bool?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'dutyPostName': dutyPostName,
        'transportShift': transportShift
      };
}
