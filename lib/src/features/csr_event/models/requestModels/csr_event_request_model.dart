import '../csr_event_model.dart';

class CSRGeneralInfoRequest {
  CSRGeneralInfoRequest({
    required this.csrEventGi,
  });

  late final CSREventGiModel csrEventGi;

  CSRGeneralInfoRequest.fromJson(Map<String, dynamic> json) {
    csrEventGi = CSREventGiModel.fromJson(json['epGi']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['epGi'] = csrEventGi.toJson();
    return data;
  }
}
