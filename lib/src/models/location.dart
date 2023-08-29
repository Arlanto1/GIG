class Location {
  int? id;
  String? name;

  Location({
    this.id,
    this.name,
  });

  Location.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}