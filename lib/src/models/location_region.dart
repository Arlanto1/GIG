class LocationRegion {
  int? id;
  String? name;

  LocationRegion({
    this.id,
    this.name,
  });

  LocationRegion.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}