// To parse this JSON data, do
//
//     final foundListArticleDetails = foundListArticleDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:db_atom/src/features/createfound/models/user.dart';

CreateFoundRequestBody foundListArticleDetailsFromJson(String str) =>
    CreateFoundRequestBody.fromJson(json.decode(str));

String foundListArticleDetailsToJson(CreateFoundRequestBody data) =>
    json.encode(data.toJson());

class CreateFoundRequestBody {
  Found? found;

  CreateFoundRequestBody({
    this.found,
  });

  factory CreateFoundRequestBody.fromJson(Map<String, dynamic> json) =>
      CreateFoundRequestBody(
        found: json["found"] == null ? null : Found.fromJson(json["found"]),
      );

  Map<String, dynamic> toJson() => {
        "found": found?.toJson(),
      };
}

class Found {
  String? slNo;
  int? eventProtection;
  int? typeOfAsset;
  int? id;
  TypeOfArticle? typeOfArticle;
  String? foundLocation;
  String? additionalInformation;
  int? quantity;
  String? color;
  bool? depositorDbEmp;
  int? inputDate;
  int? foundDate;
  int? handoverDate;
  User? entrySecurity;
  CreateLocation? location;
  Depositor? depositor;
  DepositorDepartment? depositorDepartment;
  List<CreateImage>? images;
  String? depositorName;
  int? status;
  String? employeeId;
  CreateClaimant? claimant;
  CreateClaimantDepartment? claimantDepartment;
  CreateHandoverSecurity? handoverSecurity;
  bool? claimantDbEmp;
  bool? claimantNoSign;
  bool? claimantConfirmByEmail;
  int? claimantEmployeeId;

  Found(
      {this.slNo,
      this.eventProtection,
      this.id,
      this.typeOfAsset,
      this.typeOfArticle,
      this.foundLocation,
      this.additionalInformation,
      this.quantity,
      this.claimantEmployeeId,
      this.color,
      this.depositorDbEmp,
      this.inputDate,
      this.foundDate,
      this.entrySecurity,
      this.location,
      this.depositor,
      this.images,
      this.status,
      this.depositorDepartment,
      this.depositorName,
      this.employeeId,
      this.claimant,
      this.claimantDepartment,
      this.handoverSecurity,
      this.claimantDbEmp,
      this.claimantNoSign,
      this.handoverDate,
      this.claimantConfirmByEmail});

  factory Found.fromJson(Map<String, dynamic> json) => Found(
        slNo: json["slNo"],
        eventProtection: json["eventProtection"],
        id: json["id"],
        typeOfAsset: json["typeOfAsset"],
        typeOfArticle: json["typeOfArticle"] == null
            ? null
            : TypeOfArticle.fromJson(json["typeOfArticle"]),
        foundLocation: json["foundLocation"],
        additionalInformation: json["additionalInformation"],
        quantity: json["quantity"],
        claimantEmployeeId: json["claimantEmployeeId"],
        color: json["color"],
        depositorDbEmp: json["depositorDbEmp"],
        claimantConfirmByEmail: json["claimantConfirmByEmail"],
        claimantDbEmp: json["claimantDbEmp"],
        claimantNoSign: json["claimantNoSign"],
        inputDate: json["inputDate"],
        foundDate: json["handoverDate"],
        handoverDate: json["handoverDate"],
        entrySecurity: json["entrySecurity"] == null
            ? null
            : User.fromJson(json["entrySecurity"]),
        location: json["location"] == null
            ? null
            : CreateLocation.fromJson(json["location"]),
        depositor: json["depositor"] == null
            ? null
            : Depositor.fromJson(json["depositor"]),
        images: json["images"] == null
            ? []
            : List<CreateImage>.from(
                json["images"]!.map((x) => CreateImage.fromJson(x))),
        depositorDepartment: json["depositorDepartment"] == null
            ? null
            : DepositorDepartment.fromJson(json["depositorDepartment"]),
        status: json["status"],
        depositorName: json["depositorName"],
        employeeId: json["employeeId"],
        claimant: json["claimant"] == null
            ? null
            : CreateClaimant.fromJson(json["claimant"]),
        claimantDepartment: json["claimantDepartment"] == null
            ? null
            : CreateClaimantDepartment.fromJson(json["claimantDepartment"]),
        handoverSecurity: json["handoverSecurity"] == null
            ? null
            : CreateHandoverSecurity.fromJson(json["handoverSecurity"]),
      );

