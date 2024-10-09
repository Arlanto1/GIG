import 'package:db_atom/src/features/ticketing_system/models/ticketing_system_model.dart';

class TicketingSystemRequest {
  TicketingSystemRequest({
    required this.ticketingSystemModel,
  });

  late final TicketingSystemModel ticketingSystemModel;

  TicketingSystemRequest.fromJson(Map<String, dynamic> json) {
    ticketingSystemModel =
        TicketingSystemModel.fromJson(json['ticketingSystemModel']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ticketingSystemModel'] = ticketingSystemModel.toJson();
    return data;
  }
}
