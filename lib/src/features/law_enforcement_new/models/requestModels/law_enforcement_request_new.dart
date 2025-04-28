import 'package:db_atom/src/features/law_enforcement_new/models/law_enforcement_model_new.dart';

class LawEnforcementRequestBodyNew {
  LawEnforcementRequestBodyNew({
    required this.lawEnforcementModel,
  });

  late final LawEnforcementModelNew lawEnforcementModel;

  LawEnforcementRequestBodyNew.fromJson(Map<String, dynamic> json) {
    lawEnforcementModel = LawEnforcementModelNew.fromJson(json['lawEnforcement']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lawEnforcement'] = lawEnforcementModel.toJson();
    return data;
  }
}
