// // To parse this JSON data, do
// //
// //     final foundListArticleDetails = foundListArticleDetailsFromJson(jsonString);

// import 'dart:convert';

// FoundListArticleDetails foundListArticleDetailsFromJson(String str) => FoundListArticleDetails.fromJson(json.decode(str));

// String foundListArticleDetailsToJson(FoundListArticleDetails data) => json.encode(data.toJson());

// class FoundListArticleDetails {
//     String? foundId;
//     int? id;
//     String? employeeId;
//     String? slNo;
//     int? inputDate;
//     int? typeOfAsset;
//     Location? typeOfArticle;
//     int? foundDate;
//     String? foundLocation;
//     String? additionalInformation;
//     int? quantity;
//     String? color;
//     List<FoundImage>? images;
//     bool? depositorDbEmp;
//     FoundIdDepositor? depositor;
//     bool? claimantDbEmp;
//     bool? claimantConfirmByEmail;
//     bool? claimantNoSign;
//     FoundIdEntrySecurity? entrySecurity;
//     int? status;
//     int? modifiedDate;
//     String? depositorName;
//     String? locationName;
//     String? entrySecurityName;
//     String? handOverSecurityName;
//     String? depositorDepartmentName;
//     String? claimantDepartmentName;
//     Location? location;

//     FoundListArticleDetails({
//         this.foundId,
//         this.id,
//         this.employeeId,
//         this.slNo,
//         this.inputDate,
//         this.typeOfAsset,
//         this.typeOfArticle,
//         this.foundDate,
//         this.foundLocation,
//         this.additionalInformation,
//         this.quantity,
//         this.color,
//         this.images,
//         this.depositorDbEmp,
//         this.depositor,
//         this.claimantDbEmp,
//         this.claimantConfirmByEmail,
//         this.claimantNoSign,
//         this.entrySecurity,
//         this.status,
//         this.modifiedDate,
//         this.depositorName,
//         this.locationName,
//         this.entrySecurityName,
//         this.handOverSecurityName,
//         this.depositorDepartmentName,
//         this.claimantDepartmentName,
//         this.location,
//     });

//     factory FoundListArticleDetails.fromJson(Map<String, dynamic> json) => FoundListArticleDetails(
//         foundId: json["foundId"],
//         id: json["id"],
//         employeeId: json["employeeId"],
//         slNo: json["slNo"],
//         inputDate: json["inputDate"],
//         typeOfAsset: json["typeOfAsset"],
//         typeOfArticle: json["typeOfArticle"] == null ? null : Location.fromJson(json["typeOfArticle"]),
//         foundDate: json["foundDate"],
//         foundLocation: json["foundLocation"],
//         additionalInformation: json["additionalInformation"],
//         quantity: json["quantity"],
//         color: json["color"],
//         images: json["images"] == null ? [] : List<FoundImage>.from(json["images"]!.map((x) => FoundImage.fromJson(x))),
//         depositorDbEmp: json["depositorDbEmp"],
//         depositor: json["depositor"] == null ? null : FoundIdDepositor.fromJson(json["depositor"]),
//         claimantDbEmp: json["claimantDbEmp"],
//         claimantConfirmByEmail: json["claimantConfirmByEmail"],
//         claimantNoSign: json["claimantNoSign"],
//         entrySecurity: json["entrySecurity"] == null ? null : FoundIdEntrySecurity.fromJson(json["entrySecurity"]),
//         status: json["status"],
//         modifiedDate: json["modifiedDate"],
//         depositorName: json["depositorName"],
//         locationName: json["locationName"],
//         entrySecurityName: json["entrySecurityName"],
//         handOverSecurityName: json["handOverSecurityName"],
//         depositorDepartmentName: json["depositorDepartmentName"],
//         claimantDepartmentName: json["claimantDepartmentName"],
//         location: json["location"] == null ? null : Location.fromJson(json["location"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "foundId": foundId,
//         "id": id,
//         "employeeId":employeeId,
//         "slNo": slNo,
//         "inputDate": inputDate,
//         "typeOfAsset": typeOfAsset,
//         "typeOfArticle": typeOfArticle?.toJson(),
//         "foundDate": foundDate,
//         "foundLocation": foundLocation,
//         "additionalInformation": additionalInformation,
//         "quantity": quantity,
//         "color": color,
//         "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
//         "depositorDbEmp": depositorDbEmp,
//         "depositor": depositor?.toJson(),
//         "claimantDbEmp": claimantDbEmp,
//         "claimantConfirmByEmail": claimantConfirmByEmail,
//         "claimantNoSign": claimantNoSign,
//         "entrySecurity": entrySecurity?.toJson(),
//         "status": status,
//         "modifiedDate": modifiedDate,
//         "depositorName": depositorName,
//         "locationName": locationName,
//         "entrySecurityName": entrySecurityName,
//         "handOverSecurityName": handOverSecurityName,
//         "depositorDepartmentName": depositorDepartmentName,
//         "claimantDepartmentName": claimantDepartmentName,
//         "location": location?.toJson(),
//     };
// }

// class FoundIdDepositor {
//     int? userId;
//     String? userName;
//     String? email;
//     String? firstName;
//     String? lastName;
//     String? salutation;
//     String? phone;
//     String? mobile;
//     String? fax;
//     String? location;
//     String? language;
//     String? timezone;
//     List<Role>? roles;
//     List<RoleExtension>? roleExtensions;
//     List<dynamic>? notApprovedRoles;
//     List<dynamic>? notApprovedRoleExtensions;
//     dynamic recertificationDate;
//     dynamic recertifiedBy;
//     dynamic nextRecertificationDate;
//     bool? deactivated;
//     String? name;
//     String? userStatus;

//     FoundIdDepositor({
//         this.userId,
//         this.userName,
//         this.email,
//         this.firstName,
//         this.lastName,
//         this.salutation,
//         this.phone,
//         this.mobile,
//         this.fax,
//         this.location,
//         this.language,
//         this.timezone,
//         this.roles,
//         this.roleExtensions,
//         this.notApprovedRoles,
//         this.notApprovedRoleExtensions,
//         this.recertificationDate,
//         this.recertifiedBy,
//         this.nextRecertificationDate,
//         this.deactivated,
//         this.name,
//         this.userStatus,
//     });

//     factory FoundIdDepositor.fromJson(Map<String, dynamic> json) => FoundIdDepositor(
//         userId: json["userId"],
//         userName: json["userName"],
//         email: json["email"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         salutation: json["salutation"],
//         phone: json["phone"],
//         mobile: json["mobile"],
//         fax: json["fax"],
//         location: json["location"],
//         language: json["language"],
//         timezone: json["timezone"],
//         roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
//         roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
//         notApprovedRoles: json["notApprovedRoles"] == null ? [] : List<dynamic>.from(json["notApprovedRoles"]!.map((x) => x)),
//         notApprovedRoleExtensions: json["notApprovedRoleExtensions"] == null ? [] : List<dynamic>.from(json["notApprovedRoleExtensions"]!.map((x) => x)),
//         recertificationDate: json["recertificationDate"],
//         recertifiedBy: json["recertifiedBy"],
//         nextRecertificationDate: json["nextRecertificationDate"],
//         deactivated: json["deactivated"],
//         name: json["name"],
//         userStatus: json["userStatus"],
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "userName": userName,
//         "email": email,
//         "firstName": firstName,
//         "lastName": lastName,
//         "salutation": salutation,
//         "phone": phone,
//         "mobile": mobile,
//         "fax": fax,
//         "location": location,
//         "language": language,
//         "timezone": timezone,
//         "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
//         "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
//         "notApprovedRoles": notApprovedRoles == null ? [] : List<dynamic>.from(notApprovedRoles!.map((x) => x)),
//         "notApprovedRoleExtensions": notApprovedRoleExtensions == null ? [] : List<dynamic>.from(notApprovedRoleExtensions!.map((x) => x)),
//         "recertificationDate": recertificationDate,
//         "recertifiedBy": recertifiedBy,
//         "nextRecertificationDate": nextRecertificationDate,
//         "deactivated": deactivated,
//         "name": name,
//         "userStatus": userStatus,
//     };
// }
// class FoundIdEntrySecurity {
//     int? userId;
//     String? userName;
//     String? email;
//     String? firstName;
//     String? lastName;
//     String? salutation;
//     String? phone;
//     String? mobile;
//     String? fax;
//     String? location;
//     String? language;
//     String? timezone;
//     List<Role>? roles;
//     List<RoleExtension>? roleExtensions;
//     List<dynamic>? notApprovedRoles;
//     List<dynamic>? notApprovedRoleExtensions;
//     dynamic recertificationDate;
//     dynamic recertifiedBy;
//     dynamic nextRecertificationDate;
//     bool? deactivated;
//     String? name;
//     String? userStatus;

