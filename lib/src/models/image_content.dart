class ImageContent {
  int? id;
  String? ownerName;
  String? contentType;
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
    this.imageContent,
  });

  factory ImageContent.fromJson(Map<String, dynamic> json) => ImageContent(
    id: json["id"],
    ownerName: json["ownerName"],
    contentType: json["contentType"],
    uploadDate: json["uploadDate"],
    foundId: json["foundId"],
    title: json["title"],
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
    "fileSize": fileSize,
    "imageContent": imageContent,
  };
}
