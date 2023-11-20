class AttachmentModel {
  String? fullpath;
  String? name;

  AttachmentModel({
    this.fullpath,
    this.name,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      AttachmentModel(
        fullpath: json["fullpath"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "fullpath": fullpath,
        "name": name,
      };
}