//     FoundIdEntrySecurity({
//         this.userId,
//         this.userName,
//         this.email,
//         this.firstName,
//         this.lastName,
//         this.salutation,
//         this.phone,
//         this.mobile,
//         this.fax,
//         this.location,
//         this.language,
//         this.timezone,
//         this.roles,
//         this.roleExtensions,
//         this.notApprovedRoles,
//         this.notApprovedRoleExtensions,
//         this.recertificationDate,
//         this.recertifiedBy,
//         this.nextRecertificationDate,
//         this.deactivated,
//         this.name,
//         this.userStatus,
//     });

//     factory FoundIdEntrySecurity.fromJson(Map<String, dynamic> json) => FoundIdEntrySecurity(
//         userId: json["userId"],
//         userName: json["userName"],
//         email: json["email"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         salutation: json["salutation"],
//         phone: json["phone"],
//         mobile: json["mobile"],
//         fax: json["fax"],
//         location: json["location"],
//         language: json["language"],
//         timezone: json["timezone"],
//         roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
//         roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
//         notApprovedRoles: json["notApprovedRoles"] == null ? [] : List<dynamic>.from(json["notApprovedRoles"]!.map((x) => x)),
//         notApprovedRoleExtensions: json["notApprovedRoleExtensions"] == null ? [] : List<dynamic>.from(json["notApprovedRoleExtensions"]!.map((x) => x)),
//         recertificationDate: json["recertificationDate"],
//         recertifiedBy: json["recertifiedBy"],
//         nextRecertificationDate: json["nextRecertificationDate"],
//         deactivated: json["deactivated"],
//         name: json["name"],
//         userStatus: json["userStatus"],
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "userName": userName,
//         "email": email,
//         "firstName": firstName,
//         "lastName": lastName,
//         "salutation": salutation,
//         "phone": phone,
//         "mobile": mobile,
//         "fax": fax,
//         "location": location,
//         "language": language,
//         "timezone": timezone,
//         "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
//         "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
//         "notApprovedRoles": notApprovedRoles == null ? [] : List<dynamic>.from(notApprovedRoles!.map((x) => x)),
//         "notApprovedRoleExtensions": notApprovedRoleExtensions == null ? [] : List<dynamic>.from(notApprovedRoleExtensions!.map((x) => x)),
//         "recertificationDate": recertificationDate,
//         "recertifiedBy": recertifiedBy,
//         "nextRecertificationDate": nextRecertificationDate,
//         "deactivated": deactivated,
//         "name": name,
//         "userStatus": userStatus,
//     };
// }

// class RoleExtension {
//     int? roleExtensionId;
//     int? roleId;
//     String? displayName;
//     Area? area;
//     Filter? filter;
//     dynamic rootNodeId;
//     dynamic nodeId;
//     dynamic accessRight;

//     RoleExtension({
//         this.roleExtensionId,
//         this.roleId,
//         this.displayName,
//         this.area,
//         this.filter,
//         this.rootNodeId,
//         this.nodeId,
//         this.accessRight,
//     });

//     factory RoleExtension.fromJson(Map<String, dynamic> json) => RoleExtension(
//         roleExtensionId: json["roleExtensionId"],
//         roleId: json["roleId"],
//         displayName: json["displayName"],
//         area: areaValues.map[json["area"]]!,
//         filter: filterValues.map[json["filter"]]!,
//         rootNodeId: json["rootNodeId"],
//         nodeId: json["nodeId"],
//         accessRight: json["accessRight"],
//     );

//     Map<String, dynamic> toJson() => {
//         "roleExtensionId": roleExtensionId,
//         "roleId": roleId,
//         "displayName": displayName,
//         "area": areaValues.reverse[area],
//         "filter": filterValues.reverse[filter],
//         "rootNodeId": rootNodeId,
//         "nodeId": nodeId,
//         "accessRight": accessRight,
//     };
// }

// enum Area { SOURCE_SYSTEM, CATEGORY }

// final areaValues = EnumValues({
//     "Category": Area.CATEGORY,
//     "SourceSystem": Area.SOURCE_SYSTEM
// });

// enum Filter { DB_ATOM, DEFAULT }

// final filterValues = EnumValues({
//     "DB_ATOM": Filter.DB_ATOM,
//     "Default": Filter.DEFAULT
// });

// class Role {
//     int? roleId;
//     String? application;
//     String? roleName;
//     List<RoleExtension>? roleExtensions;
//     String? name;

//     Role({
//         this.roleId,
//         this.application,
//         this.roleName,
//         this.roleExtensions,
//         this.name,
//     });

//     factory Role.fromJson(Map<String, dynamic> json) => Role(
//         roleId: json["roleId"],
//         application: json["application"],
//         roleName: json["roleName"],
//         roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "roleId": roleId,
//         "application": application,
//         "roleName": roleName,
//         "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
//         "name": name,
//     };
// }

// class FoundImage {
//     int? id;
//     String? ownerName;
//     String? contentType;
//     int? uploadDate;
//     int? foundId;
//     String? title;
//     int? fileSize;
//     String? imageContent;

//     FoundImage({
//         this.id,
//         this.ownerName,
//         this.contentType,
//         this.uploadDate,
//         this.foundId,
//         this.title,
//         this.fileSize,
//         this.imageContent,
//     });

//     factory FoundImage.fromJson(Map<String, dynamic> json) => FoundImage(
//         id: json["id"],
//         ownerName: json["ownerName"],
//         contentType: json["contentType"],
//         uploadDate: json["uploadDate"],
//         foundId: json["foundId"],
//         title: json["title"],
//         fileSize: json["fileSize"],
//         imageContent: json["imageContent"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "ownerName": ownerName,
//         "contentType": contentType,
//         "uploadDate": uploadDate,
//         "foundId": foundId,
//         "title": title,
//         "fileSize": fileSize,
//         "imageContent": imageContent,
//     };
// }

// class Location {
//     int? id;
//     String? name;

//     Location({
//         this.id,
//         this.name,
//     });

//     factory Location.fromJson(Map<String, dynamic> json) => Location(
//         id: json["id"],
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//     };
// }

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         reverseMap = map.map((k, v) => MapEntry(v, k));
//         return reverseMap;
//     }
// }


// To parse this JSON data, do
//
//     final foundListArticleDetails = foundListArticleDetailsFromJson(jsonString);

// import 'dart:convert';

// FoundListArticleDetails foundListArticleDetailsFromJson(String str) => FoundListArticleDetails.fromJson(json.decode(str));

// String foundListArticleDetailsToJson(FoundListArticleDetails data) => json.encode(data.toJson());

// class FoundListArticleDetails {
//     String? foundId;
//     int? id;
//     String? slNo;
//     int? inputDate;
//     int? typeOfAsset;
//     ClaimantDepartment? typeOfArticle;
//     int? foundDate;
//     String? foundLocation;
//     String? additionalInformation;
//     int? quantity;
//     String? color;
//     List<FoundImage>? images;
//     bool? depositorDbEmp;
//     Claimant? depositor;
//     String? employeeId;
//     ClaimantDepartment? depositorDepartment;
//     bool? claimantDbEmp;
//     bool? claimantConfirmByEmail;
//     Claimant? claimant;
//     bool? claimantNoSign;
//     String? claimantEmployeeId;
//     ClaimantDepartment? claimantDepartment;
//     int? handoverDate;
//     Claimant? entrySecurity;
//     Claimant? handoverSecurity;
//     int? status;
//     int? modifiedDate;
//     String? modifiedBy;
//     String? depositorName;
//     String? claimantName;
//     String? locationName;
//     String? entrySecurityName;
//     String? handOverSecurityName;
//     String? depositorDepartmentName;
//     String? claimantDepartmentName;
//     ClaimantDepartment? location;

