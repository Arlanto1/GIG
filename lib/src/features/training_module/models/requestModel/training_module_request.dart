class TrainingModuleResponseModel {
  List<TrainingModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  TrainingModuleResponseModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  TrainingModuleResponseModel.fromJson(Map<String, dynamic> json)
      : items = (json['list'] as List?)
      ?.map((dynamic e) =>
      TrainingModel.fromJson(e as Map<String, dynamic>))
      .toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
    'list': items?.map((e) => e.toJson()).toList(),
    'totalCount': totalCount,
    'currentPageNo': currentPageNo,
    'totalPageCount': totalPageCount
  };
}

class TrainingModel {
  int? id;
  String? title;
  String? description;
  String? trainingType;
  String? trainingYear;
  String? status;
  String? creatorName;
  String? creatorEmail;
  String? ownerName;
  String? creationDate;
  String? modificatorName;
  String? modificationDate;
  String? startDate;
  String? endDate;

  TrainingModel({
    this.id,
    this.title,
    this.description,
    this.trainingType,
    this.trainingYear,
    this.status,
    this.creatorName,
    this.creatorEmail,
    this.ownerName,
    this.creationDate,
    this.modificatorName,
    this.modificationDate,
    this.startDate,
    this.endDate,
  });

  TrainingModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        trainingType = json['trainingType'] as String?,
        trainingYear = json['trainingYear'] as String?,
        status = json['status'] as String?,
        creatorName = json['creatorName'] as String?,
        creatorEmail = json['creatorEmail'] as String?,
        ownerName = json['ownerName'] as String?,
        creationDate = json['creationDate'] as String?,
        modificatorName = json['modificatorName'] as String?,
        modificationDate = json['modificationDate'] as String?,
        startDate = json['startDate'] as String?,
        endDate = json['endDate'] as String?;

      Map<String, dynamic> toJson() => {
    'id' : id,
    'title' : title,
    'description' : description,
    'trainingType' : trainingType,
    'trainingYear' : trainingYear,
    'status' : status,
    'creatorName' : creatorName,
    'creatorEmail' : creatorEmail,
    'ownerName' : ownerName,
    'creationDate' : creationDate,
    'modificatorName' : modificatorName,
    'modificationDate':modificationDate,
    'startDate' : startDate,
    'endDate' : endDate,
  };
}




