import 'package:db_atom/index.dart';

class KeyIssuanceProcessRecord {
  int? id;
  Organisation? keyDescription;
  int? noKeysIssued;
  int? available;
  int? returned;
  int? notReturned;
  int? lost;
  int? damaged;
  int? keyType;
  bool? lossReported;
  bool? damageReported;

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