//     FoundListArticleDetails({
//         this.foundId,
//         this.id,
//         this.slNo,
//         this.inputDate,
//         this.typeOfAsset,
//         this.typeOfArticle,
//         this.foundDate,
//         this.foundLocation,
//         this.additionalInformation,
//         this.quantity,
//         this.color,
//         this.images,
//         this.depositorDbEmp,
//         this.depositor,
//         this.employeeId,
//         this.depositorDepartment,
//         this.claimantDbEmp,
//         this.claimantConfirmByEmail,
//         this.claimant,
//         this.claimantNoSign,
//         this.claimantEmployeeId,
//         this.claimantDepartment,
//         this.handoverDate,
//         this.entrySecurity,
//         this.handoverSecurity,
//         this.status,
//         this.modifiedDate,
//         this.modifiedBy,
//         this.depositorName,
//         this.claimantName,
//         this.locationName,
//         this.entrySecurityName,
//         this.handOverSecurityName,
//         this.depositorDepartmentName,
//         this.claimantDepartmentName,
//         this.location,
//     });

//     factory FoundListArticleDetails.fromJson(Map<String, dynamic> json) => FoundListArticleDetails(
//         foundId: json["foundId"],
//         id: json["id"],
//         slNo: json["slNo"],
//         inputDate: json["inputDate"],
//         typeOfAsset: json["typeOfAsset"],
//         typeOfArticle: json["typeOfArticle"] == null ? null : ClaimantDepartment.fromJson(json["typeOfArticle"]),
//         foundDate: json["foundDate"],
//         foundLocation: json["foundLocation"],
//         additionalInformation: json["additionalInformation"],
//         quantity: json["quantity"],
//         color: json["color"],
//         images: json["images"] == null ? [] : List<FoundImage>.from(json["images"]!.map((x) => FoundImage.fromJson(x))),
//         depositorDbEmp: json["depositorDbEmp"],
//         depositor: json["depositor"] == null ? null : Claimant.fromJson(json["depositor"]),
//         employeeId: json["employeeId"],
//         depositorDepartment: json["depositorDepartment"] == null ? null : ClaimantDepartment.fromJson(json["depositorDepartment"]),
//         claimantDbEmp: json["claimantDbEmp"],
//         claimantConfirmByEmail: json["claimantConfirmByEmail"],
//         claimant: json["claimant"] == null ? null : Claimant.fromJson(json["claimant"]),
//         claimantNoSign: json["claimantNoSign"],
//         claimantEmployeeId: json["claimantEmployeeId"],
//         claimantDepartment: json["claimantDepartment"] == null ? null : ClaimantDepartment.fromJson(json["claimantDepartment"]),
//         handoverDate: json["handoverDate"],
//         entrySecurity: json["entrySecurity"] == null ? null : Claimant.fromJson(json["entrySecurity"]),
//         handoverSecurity: json["handoverSecurity"] == null ? null : Claimant.fromJson(json["handoverSecurity"]),
//         status: json["status"],
//         modifiedDate: json["modifiedDate"],
//         modifiedBy: json["modifiedBy"],
//         depositorName: json["depositorName"],
//         claimantName: json["claimantName"],
//         locationName: json["locationName"],
//         entrySecurityName: json["entrySecurityName"],
//         handOverSecurityName: json["handOverSecurityName"],
//         depositorDepartmentName: json["depositorDepartmentName"],
//         claimantDepartmentName: json["claimantDepartmentName"],
//         location: json["location"] == null ? null : ClaimantDepartment.fromJson(json["location"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "foundId": foundId,
//         "id": id,
//         "slNo": slNo,
//         "inputDate": inputDate,
//         "typeOfAsset": typeOfAsset,
//         "typeOfArticle": typeOfArticle?.toJson(),
//         "foundDate": foundDate,
//         "foundLocation": foundLocation,
//         "additionalInformation": additionalInformation,
//         "quantity": quantity,
//         "color": color,
//         "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
//         "depositorDbEmp": depositorDbEmp,
//         "depositor": depositor?.toJson(),
//         "employeeId": employeeId,
//         "depositorDepartment": depositorDepartment?.toJson(),
//         "claimantDbEmp": claimantDbEmp,
//         "claimantConfirmByEmail": claimantConfirmByEmail,
//         "claimant": claimant?.toJson(),
//         "claimantNoSign": claimantNoSign,
//         "claimantEmployeeId": claimantEmployeeId,
//         "claimantDepartment": claimantDepartment?.toJson(),
//         "handoverDate": handoverDate,
//         "entrySecurity": entrySecurity?.toJson(),
//         "handoverSecurity": handoverSecurity?.toJson(),
//         "status": status,
//         "modifiedDate": modifiedDate,
//         "modifiedBy": modifiedBy,
//         "depositorName": depositorName,
//         "claimantName": claimantName,
//         "locationName": locationName,
//         "entrySecurityName": entrySecurityName,
//         "handOverSecurityName": handOverSecurityName,
//         "depositorDepartmentName": depositorDepartmentName,
//         "claimantDepartmentName": claimantDepartmentName,
//         "location": location?.toJson(),
//     };
// }

// class Claimant {
//     int? userId;
//     String? userName;
//     String? email;
//     String? firstName;
//     String? lastName;
//     String? salutation;
//     String? phone;
//     String? mobile;
//     String? fax;
//     String? location;
//     String? language;
//     String? timezone;
//     List<Role>? roles;
//     List<RoleExtension>? roleExtensions;
//     List<dynamic>? notApprovedRoles;
//     List<dynamic>? notApprovedRoleExtensions;
//     dynamic recertificationDate;
//     dynamic recertifiedBy;
//     dynamic nextRecertificationDate;
//     bool? deactivated;
//     String? name;
//     String? userStatus;

//     Claimant({
//         this.userId,
//         this.userName,
//         this.email,
//         this.firstName,
//         this.lastName,
//         this.salutation,
//         this.phone,
//         this.mobile,
//         this.fax,
//         this.location,
//         this.language,
//         this.timezone,
//         this.roles,
//         this.roleExtensions,
//         this.notApprovedRoles,
//         this.notApprovedRoleExtensions,
//         this.recertificationDate,
//         this.recertifiedBy,
//         this.nextRecertificationDate,
//         this.deactivated,
//         this.name,
//         this.userStatus,
//     });

//     factory Claimant.fromJson(Map<String, dynamic> json) => Claimant(
//         userId: json["userId"],
//         userName: json["userName"],
//         email: json["email"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         salutation: json["salutation"],
//         phone: json["phone"],
//         mobile: json["mobile"],
//         fax: json["fax"],
//         location: json["location"],
//         language: json["language"],
//         timezone: json["timezone"],
//         roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
//         roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
//         notApprovedRoles: json["notApprovedRoles"] == null ? [] : List<dynamic>.from(json["notApprovedRoles"]!.map((x) => x)),
//         notApprovedRoleExtensions: json["notApprovedRoleExtensions"] == null ? [] : List<dynamic>.from(json["notApprovedRoleExtensions"]!.map((x) => x)),
//         recertificationDate: json["recertificationDate"],
//         recertifiedBy: json["recertifiedBy"],
//         nextRecertificationDate: json["nextRecertificationDate"],
//         deactivated: json["deactivated"],
//         name: json["name"],
//         userStatus: json["userStatus"],
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "userName": userName,
//         "email": email,
//         "firstName": firstName,
//         "lastName": lastName,
//         "salutation": salutation,
//         "phone": phone,
//         "mobile": mobile,
//         "fax": fax,
//         "location": location,
//         "language": language,
//         "timezone": timezone,
//         "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
//         "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
//         "notApprovedRoles": notApprovedRoles == null ? [] : List<dynamic>.from(notApprovedRoles!.map((x) => x)),
//         "notApprovedRoleExtensions": notApprovedRoleExtensions == null ? [] : List<dynamic>.from(notApprovedRoleExtensions!.map((x) => x)),
//         "recertificationDate": recertificationDate,
//         "recertifiedBy": recertifiedBy,
//         "nextRecertificationDate": nextRecertificationDate,
//         "deactivated": deactivated,
//         "name": name,
//         "userStatus": userStatus,
//     };
// }

