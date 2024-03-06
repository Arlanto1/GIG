import 'package:db_atom/index.dart';

part 'foundlist_article_details.g.dart';

@JsonSerializable()
class FoundListArticleDetails {
  factory FoundListArticleDetails.fromJson(Map<String, dynamic> json) =>
      _$FoundListArticleDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$FoundListArticleDetailsToJson(this);

  int? id;
  String? slNo;
  int? eventProtection;
  String? inputDate;
  Organisation? locationRegion;
  int? typeOfAsset;
  Organisation? typeOfArticle;
  String? foundDate;
  String? foundLocation;
  String? additionalInformation;
  int? quantity;
  String? color;
  List<ImageContent>? images;
  bool? depositorDbEmp;
  User? depositor;
  String? employeeId;
  Organisation? depositorDepartment;
  bool? claimantDbEmp;
  bool? claimantConfirmByEmail;
  User? claimant;
  bool? claimantNoSign;
  ImageContent? claimantSign;
  String? claimantEmployeeId;
  Organisation? claimantDepartment;
  String? handoverDate;
  User? entrySecurity;
  User? handoverSecurity;
  int? status;
  String? modifiedDate;
  String? modifiedBy;
  String? depositorName;
  String? claimantName;
  String? locationName;
  String? entrySecurityName;
  String? handOverSecurityName;
  String? depositorDepartmentName;
  String? claimantDepartmentName;
  Organisation? location;

  FoundListArticleDetails({
    this.id,
    this.slNo,
    this.inputDate,
    this.locationRegion,
    this.typeOfAsset,
    this.typeOfArticle,
    this.foundDate,
    this.foundLocation,
    this.additionalInformation,
    this.quantity,
    this.color,
    this.claimantSign,
    this.images,
    this.depositorDbEmp,
    this.depositor,
    this.employeeId,
    this.depositorDepartment,
    this.claimantDbEmp,
    this.claimantConfirmByEmail,
    this.claimant,
    this.claimantNoSign,
    this.claimantEmployeeId,
    this.claimantDepartment,
    this.handoverDate,
    this.entrySecurity,
    this.handoverSecurity,
    this.status,
    this.modifiedDate,
    this.modifiedBy,
    this.depositorName,
    this.claimantName,
    this.locationName,
    this.entrySecurityName,
    this.handOverSecurityName,
    this.depositorDepartmentName,
    this.claimantDepartmentName,
    this.location,
  });
//
// factory FoundListArticleDetails.fromJson(Map<String, dynamic> json) => FoundListArticleDetails(
//     id: json["id"],
//     slNo: json["slNo"],
//     inputDate: json["inputDate"],
//     locationRegion: json["locationRegion"] == null ? null : Organisation.fromJson(json["locationRegion"]),
//     typeOfAsset: json["typeOfAsset"],
//     typeOfArticle: json["typeOfArticle"] == null ? null : Organisation.fromJson(json["typeOfArticle"]),
//     foundDate: json["foundDate"],
//     foundLocation: json["foundLocation"],
//     additionalInformation: json["additionalInformation"],
//     quantity: json["quantity"],
//     color: json["color"],
//    images :List<ImageContent>.from(json["images"]!.map((x) => ImageContent.fromJson(x))),
//     depositorDbEmp: json["depositorDbEmp"],
//     depositor: json["depositor"] == null ? null : User.fromJson(json["depositor"]),
//     employeeId: json["employeeId"],
//     depositorDepartment: json["depositorDepartment"] == null ? null : Organisation.fromJson(json["depositorDepartment"]),
//     claimantDbEmp: json["claimantDbEmp"],
//     claimantConfirmByEmail: json["claimantConfirmByEmail"],
//     claimant: json["claimant"] == null ? null : User.fromJson(json["claimant"]),
//     claimantNoSign: json["claimantNoSign"],
//     claimantEmployeeId: json["claimantEmployeeId"],
//     claimantDepartment: json["claimantDepartment"] == null ? null : Organisation.fromJson(json["claimantDepartment"]),
//     handoverDate: json["handoverDate"],
//     entrySecurity: json["entrySecurity"] == null ? null : User.fromJson(json["entrySecurity"]),
//     handoverSecurity: json["handoverSecurity"] == null ? null : User.fromJson(json["handoverSecurity"]),
//     status: json["status"],
//     modifiedDate: json["modifiedDate"],
//     modifiedBy: json["modifiedBy"],
//     depositorName: json["depositorName"],
//     claimantName: json["claimantName"],
//     locationName: json["locationName"],
//     entrySecurityName: json["entrySecurityName"],
//     handOverSecurityName: json["handOverSecurityName"],
//     depositorDepartmentName: json["depositorDepartmentName"],
//     claimantDepartmentName: json["claimantDepartmentName"],
//     location: json["location"] == null ? null : Organisation.fromJson(json["location"]),
// );
//
// Map<String, dynamic> toJson() => {
//     "id": id,
//     "slNo": slNo,
//     "inputDate": inputDate,
//     "locationRegion": locationRegion?.toJson(),
//     "typeOfAsset": typeOfAsset,
//     "typeOfArticle": typeOfArticle?.toJson(),
//     "foundDate": foundDate,
//     "foundLocation": foundLocation,
//     "additionalInformation": additionalInformation,
//     "quantity": quantity,
//     "color": color,
//      "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
//     "depositorDbEmp": depositorDbEmp,
//     "depositor": depositor?.toJson(),
//     "employeeId": employeeId,
//     "depositorDepartment": depositorDepartment?.toJson(),
//     "claimantDbEmp": claimantDbEmp,
//     "claimantConfirmByEmail": claimantConfirmByEmail,
//     "claimant": claimant?.toJson(),
//     "claimantNoSign": claimantNoSign,
//     "claimantEmployeeId": claimantEmployeeId,
//     "claimantDepartment": claimantDepartment?.toJson(),
//     "handoverDate": handoverDate,
//     "entrySecurity": entrySecurity?.toJson(),
//     "handoverSecurity": handoverSecurity?.toJson(),
//     "status": status,
//     "modifiedDate": modifiedDate,
//     "modifiedBy": modifiedBy,
//     "depositorName": depositorName,
//     "claimantName": claimantName,
//     "locationName": locationName,
//     "entrySecurityName": entrySecurityName,
//     "handOverSecurityName": handOverSecurityName,
//     "depositorDepartmentName": depositorDepartmentName,
//     "claimantDepartmentName": claimantDepartmentName,
//     "location": location?.toJson(),
// };
}

enum Area { SOURCE_SYSTEM, CATEGORY }

final areaValues = EnumValues({
  "Category": Area.CATEGORY,
  "SourceSystem": Area.SOURCE_SYSTEM,
});

enum Filter { DB_ATOM, DEFAULT }

final filterValues =
    EnumValues({"DB_ATOM": Filter.DB_ATOM, "Default": Filter.DEFAULT});

enum Application { TRACKING1, DB_ATOM }

final applicationValues = EnumValues(
    {"DB_ATOM": Application.DB_ATOM, "Tracking1": Application.TRACKING1});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
