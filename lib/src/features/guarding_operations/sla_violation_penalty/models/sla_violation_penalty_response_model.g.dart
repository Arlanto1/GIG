// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sla_violation_penalty_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SLAViolationPenaltyModel _$SLAViolationPenaltyModelFromJson(
        Map<String, dynamic> json) =>
    SLAViolationPenaltyModel(
      id: (json['id'] as num?)?.toInt(),
      slNo: json['slNo'] as String?,
      location: json['location'] == null
          ? null
          : Organisation.fromJson(json['location'] as Map<String, dynamic>),
      locationRegion: json['locationRegion'] == null
          ? null
          : Organisation.fromJson(
              json['locationRegion'] as Map<String, dynamic>),
      inputDate: json['inputDate'] as String?,
      entrySecurity: json['entrySecurity'] == null
          ? null
          : User.fromJson(json['entrySecurity'] as Map<String, dynamic>),
      status: (json['status'] as num?)?.toInt(),
      entity: (json['entity'] as List<dynamic>?)
          ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      dutyPostLocation: json['dutyPostLocation'] == null
          ? null
          : Organisation.fromJson(
              json['dutyPostLocation'] as Map<String, dynamic>),
      vendor: (json['vendor'] as List<dynamic>?)
          ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      poc: json['poc'] as String?,
      typeOfService: (json['typeOfService'] as List<dynamic>?)
          ?.map((e) => Organisation.fromJson(e as Map<String, dynamic>))
          .toList(),
      approver: json['approver'] == null
          ? null
          : User.fromJson(json['approver'] as Map<String, dynamic>),
      attdShiftInfoId: (json['attdShiftInfoId'] as num?)?.toInt(),
      attendanceId: (json['attendanceId'] as num?)?.toInt(),
      entitiesInfo: json['entitiesInfo'] as String?,
      vendorInfo: json['vendorInfo'] as String?,
      typeOfServiceInfo: json['typeOfServiceInfo'] as String?,
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$SLAViolationPenaltyModelToJson(
    SLAViolationPenaltyModel instance) {
  final val = <String, dynamic>{
    'lock': instance.lock,
    'id': instance.id,
    'slNo': instance.slNo,
    'location': instance.location,
    'locationRegion': instance.locationRegion,
    'inputDate': instance.inputDate,
    'entrySecurity': instance.entrySecurity,
    'status': instance.status,
    'vendor': instance.vendor,
    'typeOfService': instance.typeOfService,
    'entity': instance.entity,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dutyPostLocation', instance.dutyPostLocation);
  val['approver'] = instance.approver;
  val['poc'] = instance.poc;
  val['attdShiftInfoId'] = instance.attdShiftInfoId;
  val['attendanceId'] = instance.attendanceId;
  val['entitiesInfo'] = instance.entitiesInfo;
  val['vendorInfo'] = instance.vendorInfo;
  val['typeOfServiceInfo'] = instance.typeOfServiceInfo;
  return val;
}