// class RoleExtension {
//     int? roleExtensionId;
//     int? roleId;
//     String? displayName;
//     Area? area;
//     Filter? filter;
//     dynamic rootNodeId;
//     dynamic nodeId;
//     dynamic accessRight;

//     RoleExtension({
//         this.roleExtensionId,
//         this.roleId,
//         this.displayName,
//         this.area,
//         this.filter,
//         this.rootNodeId,
//         this.nodeId,
//         this.accessRight,
//     });

//     factory RoleExtension.fromJson(Map<String, dynamic> json) => RoleExtension(
//         roleExtensionId: json["roleExtensionId"],
//         roleId: json["roleId"],
//         displayName: json["displayName"],
//         area: areaValues.map[json["area"]]!,
//         filter: filterValues.map[json["filter"]]!,
//         rootNodeId: json["rootNodeId"],
//         nodeId: json["nodeId"],
//         accessRight: json["accessRight"],
//     );

//     Map<String, dynamic> toJson() => {
//         "roleExtensionId": roleExtensionId,
//         "roleId": roleId,
//         "displayName": displayName,
//         "area": areaValues.reverse[area],
//         "filter": filterValues.reverse[filter],
//         "rootNodeId": rootNodeId,
//         "nodeId": nodeId,
//         "accessRight": accessRight,
//     };
// }

// enum Area { SOURCE_SYSTEM, CATEGORY }

// final areaValues = EnumValues({
//     "Category": Area.CATEGORY,
//     "SourceSystem": Area.SOURCE_SYSTEM
// });

// enum Filter { DB_ATOM, DEFAULT }

// final filterValues = EnumValues({
//     "DB_ATOM": Filter.DB_ATOM,
//     "Default": Filter.DEFAULT
// });

// class Role {
//     int? roleId;
//     Application? application;
//     String? roleName;
//     List<RoleExtension>? roleExtensions;
//     String? name;

//     Role({
//         this.roleId,
//         this.application,
//         this.roleName,
//         this.roleExtensions,
//         this.name,
//     });

//     factory Role.fromJson(Map<String, dynamic> json) => Role(
//         roleId: json["roleId"],
//         application: applicationValues.map[json["application"]]!,
//         roleName: json["roleName"],
//         roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "roleId": roleId,
//         "application": applicationValues.reverse[application],
//         "roleName": roleName,
//         "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
//         "name": name,
//     };
// }

// enum Application { TRACKING1, DB_ATOM }

// final applicationValues = EnumValues({
//     "DB_ATOM": Application.DB_ATOM,
//     "Tracking1": Application.TRACKING1
// });

// class ClaimantDepartment {
//     int? id;
//     String? name;

//     ClaimantDepartment({
//         this.id,
//         this.name,
//     });

//     factory ClaimantDepartment.fromJson(Map<String, dynamic> json) => ClaimantDepartment(
//         id: json["id"],
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//     };
// }

// class FoundImage {
//     int? id;
//     String? ownerName;
//     String? contentType;
//     int? uploadDate;
//     int? foundId;
//     String? title;
//     int? fileSize;
//     String? imageContent;

//     FoundImage({
//         this.id,
//         this.ownerName,
//         this.contentType,
//         this.uploadDate,
//         this.foundId,
//         this.title,
//         this.fileSize,
//         this.imageContent,
//     });

//     factory FoundImage.fromJson(Map<String, dynamic> json) => FoundImage(
//         id: json["id"],
//         ownerName: json["ownerName"],
//         contentType: json["contentType"],
//         uploadDate: json["uploadDate"],
//         foundId: json["foundId"],
//         title: json["title"],
//         fileSize: json["fileSize"],
//         imageContent: json["imageContent"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "ownerName": ownerName,
//         "contentType": contentType,
//         "uploadDate": uploadDate,
//         "foundId": foundId,
//         "title": title,
//         "fileSize": fileSize,
//         "imageContent": imageContent,
//     };
// }

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         reverseMap = map.map((k, v) => MapEntry(v, k));
//         return reverseMap;
//     }
// }
// To parse this JSON data, do
//
//     final foundListArticleDetails = foundListArticleDetailsFromJson(jsonString);

// import 'dart:convert';

// FoundListArticleDetails foundListArticleDetailsFromJson(String str) => FoundListArticleDetails.fromJson(json.decode(str));

// String foundListArticleDetailsToJson(FoundListArticleDetails data) => json.encode(data.toJson());

// class FoundListArticleDetails {
//     List<FoundListElement>? list;
//     int? totalCount;
//     int? currentPageNo;
//     int? totalPageCount;

//     FoundListArticleDetails({
//         this.list,
//         this.totalCount,
//         this.currentPageNo,
//         this.totalPageCount,
//     });

//     factory FoundListArticleDetails.fromJson(Map<String, dynamic> json) => FoundListArticleDetails(
//         list: json["list"] == null ? [] : List<FoundListElement>.from(json["list"]!.map((x) => FoundListElement.fromJson(x))),
//         totalCount: json["totalCount"],
//         currentPageNo: json["currentPageNo"],
//         totalPageCount: json["totalPageCount"],
//     );

//     Map<String, dynamic> toJson() => {
//         "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
//         "totalCount": totalCount,
//         "currentPageNo": currentPageNo,
//         "totalPageCount": totalPageCount,
//     };
// }

// class FoundListElement {
//     int? id;
//     String? slNo;
//     ClaimantDepartment? locationRegion;
//     int? typeOfAsset;
//     ClaimantDepartment? typeOfArticle;
//     String? foundLocation;
//     String? additionalInformation;
//     int? quantity;
//     String? color;
//     List<FoundImage>? images;
//     bool? depositorDbEmp;
//     FoundIdDepositor? depositor;
//     String? employeeId;
//     ClaimantDepartment? depositorDepartment;
//     bool? claimantDbEmp;
//     bool? claimantConfirmByEmail;
//     Claimant? claimant;
//     bool? claimantNoSign;
//     String? claimantEmployeeId;
//     ClaimantDepartment? claimantDepartment;
//     Claimant? entrySecurity;
//     Claimant? handoverSecurity;
//     int? status;
//     String? modifiedDate;
//     String? modifiedBy;
//     String? depositorName;
//     String? locationName;
//     String? entrySecurityName;
//     String? handOverSecurityName;
//     DepartmentName? depositorDepartmentName;
//     DepartmentName? claimantDepartmentName;
//     ClaimantDepartment? location;
//     String? inputDate;
//     String? foundDate;
//     String? handoverDate;
//     String? claimantName;

//     FoundListElement({
//         this.id,
//         this.slNo,
//         this.locationRegion,
//         this.typeOfAsset,
//         this.typeOfArticle,
//         this.foundLocation,
//         this.additionalInformation,
//         this.quantity,
//         this.color,
//         this.images,
//         this.depositorDbEmp,
//         this.depositor,
//         this.employeeId,
//         this.depositorDepartment,
//         this.claimantDbEmp,
//         this.claimantConfirmByEmail,
//         this.claimant,
//         this.claimantNoSign,
//         this.claimantEmployeeId,
//         this.claimantDepartment,
//         this.entrySecurity,
//         this.handoverSecurity,
//         this.status,
//         this.modifiedDate,
//         this.modifiedBy,
//         this.depositorName,
//         this.locationName,
//         this.entrySecurityName,
//         this.handOverSecurityName,
//         this.depositorDepartmentName,
//         this.claimantDepartmentName,
//         this.location,
//         this.inputDate,
//         this.foundDate,
//         this.handoverDate,
//         this.claimantName,
//     });

