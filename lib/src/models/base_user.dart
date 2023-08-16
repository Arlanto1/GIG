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
    email: json["Email"],
    id: json["Id"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Email": email,
    "Id": id,
    "Name": name,
  };
}