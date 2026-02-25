import 'package:db_atom/src/features/opsTeamSituationUpdate/model/opsTeamSitutationModel.dart';

class LsmLocUpdateModelRequest{
  LsmLocationUpdate? items;

  LsmLocUpdateModelRequest({
    this.items,
  });

  LsmLocUpdateModelRequest.fromJson(Map<String, dynamic> json)
      : items = (json['lsmLocationUpdate'] as Map<String, dynamic>?) != null
      ? LsmLocationUpdate.fromJson(
      json['lsmLocationUpdate'] as Map<String, dynamic>)
      : null;

  Map<String, dynamic> toJson() => {'lsmLocationUpdate': items?.toJson()};
}
