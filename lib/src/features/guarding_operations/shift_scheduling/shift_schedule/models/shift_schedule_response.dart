import 'package:db_atom/index.dart';

part 'shift_schedule_response.g.dart';

class ShiftScheduleResponse {
  List<ShiftScheduleModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  ShiftScheduleResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  ShiftScheduleResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) =>
                ShiftScheduleModel.fromJson(e as Map<String, dynamic>))
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
class ShiftScheduleModel extends BaseObject {
  int? id;
  User? entrySecurity;
  Organisation? location;
  Organisation? locationRegion;
  String? inputDate;
  String? slNo;
  Organisation? vendor;
  int? dutyType;
  int? status;
  String? fromDate;
  String? toDate;
  String? modifiedBy;
  String? modifiedDate;

  factory ShiftScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftScheduleModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShiftScheduleModelToJson(this);

  ShiftScheduleModel({
    this.id,
    this.entrySecurity,
    this.location,
    this.locationRegion,
    this.inputDate,
    this.slNo,
    this.vendor,
    this.dutyType,
    this.status,
    this.fromDate,
    this.toDate,
    this.modifiedBy,
    this.modifiedDate,
  });
}
