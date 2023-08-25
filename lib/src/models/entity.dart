class Entity {
  int? id;
  String? name;

  Entity({
    this.id,
    this.name,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        id: json["Id"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
