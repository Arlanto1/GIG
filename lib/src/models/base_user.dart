class BaseUser {
  String? email;
  int? id;
  String? name;
  String? description;

  BaseUser({
    this.email,
    this.id,
    this.name,
    this.description,
  });

  factory BaseUser.fromJson(Map<String, dynamic> json) => BaseUser(
        email: json["email"],
        id: json["id"],
        name: json["name"],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        'description': description,
        "id": id,
        "name": name,
      };

  @override
  String toString() {
    return 'BaseUser{email: $email, id: $id, name: $name}';
  }
}
