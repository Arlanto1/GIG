// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vvip_visitor_records_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VVIPVisitorsRecordListModel _$VVIPVisitorsRecordListModelFromJson(
        Map<String, dynamic> json) =>
    VVIPVisitorsRecordListModel(
      vvipVisitorsRecord: (json['vvipVisitorsRecord'] as List<dynamic>?)
          ?.map((e) => VIVPVisitorRecords.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..lock = json['lock'] as String?;

Map<String, dynamic> _$VVIPVisitorsRecordListModelToJson(
        VVIPVisitorsRecordListModel instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'vvipVisitorsRecord': instance.vvipVisitorsRecord,
    };
