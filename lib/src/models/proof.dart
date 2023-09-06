class Proof {
  final LocalAddressProof? localAddressProof;

  Proof({
    this.localAddressProof,
  });

  Proof.fromJson(Map<String, dynamic> json)
      : localAddressProof = (json['localAddressProof'] as Map<String,dynamic>?) != null ? LocalAddressProof.fromJson(json['localAddressProof'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'localAddressProof' : localAddressProof?.toJson()
  };
}

class LocalAddressProof {
  final int? id;
  final String? ownerName;
  final String? contentType;
  final int? uploadDate;
  final int? guardingMasterId;
  final int? type;
  final String? title;
  final bool? deletable;
  final int? fileSize;
  final String? imageContent;

  LocalAddressProof({
    this.id,
    this.ownerName,
    this.contentType,
    this.uploadDate,
    this.guardingMasterId,
    this.type,
    this.title,
    this.deletable,
    this.fileSize,
    this.imageContent,
  });

  LocalAddressProof.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        ownerName = json['ownerName'] as String?,
        contentType = json['contentType'] as String?,
        uploadDate = json['uploadDate'] as int?,
        guardingMasterId = json['guardingMasterId'] as int?,
        type = json['type'] as int?,
        title = json['title'] as String?,
        deletable = json['deletable'] as bool?,
        fileSize = json['fileSize'] as int?,
        imageContent = json['imageContent'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'ownerName' : ownerName,
    'contentType' : contentType,
    'uploadDate' : uploadDate,
    'guardingMasterId' : guardingMasterId,
    'type' : type,
    'title' : title,
    'deletable' : deletable,
    'fileSize' : fileSize,
    'imageContent' : imageContent
  };
}