//     factory FoundListElement.fromJson(Map<String, dynamic> json) => FoundListElement(
//         id: json["id"],
//         slNo: json["slNo"],
//         locationRegion: json["locationRegion"] == null ? null : ClaimantDepartment.fromJson(json["locationRegion"]),
//         typeOfAsset: json["typeOfAsset"],
//         typeOfArticle: json["typeOfArticle"] == null ? null : ClaimantDepartment.fromJson(json["typeOfArticle"]),
//         foundLocation: json["foundLocation"],
//         additionalInformation: json["additionalInformation"],
//         quantity: json["quantity"],
//         color: json["color"],
//         images: json["images"] == null ? [] : List<FoundImage>.from(json["images"]!.map((x) => FoundImage.fromJson(x))),
//         depositorDbEmp: json["depositorDbEmp"],
//         depositor: json["depositor"] == null ? null : FoundIdDepositor.fromJson(json["depositor"]),
//         employeeId: json["employeeId"],
//         depositorDepartment: json["depositorDepartment"] == null ? null : ClaimantDepartment.fromJson(json["depositorDepartment"]),
//         claimantDbEmp: json["claimantDbEmp"],
//         claimantConfirmByEmail: json["claimantConfirmByEmail"],
//         claimant: json["claimant"] == null ? null : Claimant.fromJson(json["claimant"]),
//         claimantNoSign: json["claimantNoSign"],
//         claimantEmployeeId: json["claimantEmployeeId"],
//         claimantDepartment: json["claimantDepartment"] == null ? null : ClaimantDepartment.fromJson(json["claimantDepartment"]),
//         entrySecurity: json["entrySecurity"] == null ? null : Claimant.fromJson(json["entrySecurity"]),
//         handoverSecurity: json["handoverSecurity"] == null ? null : Claimant.fromJson(json["handoverSecurity"]),
//         status: json["status"],
//         modifiedDate: json["modifiedDate"],
//         modifiedBy: json["modifiedBy"],
//         depositorName: json["depositorName"],
//         locationName: json["locationName"],
//         entrySecurityName: json["entrySecurityName"],
//         handOverSecurityName: json["handOverSecurityName"],
//         depositorDepartmentName: departmentNameValues.map[json["depositorDepartmentName"]]!,
//         claimantDepartmentName: departmentNameValues.map[json["claimantDepartmentName"]]!,
//         location: json["location"] == null ? null : ClaimantDepartment.fromJson(json["location"]),
//         inputDate: json["inputDate"],
//         foundDate: json["foundDate"],
//         handoverDate: json["handoverDate"],
//         claimantName: json["claimantName"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "slNo": slNo,
//         "locationRegion": locationRegion?.toJson(),
//         "typeOfAsset": typeOfAsset,
//         "typeOfArticle": typeOfArticle?.toJson(),
//         "foundLocation": foundLocation,
//         "additionalInformation": additionalInformation,
//         "quantity": quantity,
//         "color": color,
//         "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
//         "depositorDbEmp": depositorDbEmp,
//         "depositor": depositor?.toJson(),
//         "employeeId": employeeId,
//         "depositorDepartment": depositorDepartment?.toJson(),
//         "claimantDbEmp": claimantDbEmp,
//         "claimantConfirmByEmail": claimantConfirmByEmail,
//         "claimant": claimant?.toJson(),
//         "claimantNoSign": claimantNoSign,
//         "claimantEmployeeId": claimantEmployeeId,
//         "claimantDepartment": claimantDepartment?.toJson(),
//         "entrySecurity": entrySecurity?.toJson(),
//         "handoverSecurity": handoverSecurity?.toJson(),
//         "status": status,
//         "modifiedDate": modifiedDate,
//         "modifiedBy": modifiedBy,
//         "depositorName": depositorName,
//         "locationName": locationName,
//         "entrySecurityName": entrySecurityName,
//         "handOverSecurityName": handOverSecurityName,
//         "depositorDepartmentName": departmentNameValues.reverse[depositorDepartmentName],
//         "claimantDepartmentName": departmentNameValues.reverse[claimantDepartmentName],
//         "location": location?.toJson(),
//         "inputDate": inputDate,
//         "foundDate": foundDate,
//         "handoverDate": handoverDate,
//         "claimantName": claimantName,
//     };
// }

// class FoundIdDepositor {
//     int? userId;
//     String? userName;
//     String? email;
//     String? firstName;
//     String? lastName;
//     String? phone;
//     List<Role>? roles;
//     List<RoleExtension>? roleExtensions;
//     List<dynamic>? notApprovedRoles;
//     List<dynamic>? notApprovedRoleExtensions;
//     String? name;
//     UserStatus? userStatus;

//     FoundIdDepositor({
//         this.userId,
//         this.userName,
//         this.email,
//         this.firstName,
//         this.lastName,
//         this.phone,
//         this.roles,
//         this.roleExtensions,
//         this.notApprovedRoles,
//         this.notApprovedRoleExtensions,
//         this.name,
//         this.userStatus,
//     });

//     factory FoundIdDepositor.fromJson(Map<String, dynamic> json) => FoundIdDepositor(
//         userId: json["userId"],
//         userName: json["userName"],
//         email: json["email"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         phone: json["phone"],
//         roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
//         roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
//         notApprovedRoles: json["notApprovedRoles"] == null ? [] : List<dynamic>.from(json["notApprovedRoles"]!.map((x) => x)),
//         notApprovedRoleExtensions: json["notApprovedRoleExtensions"] == null ? [] : List<dynamic>.from(json["notApprovedRoleExtensions"]!.map((x) => x)),
//         name: json["name"],
//         userStatus: userStatusValues.map[json["userStatus"]]!,
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "userName": userName,
//         "email": email,
//         "firstName": firstName,
//         "lastName": lastName,
//         "phone": phone,
//         "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
//         "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
//         "notApprovedRoles": notApprovedRoles == null ? [] : List<dynamic>.from(notApprovedRoles!.map((x) => x)),
//         "notApprovedRoleExtensions": notApprovedRoleExtensions == null ? [] : List<dynamic>.from(notApprovedRoleExtensions!.map((x) => x)),
//         "name": name,
//         "userStatus": userStatusValues.reverse[userStatus],
//     };
// }

// class Claimant {
//     int? userId;
//     String? userName;
//     String? email;
//     String? firstName;
//     String? lastName;
//     String? phone;
//     List<Role>? roles;
//     List<RoleExtension>? roleExtensions;
//     List<dynamic>? notApprovedRoles;
//     List<dynamic>? notApprovedRoleExtensions;
//     String? name;
//     UserStatus? userStatus;

//     Claimant({
//         this.userId,
//         this.userName,
//         this.email,
//         this.firstName,
//         this.lastName,
//         this.phone,
//         this.roles,
//         this.roleExtensions,
//         this.notApprovedRoles,
//         this.notApprovedRoleExtensions,
//         this.name,
//         this.userStatus,
//     });

//     factory Claimant.fromJson(Map<String, dynamic> json) => Claimant(
//         userId: json["userId"],
//         userName: json["userName"],
//         email: json["email"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         phone: json["phone"],
//         roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
//         roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
//         notApprovedRoles: json["notApprovedRoles"] == null ? [] : List<dynamic>.from(json["notApprovedRoles"]!.map((x) => x)),
//         notApprovedRoleExtensions: json["notApprovedRoleExtensions"] == null ? [] : List<dynamic>.from(json["notApprovedRoleExtensions"]!.map((x) => x)),
//         name: json["name"],
//         userStatus: userStatusValues.map[json["userStatus"]]!,
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "userName": userName,
//         "email": email,
//         "firstName": firstName,
//         "lastName": lastName,
//         "phone": phone,
//         "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
//         "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
//         "notApprovedRoles": notApprovedRoles == null ? [] : List<dynamic>.from(notApprovedRoles!.map((x) => x)),
//         "notApprovedRoleExtensions": notApprovedRoleExtensions == null ? [] : List<dynamic>.from(notApprovedRoleExtensions!.map((x) => x)),
//         "name": name,
//         "userStatus": userStatusValues.reverse[userStatus],
//     };
// }

