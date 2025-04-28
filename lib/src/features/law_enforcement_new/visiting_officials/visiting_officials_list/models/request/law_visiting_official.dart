import 'package:db_atom/index.dart';

class LawVisitingOfficialRequest {
  LawVisitingOfficial? visitingOfficials;

  LawVisitingOfficialRequest({
    this.visitingOfficials,
  });

  LawVisitingOfficialRequest.fromJson(Map<String, dynamic> json)
      : visitingOfficials =
            (json['visitingOfficials'] as Map<String, dynamic>?) != null
                ? LawVisitingOfficial.fromJson(
                    json['visitingOfficials'] as Map<String, dynamic>)
                : null;

  Map<String, dynamic> toJson() =>
      {'visitingOfficials': visitingOfficials?.toJson()};
}
