import 'package:db_atom/index.dart';

class VisitingOfficialsRequest {
  VisitingOfficialsModel? visitingOfficials;

  VisitingOfficialsRequest({
    this.visitingOfficials,
  });

  VisitingOfficialsRequest.fromJson(Map<String, dynamic> json)
      : visitingOfficials =
  (json['visitingOfficials'] as Map<String, dynamic>?) != null
      ? VisitingOfficialsModel.fromJson(
      json['visitingOfficials'] as Map<String, dynamic>)
      : null;

  Map<String, dynamic> toJson() =>
      {'visitingOfficials': visitingOfficials?.toJson()};
}
