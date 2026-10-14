import 'package:db_atom/src/features/parking/models/parking_model.dart';

class ParkingRequestModel {
  ParkingRequestModel({
    required this.parkingModel,
  });

  late final ParkingModel parkingModel;

  ParkingRequestModel.fromJson(Map<String, dynamic> json) {
    parkingModel = ParkingModel.fromJson(json['parking']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['parking'] = parkingModel.toJson();
    return data;
  }
}