// class RoleExtension {
//     int? roleExtensionId;
//     int? roleId;
//     DisplayName? displayName;
//     Area? area;
//     Filter? filter;
//     dynamic rootNodeId;
//     dynamic nodeId;
//     dynamic accessRight;

//     RoleExtension({
//         this.roleExtensionId,
//         this.roleId,
//         this.displayName,
//         this.area,
//         this.filter,
//         this.rootNodeId,
//         this.nodeId,
//         this.accessRight,
//     });

//     factory RoleExtension.fromJson(Map<String, dynamic> json) => RoleExtension(
//         roleExtensionId: json["roleExtensionId"],
//         roleId: json["roleId"],
//         displayName: displayNameValues.map[json["displayName"]]!,
//         area: areaValues.map[json["area"]]!,
//         filter: filterValues.map[json["filter"]]!,
//         rootNodeId: json["rootNodeId"],
//         nodeId: json["nodeId"],
//         accessRight: json["accessRight"],
//     );

//     Map<String, dynamic> toJson() => {
//         "roleExtensionId": roleExtensionId,
//         "roleId": roleId,
//         "displayName": displayNameValues.reverse[displayName],
//         "area": areaValues.reverse[area],
//         "filter": filterValues.reverse[filter],
//         "rootNodeId": rootNodeId,
//         "nodeId": nodeId,
//         "accessRight": accessRight,
//     };
// }

// enum Area { SOURCE_SYSTEM, CATEGORY }

// final areaValues = EnumValues({
//     "Category": Area.CATEGORY,
//     "SourceSystem": Area.SOURCE_SYSTEM
// });

// enum DisplayName { T1_USER_SOURCE_SYSTEM_DB_ATOM, T1_ANALYST_SOURCE_SYSTEM_DB_ATOM, T1_MANAGER_SOURCE_SYSTEM_DB_ATOM, T1_PERFORMER_SOURCE_SYSTEM_DB_ATOM, T1_ADMIN_SOURCE_SYSTEM_DB_ATOM, T1_ADMIN_CATEGORY_DB_ATOM, T1_ANALYST_CATEGORY_DB_ATOM, T1_MANAGER_CATEGORY_DB_ATOM, T1_PERFORMER_CATEGORY_DB_ATOM, T1_USER_CATEGORY_DB_ATOM, T1_ADMIN_SOURCE_SYSTEM_DEFAULT, T1_USER_SOURCE_SYSTEM_DEFAULT }

// final displayNameValues = EnumValues({
//     "T1_Admin Category DB_ATOM": DisplayName.T1_ADMIN_CATEGORY_DB_ATOM,
//     "T1_Admin Source System DB_ATOM": DisplayName.T1_ADMIN_SOURCE_SYSTEM_DB_ATOM,
//     "T1_Admin Source System Default": DisplayName.T1_ADMIN_SOURCE_SYSTEM_DEFAULT,
//     "T1_Analyst Category DB_ATOM": DisplayName.T1_ANALYST_CATEGORY_DB_ATOM,
//     "T1_Analyst Source System DB_ATOM": DisplayName.T1_ANALYST_SOURCE_SYSTEM_DB_ATOM,
//     "T1_Manager Category DB_ATOM": DisplayName.T1_MANAGER_CATEGORY_DB_ATOM,
//     "T1_Manager Source System DB_ATOM": DisplayName.T1_MANAGER_SOURCE_SYSTEM_DB_ATOM,
//     "T1_Performer Category DB_ATOM": DisplayName.T1_PERFORMER_CATEGORY_DB_ATOM,
//     "T1_Performer Source System DB_ATOM": DisplayName.T1_PERFORMER_SOURCE_SYSTEM_DB_ATOM,
//     "T1_User Category DB_ATOM": DisplayName.T1_USER_CATEGORY_DB_ATOM,
//     "T1_User Source System DB_ATOM": DisplayName.T1_USER_SOURCE_SYSTEM_DB_ATOM,
//     "T1_User Source System Default": DisplayName.T1_USER_SOURCE_SYSTEM_DEFAULT
// });

// enum Filter { DB_ATOM, DEFAULT }

// final filterValues = EnumValues({
//     "DB_ATOM": Filter.DB_ATOM,
//     "Default": Filter.DEFAULT
// });

// class Role {
//     int? roleId;
//     Application? application;
//     Name? roleName;
//     List<RoleExtension>? roleExtensions;
//     Name? name;

//     Role({
//         this.roleId,
//         this.application,
//         this.roleName,
//         this.roleExtensions,
//         this.name,
//     });

//     factory Role.fromJson(Map<String, dynamic> json) => Role(
//         roleId: json["roleId"],
//         application: applicationValues.map[json["application"]]!,
//         roleName: nameValues.map[json["roleName"]]!,
//         roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
//         name: nameValues.map[json["name"]]!,
//     );

//     Map<String, dynamic> toJson() => {
//         "roleId": roleId,
//         "application": applicationValues.reverse[application],
//         "roleName": nameValues.reverse[roleName],
//         "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
//         "name": nameValues.reverse[name],
//     };
// }

// enum Application { TRACKING1, DB_ATOM }

// final applicationValues = EnumValues({
//     "DB_ATOM": Application.DB_ATOM,
//     "Tracking1": Application.TRACKING1
// });

// enum Name { T1_MANAGER, T1_ADMIN, T1_PERFORMER, T1_ANALYST, T1_USER, ATOM_STATIC_USER, T1_SUPER_ADMIN }

// final nameValues = EnumValues({
//     "ATOM_STATIC_USER": Name.ATOM_STATIC_USER,
//     "T1_Admin": Name.T1_ADMIN,
//     "T1_Analyst": Name.T1_ANALYST,
//     "T1_Manager": Name.T1_MANAGER,
//     "T1_Performer": Name.T1_PERFORMER,
//     "T1_SuperAdmin": Name.T1_SUPER_ADMIN,
//     "T1_User": Name.T1_USER
// });

// enum UserStatus { ACTIVE, NEW }

// final userStatusValues = EnumValues({
//     "ACTIVE": UserStatus.ACTIVE,
//     "NEW": UserStatus.NEW
// });

// class ClaimantDepartment {
//     int? id;
//     String? name;

//     ClaimantDepartment({
//         this.id,
//         this.name,
//     });

//     factory ClaimantDepartment.fromJson(Map<String, dynamic> json) => ClaimantDepartment(
//         id: json["id"],
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//     };
// }

// enum DepartmentName { CORPORATE_SECURITY, EMPTY, ORGANISATIONS, GRE, DEPARTMENT1, DEPARTMENT_2 }

// final departmentNameValues = EnumValues({
//     "Corporate Security": DepartmentName.CORPORATE_SECURITY,
//     "Department1": DepartmentName.DEPARTMENT1,
//     "Department 2": DepartmentName.DEPARTMENT_2,
//     "": DepartmentName.EMPTY,
//     "GRE": DepartmentName.GRE,
//     "Organisations": DepartmentName.ORGANISATIONS
// });

// class FoundImage {
//     int? id;
//     OwnerName? ownerName;
//     ContentType? contentType;
//     int? uploadDate;
//     int? foundId;
//     String? title;
//     int? fileSize;
//     dynamic imageContent;

//     FoundImage({
//         this.id,
//         this.ownerName,
//         this.contentType,
//         this.uploadDate,
//         this.foundId,
//         this.title,
//         this.fileSize,
//         this.imageContent,
//     });

