class TrainingItemsResponseModel {
  List<TrainingItemsModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  TrainingItemsResponseModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  TrainingItemsResponseModel.fromJson(Map<String, dynamic> json)
      : items = (json['list'] as List?)
      ?.map((dynamic e) =>
      TrainingItemsModel.fromJson(e as Map<String, dynamic>))
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

class TrainingItemsModel {
  int? id;
  String? title;
  String description;
  String audienceType;
  String entity;
  String location;
  int entityOrganisationId;
  List<int> locationRegionIds;
  List<int> locationIds;
  dynamic entityOrganisation;
  dynamic locationOrganisation;
  dynamic locationRegion;
  List<dynamic> locationRegions;
  List<dynamic> locations;
  String trainerName;
  String trainerEmail;
  String trainerLocation;
  int trainerLocationId;
  dynamic trainerLocationOrganisation;
  int sessionNumber;
  int sessionGroupId;
  String scheduledDate;
  String startDate;
  String endDate;
  String status;
  String periodicity;
  int registeredCount;
  int attendeeCount;
  String trainingMaterial;
  String trainingMaterialContentType;
  String trainingMaterialContent;
  String assessmentLink;
  String creatorName;
  String creationDate;
  String modificatorName;
  String modificationDate;

  TrainingItemsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.audienceType,
    required this.entity,
    required this.location,
    required this.entityOrganisationId,
    required this.locationRegionIds,
    required this.locationIds,
    required this.entityOrganisation,
    required this.locationOrganisation,
    required this.locationRegion,
    required this.locationRegions,
    required this.locations,
    required this.trainerName,
    required this.trainerEmail,
    required this.trainerLocation,
    required this.trainerLocationId,
    required this.trainerLocationOrganisation,
    required this.sessionNumber,
    required this.sessionGroupId,
    required this.scheduledDate,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.periodicity,
    required this.registeredCount,
    required this.attendeeCount,
    required this.trainingMaterial,
    required this.trainingMaterialContentType,
    required this.trainingMaterialContent,
    required this.assessmentLink,
    required this.creatorName,
    required this.creationDate,
    required this.modificatorName,
    required this.modificationDate,
  });

  TrainingItemsModel.fromJson(Map<String, dynamic> json)
      :   id= json["id"] as int?,
  title= json["title"],
  description= json["description"],
  audienceType= json["audienceType"],
  entity= json["entity"],
  location= json["location"],
  entityOrganisationId= json["entityOrganisationId"],
  locationRegionIds= List<int>.from(json["locationRegionIds"].map((x) => x)),
  locationIds= List<int>.from(json["locationIds"].map((x) => x)),
  entityOrganisation= json["entityOrganisation"],
  locationOrganisation= json["locationOrganisation"],
  locationRegion= json["locationRegion"],
  locationRegions= List<dynamic>.from(json["locationRegions"].map((x) => x)),
  locations= List<dynamic>.from(json["locations"].map((x) => x)),
  trainerName= json["trainerName"],
  trainerEmail= json["trainerEmail"],
  trainerLocation= json["trainerLocation"],
  trainerLocationId= json["trainerLocationId"],
  trainerLocationOrganisation= json["trainerLocationOrganisation"],
  sessionNumber= json["sessionNumber"],
  sessionGroupId= json["sessionGroupId"],
  scheduledDate= json["scheduledDate"],
  startDate= json["startDate"],
  endDate= json["endDate"],
  status= json["status"],
  periodicity= json["periodicity"],
  registeredCount= json["registeredCount"],
  attendeeCount= json["attendeeCount"],
  trainingMaterial= json["trainingMaterial"],
  trainingMaterialContentType= json["trainingMaterialContentType"],
  trainingMaterialContent= json["trainingMaterialContent"],
  assessmentLink= json["assessmentLink"],
  creatorName= json["creatorName"],
  creationDate= json["creationDate"],
  modificatorName= json["modificatorName"],
  modificationDate= json["modificationDate"];

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "audienceType": audienceType,
    "entity": entity,
    "location": location,
    "entityOrganisationId": entityOrganisationId,
    "locationRegionIds": List<dynamic>.from(locationRegionIds.map((x) => x)),
    "locationIds": List<dynamic>.from(locationIds.map((x) => x)),
    "entityOrganisation": entityOrganisation,
    "locationOrganisation": locationOrganisation,
    "locationRegion": locationRegion,
    "locationRegions": List<dynamic>.from(locationRegions.map((x) => x)),
    "locations": List<dynamic>.from(locations.map((x) => x)),
    "trainerName": trainerName,
    "trainerEmail": trainerEmail,
    "trainerLocation": trainerLocation,
    "trainerLocationId": trainerLocationId,
    "trainerLocationOrganisation": trainerLocationOrganisation,
    "sessionNumber": sessionNumber,
    "sessionGroupId": sessionGroupId,
    "scheduledDate": scheduledDate,
    "startDate": startDate,
    "endDate": endDate,
    "status": status,
    "periodicity": periodicity,
    "registeredCount": registeredCount,
    "attendeeCount": attendeeCount,
    "trainingMaterial": trainingMaterial,
    "trainingMaterialContentType": trainingMaterialContentType,
    "trainingMaterialContent": trainingMaterialContent,
    "assessmentLink": assessmentLink,
    "creatorName": creatorName,
    "creationDate": creationDate,
    "modificatorName": modificatorName,
    "modificationDate": modificationDate,
  };
}




