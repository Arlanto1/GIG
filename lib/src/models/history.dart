class History {
  History({
    required this.id,
    required this.state,
    required this.action,
    required this.email,
    required this.actiontime,
    required this.parameters,
  });

  final int? id;
  final int? state;
  final int? action;
  final String? email;
  final int? actiontime;
  final String? parameters;

  factory History.fromJson(Map<String, dynamic> json){
    return History(
      id: json["id"],
      state: json["state"],
      action: json["action"],
      email: json["email"],
      actiontime: json["actiontime"],
      parameters: json["parameters"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "state": state,
    "action": action,
    "email": email,
    "actiontime": actiontime,
    "parameters": parameters,
  };

}