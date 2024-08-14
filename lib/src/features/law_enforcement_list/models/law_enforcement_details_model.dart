import 'package:db_atom/index.dart';

class LawEnforcementDetailsModel {
  int? id;
  String? slNo;
  String? inputDate;
  Organisation? location;
  Organisation? locationRegion;
  String? timeOfVisit;
  bool? officialCardVerified;
  Organisation? visitPurpose;
  bool? documentVerified;
  List<ImageContent>? images;
  List<Organisation>? entities;
  bool? visitorInUniform;
  String? dbOfficialEmail;
  Organisation? dbOfficialEmailDepartment;
  String? dbOfficialAccompaniedEmail;
  User? entrySecurity;
  String? additionalInformation;
  int? status;
  String? modifiedDate;
  String? modifiedBy;
  List<dynamic>? history;
  List<LawVisitingOfficial>? visitingOfficials;
  List<Organisation>? mailList;
  String? entityDesc;
  String? entrySecurityName;
  bool? isEligibleToEdit;
  bool? isEligibleToCancel;
  String? lock;

  LawEnforcementDetailsModel({
    this.id,
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.timeOfVisit,
    this.officialCardVerified,
    this.visitPurpose,
    this.documentVerified,
    this.images,
    this.entities,
    this.visitorInUniform,
    this.isEligibleToEdit,
    this.isEligibleToCancel,
    this.dbOfficialEmail,
    this.dbOfficialEmailDepartment,
    this.dbOfficialAccompaniedEmail,
    this.entrySecurity,
    this.additionalInformation,
    this.status,
    this.modifiedDate,
    this.modifiedBy,
    this.history,
    this.visitingOfficials,
    this.mailList,
    this.entityDesc,
    this.entrySecurityName,
    this.lock,
  });

  factory LawEnforcementDetailsModel.fromJson(Map<String, dynamic> json) =>
      LawEnforcementDetailsModel(
        lock: json['lock'],
        id: json["id"],
        slNo: json["slNo"],
        inputDate: json["inputDate"],
        isEligibleToCancel: json["isEligibleToCancel"],
        isEligibleToEdit: json["isEligibleToEdit"],
        location: json["location"] == null
            ? null
            : Organisation.fromJson(json["location"]),
        locationRegion: json["locationRegion"] == null
            ? null
            : Organisation.fromJson(json["locationRegion"]),
        timeOfVisit: json["timeOfVisit"],
        officialCardVerified: json["officialCardVerified"],
        visitPurpose: json["visitPurpose"] == null
            ? null
            : Organisation.fromJson(json["visitPurpose"]),
        documentVerified: json["documentVerified"],
        images: json["images"] == null
            ? []
            : List<ImageContent>.from(
                json["images"]!.map((x) => ImageContent.fromJson(x))),
        entities: json["entities"] == null
            ? []
            : List<Organisation>.from(
                json["entities"]!.map((x) => Organisation.fromJson(x))),
        visitorInUniform: json["visitorInUniform"],
        dbOfficialEmail: json["dbOfficialEmail"],
        dbOfficialEmailDepartment: json["dbOfficialEmailDepartment"] == null
            ? null
            : Organisation.fromJson(json["dbOfficialEmailDepartment"]),
        dbOfficialAccompaniedEmail: json["dbOfficialAccompaniedEmail"],
        entrySecurity: json["entrySecurity"] == null
            ? null
            : User.fromJson(json["entrySecurity"]),
        additionalInformation: json["additionalInformation"],
        status: json["status"],
        modifiedDate: json["modifiedDate"],
        modifiedBy: json["modifiedBy"],
        history: json["history"] == null
            ? []
            : List<dynamic>.from(json["history"]!.map((x) => x)),
        visitingOfficials: json["visitingOfficials"] == null
            ? []
            : List<LawVisitingOfficial>.from(json["visitingOfficials"]!
                .map((x) => LawVisitingOfficial.fromJson(x))),
        mailList: json["mailList"] == null
            ? []
            : List<Organisation>.from(
                json["mailList"]!.map((x) => Organisation.fromJson(x))),
        entityDesc: json["entityDesc"],
        entrySecurityName: json["entrySecurityName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lock": lock,
        "slNo": slNo,
        "inputDate": inputDate,
        "location": location?.toJson(),
        "locationRegion": locationRegion?.toJson(),
        "timeOfVisit": timeOfVisit,
        "officialCardVerified": officialCardVerified,
        'isEligibleToEdit': isEligibleToEdit,
        'isEligibleToCancel': isEligibleToCancel,
        "visitPurpose": visitPurpose?.toJson(),
        "documentVerified": documentVerified,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "entities": entities == null
            ? []
            : List<dynamic>.from(entities!.map((x) => x.toJson())),
        "visitorInUniform": visitorInUniform,
        "dbOfficialEmail": dbOfficialEmail,
        "dbOfficialEmailDepartment": dbOfficialEmailDepartment?.toJson(),
        "dbOfficialAccompaniedEmail": dbOfficialAccompaniedEmail,
        "entrySecurity": entrySecurity?.toJson(),
        "additionalInformation": additionalInformation,
        "status": status,
        "modifiedDate": modifiedDate,
        "modifiedBy": modifiedBy,
        "history":
            history == null ? [] : List<dynamic>.from(history!.map((x) => x)),
        "visitingOfficials": visitingOfficials == null
            ? []
            : List<dynamic>.from(visitingOfficials!.map((x) => x.toJson())),
        'mailList': mailList?.map((e) => e.toJson()).toList(),
        "entityDesc": entityDesc,
        "entrySecurityName": entrySecurityName,
      };
}

class LawVisitingOfficial {
  int? id;
  String? name;
  String? designation;
  Organisation? department;
  String? address;
  String? contactNo;
  String? email;
  bool? mandatory;

  LawVisitingOfficial({
    this.id,
    this.name,
    this.designation,
    this.department,
    this.address,
    this.contactNo,
    this.email,
    this.mandatory,
  });

  factory LawVisitingOfficial.fromJson(Map<String, dynamic> json) =>
      LawVisitingOfficial(
        id: json["id"],
        name: json["name"],
        designation: json["designation"],
        department: json["department"] == null
            ? null
            : Organisation.fromJson(json["department"]),
        address: json["address"],
        contactNo: json["contactNo"],
        email: json["email"],
        mandatory: json["mandatory"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "designation": designation,
        "department": department?.toJson(),
        "address": address,
        "contactNo": contactNo,
        "email": email,
        "mandatory": mandatory,
      };
}
