class Organisation {
  int? id;
  String? name;

  Organisation({
    this.id,
    this.name,
  });

  Organisation.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}