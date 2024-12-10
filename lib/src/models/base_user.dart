class BaseUser {
  String? email;
  int? id;
  String? name;
  String? description;
  String? employeeId;

  BaseUser({this.email, this.id, this.name, this.description, this.employeeId});

  factory BaseUser.fromJson(Map<String, dynamic> json) => BaseUser(
        email: json["email"],
        id: json["id"],
        name: json["name"],
        description: json['description'],
        employeeId: json["employeeId"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        'description': description,
        "id": id,
        "name": name,
        "employeeId": employeeId,
      };

  @override
  String toString() {
    return 'BaseUser{email: $email, id: $id, name: $name, employeeId: $employeeId';
  }
}
