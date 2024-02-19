import 'package:db_atom/index.dart';

class PhysicallyFitRequestModel {
  PhysicallyFitModel? gmPhysicallyFit;

  PhysicallyFitRequestModel({
    this.gmPhysicallyFit,
  });

  PhysicallyFitRequestModel.fromJson(Map<String, dynamic> json)
      : gmPhysicallyFit =
            (json['gmPhysicallyFit'] as Map<String, dynamic>?) != null
                ? PhysicallyFitModel.fromJson(
                    json['gmPhysicallyFit'] as Map<String, dynamic>)
                : null;

  Map<String, dynamic> toJson() =>
      {'gmPhysicallyFit': gmPhysicallyFit?.toJson()};
}