//     factory FoundImage.fromJson(Map<String, dynamic> json) => FoundImage(
//         id: json["id"],
//         ownerName: ownerNameValues.map[json["ownerName"]]!,
//         contentType: contentTypeValues.map[json["contentType"]]!,
//         uploadDate: json["uploadDate"],
//         foundId: json["foundId"],
//         title: json["title"],
//         fileSize: json["fileSize"],
//         imageContent: json["imageContent"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "ownerName": ownerNameValues.reverse[ownerName],
//         "contentType": contentTypeValues.reverse[contentType],
//         "uploadDate": uploadDate,
//         "foundId": foundId,
//         "title": title,
//         "fileSize": fileSize,
//         "imageContent": imageContent,
//     };
// }

// enum ContentType { APPLICATION_OCTET_STREAM, IMAGE_PNG, IMAGE_JPEG }

// final contentTypeValues = EnumValues({
//     "application/octet-stream": ContentType.APPLICATION_OCTET_STREAM,
//     "image/jpeg": ContentType.IMAGE_JPEG,
//     "image/png": ContentType.IMAGE_PNG
// });

// enum OwnerName { SAYED_NABILAL, ATUL_UTTEKAR, TEST }

// final ownerNameValues = EnumValues({
//     "Atul Uttekar": OwnerName.ATUL_UTTEKAR,
//     "Sayed Nabilal": OwnerName.SAYED_NABILAL,
//     "test": OwnerName.TEST
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         reverseMap = map.map((k, v) => MapEntry(v, k));
//         return reverseMap;
//     }
// }

// import 'dart:convert';

// FoundListArticleDetails foundListArticleDetailsFromJson(String str) => FoundListArticleDetails.fromJson(json.decode(str));

// String foundListArticleDetailsToJson(FoundListArticleDetails data) => json.encode(data.toJson());

// class FoundListArticleDetails {
//     int? id;
//     String? slNo;
//     String? inputDate;
//     ClaimantDepartment? locationRegion;
//     int? typeOfAsset;
//     ClaimantDepartment? typeOfArticle;
//     String? foundDate;
//     String? foundLocation;
//     String? additionalInformation;
//     int? quantity;
//     String? color;
//     List<FoundImage>? images;
//     bool? depositorDbEmp;
//     Claimant? depositor;
//     String? employeeId;
//     ClaimantDepartment? depositorDepartment;
//     bool? claimantDbEmp;
//     bool? claimantConfirmByEmail;
//     Claimant? claimant;
//     bool? claimantNoSign;
//     String? claimantEmployeeId;
//     ClaimantDepartment? claimantDepartment;
//     String? handoverDate;
//     Claimant? entrySecurity;
//     Claimant? handoverSecurity;
//     int? status;
//     String? modifiedDate;
//     String? modifiedBy;
//     String? depositorName;
//     String? claimantName;
//     String? locationName;
//     String? entrySecurityName;
//     String? handOverSecurityName;
//     String? depositorDepartmentName;
//     String? claimantDepartmentName;
//     ClaimantDepartment? location;

//     FoundListArticleDetails({
//         this.id,
//         this.slNo,
//         this.inputDate,
//         this.locationRegion,
//         this.typeOfAsset,
//         this.typeOfArticle,
//         this.foundDate,
//         this.foundLocation,
//         this.additionalInformation,
//         this.quantity,
//         this.color,
//         this.images,
//         this.depositorDbEmp,
//         this.depositor,
//         this.employeeId,
//         this.depositorDepartment,
//         this.claimantDbEmp,
//         this.claimantConfirmByEmail,
//         this.claimant,
//         this.claimantNoSign,
//         this.claimantEmployeeId,
//         this.claimantDepartment,
//         this.handoverDate,
//         this.entrySecurity,
//         this.handoverSecurity,
//         this.status,
//         this.modifiedDate,
//         this.modifiedBy,
//         this.depositorName,
//         this.claimantName,
//         this.locationName,
//         this.entrySecurityName,
//         this.handOverSecurityName,
//         this.depositorDepartmentName,
//         this.claimantDepartmentName,
//         this.location,
//     });

//     factory FoundListArticleDetails.fromJson(Map<String, dynamic> json) => FoundListArticleDetails(
//         id: json["id"],
//         slNo: json["slNo"],
//         inputDate: json["inputDate"],
//         locationRegion: json["locationRegion"] == null ? null : ClaimantDepartment.fromJson(json["locationRegion"]),
//         typeOfAsset: json["typeOfAsset"],
//         typeOfArticle: json["typeOfArticle"] == null ? null : ClaimantDepartment.fromJson(json["typeOfArticle"]),
//         foundDate: json["foundDate"],
//         foundLocation: json["foundLocation"],
//         additionalInformation: json["additionalInformation"],
//         quantity: json["quantity"],
//         color: json["color"],
//         images: json["images"] == null ? [] : List<FoundImage>.from(json["images"]!.map((x) => FoundImage.fromJson(x))),
//         depositorDbEmp: json["depositorDbEmp"],
//         depositor: json["depositor"] == null ? null : Claimant.fromJson(json["depositor"]),
//         employeeId: json["employeeId"],
//         depositorDepartment: json["depositorDepartment"] == null ? null : ClaimantDepartment.fromJson(json["depositorDepartment"]),
//         claimantDbEmp: json["claimantDbEmp"],
//         claimantConfirmByEmail: json["claimantConfirmByEmail"],
//         claimant: json["claimant"] == null ? null : Claimant.fromJson(json["claimant"]),
//         claimantNoSign: json["claimantNoSign"],
//         claimantEmployeeId: json["claimantEmployeeId"],
//         claimantDepartment: json["claimantDepartment"] == null ? null : ClaimantDepartment.fromJson(json["claimantDepartment"]),
//         handoverDate: json["handoverDate"],
//         entrySecurity: json["entrySecurity"] == null ? null : Claimant.fromJson(json["entrySecurity"]),
//         handoverSecurity: json["handoverSecurity"] == null ? null : Claimant.fromJson(json["handoverSecurity"]),
//         status: json["status"],
//         modifiedDate: json["modifiedDate"],
//         modifiedBy: json["modifiedBy"],
//         depositorName: json["depositorName"],
//         claimantName: json["claimantName"],
//         locationName: json["locationName"],
//         entrySecurityName: json["entrySecurityName"],
//         handOverSecurityName: json["handOverSecurityName"],
//         depositorDepartmentName: json["depositorDepartmentName"],
//         claimantDepartmentName: json["claimantDepartmentName"],
//         location: json["location"] == null ? null : ClaimantDepartment.fromJson(json["location"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "slNo": slNo,
//         "inputDate": inputDate,
//         "locationRegion": locationRegion?.toJson(),
//         "typeOfAsset": typeOfAsset,
//         "typeOfArticle": typeOfArticle?.toJson(),
//         "foundDate": foundDate,
//         "foundLocation": foundLocation,
//         "additionalInformation": additionalInformation,
//         "quantity": quantity,
//         "color": color,
//         "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
//         "depositorDbEmp": depositorDbEmp,
//         "depositor": depositor?.toJson(),
//         "employeeId": employeeId,
//         "depositorDepartment": depositorDepartment?.toJson(),
//         "claimantDbEmp": claimantDbEmp,
//         "claimantConfirmByEmail": claimantConfirmByEmail,
//         "claimant": claimant?.toJson(),
//         "claimantNoSign": claimantNoSign,
//         "claimantEmployeeId": claimantEmployeeId,
//         "claimantDepartment": claimantDepartment?.toJson(),
//         "handoverDate": handoverDate,
//         "entrySecurity": entrySecurity?.toJson(),
//         "handoverSecurity": handoverSecurity?.toJson(),
//         "status": status,
//         "modifiedDate": modifiedDate,
//         "modifiedBy": modifiedBy,
//         "depositorName": depositorName,
//         "claimantName": claimantName,
//         "locationName": locationName,
//         "entrySecurityName": entrySecurityName,
//         "handOverSecurityName": handOverSecurityName,
//         "depositorDepartmentName": depositorDepartmentName,
//         "claimantDepartmentName": claimantDepartmentName,
//         "location": location?.toJson(),
//     };
// }

