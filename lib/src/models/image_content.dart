class ImageContent {
  int? id;
  String? ownerName;
  String? contentType;
  int? type;
  int? uploadDate;
  int? foundId;
  String? title;
  int? fileSize;
  String? imageContent;

  ImageContent({
    this.id,
    this.ownerName,
    this.contentType,
    this.uploadDate,
    this.foundId,
    this.title,
    this.fileSize,
    this.type,
    this.imageContent,
  });

  factory ImageContent.fromJson(Map<String, dynamic> json) => ImageContent(
        id: json["id"],
        ownerName: json["ownerName"],
        contentType: json["contentType"],
        uploadDate: json["uploadDate"],
        foundId: json["foundId"],
        title: json["title"],
        type: json["type"],
        fileSize: json["fileSize"],
        imageContent: json["imageContent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ownerName": ownerName,
        "contentType": contentType,
        "uploadDate": uploadDate,
        "foundId": foundId,
        "title": title,
        "type": type,
        "fileSize": fileSize,
        "imageContent": imageContent,
      };
}
