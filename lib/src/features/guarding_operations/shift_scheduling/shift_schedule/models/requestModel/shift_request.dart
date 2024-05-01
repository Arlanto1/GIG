import 'package:db_atom/index.dart';

class ShiftRequest {
  final Shift? shifts;

  ShiftRequest({
    this.shifts,
  });

  ShiftRequest.fromJson(Map<String, dynamic> json)
      : shifts = (json['shifts'] as Map<String, dynamic>?) != null
            ? Shift.fromJson(json['shifts'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'shifts': shifts?.toJson()};
}