// class Claimant {
//     int? userId;
//     String? userName;
//     String? email;
//     String? firstName;
//     String? lastName;
//     String? phone;
//     List<Role>? roles;
//     List<RoleExtension>? roleExtensions;
//     List<dynamic>? notApprovedRoles;
//     List<dynamic>? notApprovedRoleExtensions;
//     String? name;
//     String? userStatus;

//     Claimant({
//         this.userId,
//         this.userName,
//         this.email,
//         this.firstName,
//         this.lastName,
//         this.phone,
//         this.roles,
//         this.roleExtensions,
//         this.notApprovedRoles,
//         this.notApprovedRoleExtensions,
//         this.name,
//         this.userStatus,
//     });

//     factory Claimant.fromJson(Map<String, dynamic> json) => Claimant(
//         userId: json["userId"],
//         userName: json["userName"],
//         email: json["email"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         phone: json["phone"],
//         roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
//         roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
//         notApprovedRoles: json["notApprovedRoles"] == null ? [] : List<dynamic>.from(json["notApprovedRoles"]!.map((x) => x)),
//         notApprovedRoleExtensions: json["notApprovedRoleExtensions"] == null ? [] : List<dynamic>.from(json["notApprovedRoleExtensions"]!.map((x) => x)),
//         name: json["name"],
//         userStatus: json["userStatus"],
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "userName": userName,
//         "email": email,
//         "firstName": firstName,
//         "lastName": lastName,
//         "phone": phone,
//         "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
//         "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
//         "notApprovedRoles": notApprovedRoles == null ? [] : List<dynamic>.from(notApprovedRoles!.map((x) => x)),
//         "notApprovedRoleExtensions": notApprovedRoleExtensions == null ? [] : List<dynamic>.from(notApprovedRoleExtensions!.map((x) => x)),
//         "name": name,
//         "userStatus": userStatus,
//     };
// }

// class RoleExtension {
//     int? roleExtensionId;
//     int? roleId;
//     String? displayName;
//     Area? area;
//     Filter? filter;
//     dynamic rootNodeId;
//     dynamic nodeId;
//     dynamic accessRight;

//     RoleExtension({
//         this.roleExtensionId,
//         this.roleId,
//         this.displayName,
//         this.area,
//         this.filter,
//         this.rootNodeId,
//         this.nodeId,
//         this.accessRight,
//     });

//     factory RoleExtension.fromJson(Map<String, dynamic> json) => RoleExtension(
//         roleExtensionId: json["roleExtensionId"],
//         roleId: json["roleId"],
//         displayName: json["displayName"],
//         area: areaValues.map[json["area"]]!,
//         filter: filterValues.map[json["filter"]]!,
//         rootNodeId: json["rootNodeId"],
//         nodeId: json["nodeId"],
//         accessRight: json["accessRight"],
//     );

//     Map<String, dynamic> toJson() => {
//         "roleExtensionId": roleExtensionId,
//         "roleId": roleId,
//         "displayName": displayName,
//         "area": areaValues.reverse[area],
//         "filter": filterValues.reverse[filter],
//         "rootNodeId": rootNodeId,
//         "nodeId": nodeId,
//         "accessRight": accessRight,
//     };
// }

// enum Area { SOURCE_SYSTEM, CATEGORY }

// final areaValues = EnumValues({
//     "Category": Area.CATEGORY,
//     "SourceSystem": Area.SOURCE_SYSTEM
// });

// enum Filter { DB_ATOM, DEFAULT }

// final filterValues = EnumValues({
//     "DB_ATOM": Filter.DB_ATOM,
//     "Default": Filter.DEFAULT
// });

// class Role {
//     int? roleId;
//     Application? application;
//     String? roleName;
//     List<RoleExtension>? roleExtensions;
//     String? name;

//     Role({
//         this.roleId,
//         this.application,
//         this.roleName,
//         this.roleExtensions,
//         this.name,
//     });

//     factory Role.fromJson(Map<String, dynamic> json) => Role(
//         roleId: json["roleId"],
//         application: applicationValues.map[json["application"]]!,
//         roleName: json["roleName"],
//         roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "roleId": roleId,
//         "application": applicationValues.reverse[application],
//         "roleName": roleName,
//         "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
//         "name": name,
//     };
// }

// enum Application { TRACKING1, DB_ATOM }

// final applicationValues = EnumValues({
//     "DB_ATOM": Application.DB_ATOM,
//     "Tracking1": Application.TRACKING1
// });

// class ClaimantDepartment {
//     int? id;
//     String? name;

//     ClaimantDepartment({
//         this.id,
//         this.name,
//     });

//     factory ClaimantDepartment.fromJson(Map<String, dynamic> json) => ClaimantDepartment(
//         id: json["id"],
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//     };
// }

// class FoundImage {
//     int? id;
//     String? ownerName;
//     String? contentType;
//     int? uploadDate;
//     int? foundId;
//     String? title;
//     int? fileSize;
//     String? imageContent;

//     FoundImage({
//         this.id,
//         this.ownerName,
//         this.contentType,
//         this.uploadDate,
//         this.foundId,
//         this.title,
//         this.fileSize,
//         this.imageContent,
//     });

//     factory FoundImage.fromJson(Map<String, dynamic> json) => FoundImage(
//         id: json["id"],
//         ownerName: json["ownerName"],
//         contentType: json["contentType"],
//         uploadDate: json["uploadDate"],
//         foundId: json["foundId"],
//         title: json["title"],
//         fileSize: json["fileSize"],
//         imageContent: json["imageContent"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "ownerName": ownerName,
//         "contentType": contentType,
//         "uploadDate": uploadDate,
//         "foundId": foundId,
//         "title": title,
//         "fileSize": fileSize,
//         "imageContent": imageContent,
//     };
// }

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         reverseMap = map.map((k, v) => MapEntry(v, k));
//         return reverseMap;
//     }
// }
// To parse this JSON data, do
//
//     final foundListArticleDetails = foundListArticleDetailsFromJson(jsonString);

import 'dart:convert';

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

class RoleExtension {
    int? roleExtensionId;
    int? roleId;
    String? displayName;
    Area? area;
    Filter? filter;
    dynamic rootNodeId;
    dynamic nodeId;
    dynamic accessRight;

    RoleExtension({
        this.roleExtensionId,
        this.roleId,
        this.displayName,
        this.area,
        this.filter,
        this.rootNodeId,
        this.nodeId,
        this.accessRight,
    });

    factory RoleExtension.fromJson(Map<String, dynamic> json) => RoleExtension(
        roleExtensionId: json["roleExtensionId"],
        roleId: json["roleId"],
        displayName: json["displayName"],
        area: areaValues.map[json["area"]]!,
        filter: filterValues.map[json["filter"]]!,
        rootNodeId: json["rootNodeId"],
        nodeId: json["nodeId"],
        accessRight: json["accessRight"],
    );

    Map<String, dynamic> toJson() => {
        "roleExtensionId": roleExtensionId,
        "roleId": roleId,
        "displayName": displayName,
        "area": areaValues.reverse[area],
        "filter": filterValues.reverse[filter],
        "rootNodeId": rootNodeId,
        "nodeId": nodeId,
        "accessRight": accessRight,
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

class Role {
    int? roleId;
    Application? application;
    String? roleName;
    List<RoleExtension>? roleExtensions;
    String? name;

    Role({
        this.roleId,
        this.application,
        this.roleName,
        this.roleExtensions,
        this.name,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json["roleId"],
        application: applicationValues.map[json["application"]]!,
        roleName: json["roleName"],
        roleExtensions: json["roleExtensions"] == null ? [] : List<RoleExtension>.from(json["roleExtensions"]!.map((x) => RoleExtension.fromJson(x))),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "application": applicationValues.reverse[application],
        "roleName": roleName,
        "roleExtensions": roleExtensions == null ? [] : List<dynamic>.from(roleExtensions!.map((x) => x.toJson())),
        "name": name,
    };
}

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


