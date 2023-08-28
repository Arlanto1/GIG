class Entity {
  int? id;
  String? name;
  bool? isSelected;

  Entity({
    this.id,
    this.name,
    this.isSelected = false,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        id: json["Id"]??json["id"],
        name: json["Name"]??json["name"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
