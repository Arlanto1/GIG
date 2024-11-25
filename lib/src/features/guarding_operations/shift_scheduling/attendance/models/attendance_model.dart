import 'package:db_atom/index.dart';

part 'attendance_model.g.dart';

class AttendanceResponse {
  List<AttendanceModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  AttendanceResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  AttendanceResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)
            ?.map((dynamic e) =>
                AttendanceModel.fromJson(e as Map<String, dynamic>))
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
class AttendanceModel extends BaseObject {
  int? id;
  Organisation? location;
  Organisation? locationRegion;
  String? inputDate;
  String? slNo;
  Organisation? vendor;
  int? dutyType;
  int? status;
  int? attendanceType;
  String? entrySecurityName;
  bool isEligibleToEdit;
  String? modifiedBy;
  String? modifiedDate;
  Organisation? shiftInfo;

  AttendanceModel({
    this.id,
    this.location,
    this.locationRegion,
    this.inputDate,
    this.slNo,
    this.vendor,
    this.dutyType,
    this.status,
    this.attendanceType,
    this.entrySecurityName,
    this.isEligibleToEdit = false,
    this.modifiedBy,
    this.modifiedDate,
    this.shiftInfo
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AttendanceModelToJson(this);
}
