class BaseUser {
  String? email;
  int? id;
  String? name;

  BaseUser({
    this.email,
    this.id,
    this.name,
  });

  factory BaseUser.fromJson(Map<String, dynamic> json) => BaseUser(
        email: json["email"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
        "name": name,
      };
}
