import 'dart:convert';

import '../../../../models/role.dart';
import '../../../../models/role_extension.dart';

FoundListArticleDetails foundListArticleDetailsFromJson(String str) => FoundListArticleDetails.fromJson(json.decode(str));

String foundListArticleDetailsToJson(FoundListArticleDetails data) => json.encode(data.toJson());

class FoundListArticleDetails {
    int? id;
    String? slNo;
    String? inputDate;
    ClaimantDepartment? locationRegion;
    int? typeOfAsset;
    ClaimantDepartment? typeOfArticle;
    String? foundDate;
    String? foundLocation;
    String? additionalInformation;
    int? quantity;
    String? color;
    List<FoundImage>? images;
    bool? depositorDbEmp;
    Claimant? depositor;
    String? employeeId;
    ClaimantDepartment? depositorDepartment;
    bool? claimantDbEmp;
    bool? claimantConfirmByEmail;
    Claimant? claimant;
    bool? claimantNoSign;
    String? claimantEmployeeId;
    ClaimantDepartment? claimantDepartment;
    String? handoverDate;
    Claimant? entrySecurity;
    Claimant? handoverSecurity;
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
    ClaimantDepartment? location;

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

    factory FoundListArticleDetails.fromJson(Map<String, dynamic> json) => FoundListArticleDetails(
        id: json["id"],
        slNo: json["slNo"],
        inputDate: json["inputDate"],
        locationRegion: json["locationRegion"] == null ? null : ClaimantDepartment.fromJson(json["locationRegion"]),
        typeOfAsset: json["typeOfAsset"],
        typeOfArticle: json["typeOfArticle"] == null ? null : ClaimantDepartment.fromJson(json["typeOfArticle"]),
        foundDate: json["foundDate"],
        foundLocation: json["foundLocation"],
        additionalInformation: json["additionalInformation"],
        quantity: json["quantity"],
        color: json["color"],
       images :List<FoundImage>.from(json["images"]!.map((x) => FoundImage.fromJson(x))),
        depositorDbEmp: json["depositorDbEmp"],
        depositor: json["depositor"] == null ? null : Claimant.fromJson(json["depositor"]),
        employeeId: json["employeeId"],
        depositorDepartment: json["depositorDepartment"] == null ? null : ClaimantDepartment.fromJson(json["depositorDepartment"]),
        claimantDbEmp: json["claimantDbEmp"],
        claimantConfirmByEmail: json["claimantConfirmByEmail"],
        claimant: json["claimant"] == null ? null : Claimant.fromJson(json["claimant"]),
        claimantNoSign: json["claimantNoSign"],
        claimantEmployeeId: json["claimantEmployeeId"],
        claimantDepartment: json["claimantDepartment"] == null ? null : ClaimantDepartment.fromJson(json["claimantDepartment"]),
        handoverDate: json["handoverDate"],
        entrySecurity: json["entrySecurity"] == null ? null : Claimant.fromJson(json["entrySecurity"]),
        handoverSecurity: json["handoverSecurity"] == null ? null : Claimant.fromJson(json["handoverSecurity"]),
        status: json["status"],
        modifiedDate: json["modifiedDate"],
        modifiedBy: json["modifiedBy"],
        depositorName: json["depositorName"],
        claimantName: json["claimantName"],
        locationName: json["locationName"],
        entrySecurityName: json["entrySecurityName"],
        handOverSecurityName: json["handOverSecurityName"],
        depositorDepartmentName: json["depositorDepartmentName"],
        claimantDepartmentName: json["claimantDepartmentName"],
        location: json["location"] == null ? null : ClaimantDepartment.fromJson(json["location"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "slNo": slNo,
        "inputDate": inputDate,
        "locationRegion": locationRegion?.toJson(),
        "typeOfAsset": typeOfAsset,
        "typeOfArticle": typeOfArticle?.toJson(),
        "foundDate": foundDate,
        "foundLocation": foundLocation,
        "additionalInformation": additionalInformation,
        "quantity": quantity,
        "color": color,
         "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
        "depositorDbEmp": depositorDbEmp,
        "depositor": depositor?.toJson(),
        "employeeId": employeeId,
        "depositorDepartment": depositorDepartment?.toJson(),
        "claimantDbEmp": claimantDbEmp,
        "claimantConfirmByEmail": claimantConfirmByEmail,
        "claimant": claimant?.toJson(),
        "claimantNoSign": claimantNoSign,
        "claimantEmployeeId": claimantEmployeeId,
        "claimantDepartment": claimantDepartment?.toJson(),
        "handoverDate": handoverDate,
        "entrySecurity": entrySecurity?.toJson(),
        "handoverSecurity": handoverSecurity?.toJson(),
        "status": status,
        "modifiedDate": modifiedDate,
        "modifiedBy": modifiedBy,
        "depositorName": depositorName,
        "claimantName": claimantName,
        "locationName": locationName,
        "entrySecurityName": entrySecurityName,
        "handOverSecurityName": handOverSecurityName,
        "depositorDepartmentName": depositorDepartmentName,
        "claimantDepartmentName": claimantDepartmentName,
        "location": location?.toJson(),
    };
}

class Claimant {
    int? userId;
    String? userName;
    String? email;
    String? firstName;
    String? lastName;
    String? phone;
    List<Role>? roles;
    List<RoleExtension>? roleExtensions;
    List<dynamic>? notApprovedRoles;
    List<dynamic>? notApprovedRoleExtensions;
    String? name;
    String? userStatus;

    Claimant({
        this.userId,
        this.userName,
        this.email,
        this.firstName,
        this.lastName,
        this.phone,
        this.roles,
        this.roleExtensions,
        this.notApprovedRoles,
        this.notApprovedRoleExtensions,
        this.name,
        this.userStatus,
    });

    factory Claimant.fromJson(Map<String, dynamic> json) => Claimant(
        userId: json["userId"],
        userName: json["userName"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
        roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
        notApprovedRoles: json["notApprovedRoles"] == null ? [] : List<dynamic>.from(json["notApprovedRoles"]!.map((x) => x)),
        notApprovedRoleExtensions: json["notApprovedRoleExtensions"] == null ? [] : List<dynamic>.from(json["notApprovedRoleExtensions"]!.map((x) => x)),
        name: json["name"],
        userStatus: json["userStatus"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
        "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
        "notApprovedRoles": notApprovedRoles == null ? [] : List<dynamic>.from(notApprovedRoles!.map((x) => x)),
        "notApprovedRoleExtensions": notApprovedRoleExtensions == null ? [] : List<dynamic>.from(notApprovedRoleExtensions!.map((x) => x)),
        "name": name,
        "userStatus": userStatus,
    };
}


enum Area { SOURCE_SYSTEM, CATEGORY }

final areaValues = EnumValues({
    "Category": Area.CATEGORY,
    "SourceSystem": Area.SOURCE_SYSTEM
});

enum Filter { DB_ATOM, DEFAULT }

final filterValues = EnumValues({
    "DB_ATOM": Filter.DB_ATOM,
    "Default": Filter.DEFAULT
});


enum Application { TRACKING1, DB_ATOM }

final applicationValues = EnumValues({
    "DB_ATOM": Application.DB_ATOM,
    "Tracking1": Application.TRACKING1
});

class ClaimantDepartment {
    int? id;
    String? name;

    ClaimantDepartment({
        this.id,
        this.name,
    });

    factory ClaimantDepartment.fromJson(Map<String, dynamic> json) => ClaimantDepartment(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
class FoundImage {
    int? id;
    String? ownerName;
    String? contentType;
    int? uploadDate;
    int? foundId;
    String? title;
    int? fileSize;
    String? imageContent;

    FoundImage({
        this.id,
        this.ownerName,
        this.contentType,
        this.uploadDate,
        this.foundId,
        this.title,
        this.fileSize,
        this.imageContent,
    });

    factory FoundImage.fromJson(Map<String, dynamic> json) => FoundImage(
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


class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}


