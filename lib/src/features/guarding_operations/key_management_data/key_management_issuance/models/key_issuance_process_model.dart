// import 'package:db_atom/src/models/organisation.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'key_issuance_process_model.g.dart';
//
// @JsonSerializable()
// class KeyIssuanceProcessRecord {
//   num? id;
//   num? svpId;
//   Organisation? violation;
//   double? penaltyAmount;
//   num? totalViolations;
//   num? staffCategory;
//   num? totalPenaltyAmount;
//
//   KeyIssuanceProcessRecord({
//     this.id,
//     this.svpId,
//     this.violation,
//     this.penaltyAmount,
//     this.totalViolations,
//     this.staffCategory,
//     this.totalPenaltyAmount,
//   });
//
//   factory KeyIssuanceProcessRecord.fromJson(Map<String, dynamic> json) =>
//       _$KeyIssuanceProcessRecordFromJson(json);
//
//   Map<String, dynamic> toJson() => _$KeyIssuanceProcessRecordToJson(this);
//
// }
import '../../../../../../index.dart';

class KeyIssuanceProcessRecord {
  final int? id;
  Organisation? keyDescription;
  final int? noKeysIssued;
  final int? available;
  final int? returned;
  final int? notReturned;
  final int? lost;
  final int? damaged;
  final int? keyType;
  final bool? lossReported;
  final bool? damageReported;

  KeyIssuanceProcessRecord({
    this.id,
    this.keyDescription,
    this.noKeysIssued,
    this.available,
    this.returned,
    this.notReturned,
    this.lost,
    this.damaged,
    this.keyType,
    this.lossReported,
    this.damageReported,
  });

  KeyIssuanceProcessRecord.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        keyDescription = json['keyDescription'] == null
            ? null
            : Organisation.fromJson(
                json['keyDescription'] as Map<String, dynamic>),
        noKeysIssued = json['noKeysIssued'] as int?,
        available = json['available'] as int?,
        returned = json['returned'] as int?,
        notReturned = json['notReturned'] as int?,
        lost = json['lost'] as int?,
        damaged = json['damaged'] as int?,
        keyType = json['keyType'] as int?,
        lossReported = json['lossReported'] as bool?,
        damageReported = json['damageReported'] as bool?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'keyDescription': keyDescription?.toJson(),
        'noKeysIssued': noKeysIssued,
        'available': available,
        'returned': returned,
        'notReturned': notReturned,
        'lost': lost,
        'damaged': damaged,
        'keyType': keyType,
        'lossReported': lossReported,
        'damageReported': damageReported
      };
}
