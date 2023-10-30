class BaseObject {
  String? lock;

  BaseObject({
    this.lock,
  });

  BaseObject.fromJson(Map<String, dynamic> json)
      : lock = json['lock'] as String?;

  Map<String, dynamic> toJson() => {'lock': lock};
}
