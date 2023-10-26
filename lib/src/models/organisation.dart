class Organisation {
  int? id;
  String? name;
  bool? isSelected;

  Organisation({
    this.id,
    this.name,
    this.isSelected = false,
  });

  Organisation.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? json['Id'] as int?,
        name = json['name'] ?? json['Name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