  Map<String, dynamic> toJson() => {
        "slNo": slNo,
        "eventProtection": eventProtection,
        "id": id,
        "typeOfAsset": typeOfAsset,
        "typeOfArticle": typeOfArticle?.toJson(),
        "foundLocation": foundLocation,
        "additionalInformation": additionalInformation,
        "quantity": quantity,
        "color": color,
        "depositorDbEmp": depositorDbEmp,
        "claimantDbEmp": claimantDbEmp,
        "claimantNoSign": claimantNoSign,
        "claimantEmployeeId": claimantEmployeeId,
        "inputDate": inputDate,
        "foundDate": foundDate,
        "handoverDate": handoverDate,
        "entrySecurity": entrySecurity?.toJson(),
        "location": location?.toJson(),
        "depositor": depositor?.toJson(),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "depositorDepartment": depositorDepartment?.toJson(),
        "status": status,
        "depositorName": depositorName,
        "employeeId": employeeId,
        "claimant": claimant?.toJson(),
        "claimantDepartment": claimantDepartment?.toJson(),
        "handoverSecurity": handoverSecurity?.toJson(),
        "claimantConfirmByEmail": claimantConfirmByEmail
      };
}

class CreateHandoverSecurity {
  int? userId;

  CreateHandoverSecurity({
    this.userId,
  });

  factory CreateHandoverSecurity.fromJson(Map<String, dynamic> json) =>
      CreateHandoverSecurity(
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
      };
}

class CreateClaimantDepartment {
  int? id;
  String? name;

  CreateClaimantDepartment({
    this.id,
    this.name,
  });

  factory CreateClaimantDepartment.fromJson(Map<String, dynamic> json) =>
      CreateClaimantDepartment(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class CreateClaimant {
  int? userId;
  String? userName;
  String? email;
  String? firstName;
  String? lastName;

  CreateClaimant({
    this.userId,
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
  });

  factory CreateClaimant.fromJson(Map<String, dynamic> json) => CreateClaimant(
        userId: json["userId"],
        userName: json["userName"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
      };
}

class DepositorDepartment {
  int? id;

  DepositorDepartment({
    this.id,
  });

  factory DepositorDepartment.fromJson(Map<String, dynamic> json) =>
      DepositorDepartment(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Depositor {
  int? userId;
  String? userName;
  String? email;
  String? firstName;
  String? lastName;

  Depositor({
    this.userId,
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
  });

  factory Depositor.fromJson(Map<String, dynamic> json) => Depositor(
        userId: json["userId"],
        userName: json["userName"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
      };
}

class CreateImage {
  String? ownerName;
  String? contentType;
  String? title;
  int? fileSize;
  String? imageContent;

  CreateImage({
    this.ownerName,
    this.contentType,
    this.title,
    this.fileSize,
    this.imageContent,
  });

  factory CreateImage.fromJson(Map<String, dynamic> json) => CreateImage(
        ownerName: json["ownerName"],
        contentType: json["contentType"],
        title: json["title"],
        fileSize: json["fileSize"],
        imageContent: json["imageContent"],
      );

  Map<String, dynamic> toJson() => {
        "ownerName": ownerName,
        "contentType": contentType,
        "title": title,
        "fileSize": fileSize,
        "imageContent": imageContent,
      };
}

class CreateLocation {
  int? id;
  String? name;

  CreateLocation({
    this.id,
    this.name,
  });

  factory CreateLocation.fromJson(Map<String, dynamic> json) => CreateLocation(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class TypeOfArticle {
  int? id;

  TypeOfArticle({
    this.id,
  });

  factory TypeOfArticle.fromJson(Map<String, dynamic> json) => TypeOfArticle(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
