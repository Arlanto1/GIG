import 'package:db_atom/src/features/law_enforcement_new/models/law_enforcement_model_new.dart';

class LawEnforcementRequestNew {
  LawEnforcementRequestNew({
    required this.lawEnforcementModelNew,
  });

  late final LawEnforcementModelNew lawEnforcementModelNew;

  LawEnforcementRequestNew.fromJson(Map<String, dynamic> json) {
    lawEnforcementModelNew = LawEnforcementModelNew.fromJson(json['lawEnforcementModelNew']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lawEnforcementModelNew'] = lawEnforcementModelNew.toJson();
    return data;
  }
}
