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
        id: json["Id"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
