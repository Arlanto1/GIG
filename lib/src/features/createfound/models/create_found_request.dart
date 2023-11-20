// To parse this JSON data, do
//
//     final foundListArticleDetails = foundListArticleDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/models/image_content.dart';

import '../../../models/organisation.dart';

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
  Organisation? typeOfArticle;
  String? foundLocation;
  String? additionalInformation;
  int? quantity;
  String? color;
  bool? depositorDbEmp;
  int? inputDate;
  int? foundDate;
  int? handoverDate;
  User? entrySecurity;
  Organisation? location;
  User? depositor;
  Organisation? depositorDepartment;
  List<ImageContent>? images;
  String? depositorName;
  int? status;
  String? employeeId;
  User? claimant;
  String? claimantName;
  Organisation? claimantDepartment;
  User? handoverSecurity;
  bool? claimantDbEmp;
  bool? claimantNoSign;
  bool? claimantConfirmByEmail;
  int? claimantEmployeeId;

  // ImageContent? claimantSign;

  Found({
    this.slNo,
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
    // this.claimantSign,
    this.location,
    this.depositor,
    this.images,
    this.status,
    this.depositorDepartment,
    this.depositorName,
    this.claimantName,
    this.employeeId,
    this.claimant,
    this.claimantDepartment,
    this.handoverSecurity,
    this.claimantDbEmp,
    this.claimantNoSign,
    this.handoverDate,
    this.claimantConfirmByEmail,
  });

  factory Found.fromJson(Map<String, dynamic> json) => Found(
        slNo: json["slNo"],
        eventProtection: json["eventProtection"],
        id: json["id"],
        typeOfAsset: json["typeOfAsset"],
        typeOfArticle: json["typeOfArticle"] == null
            ? null
            : Organisation.fromJson(json["typeOfArticle"]),
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
            : Organisation.fromJson(json["location"]),
        depositor:
            json["depositor"] == null ? null : User.fromJson(json["depositor"]),
        images: json["images"] == null
            ? []
            : List<ImageContent>.from(
                json["images"]!.map((x) => ImageContent.fromJson(x))),
        depositorDepartment: json["depositorDepartment"] == null
            ? null
            : Organisation.fromJson(json["depositorDepartment"]),
        status: json["status"],
        depositorName: json["depositorName"],
        claimantName: json["claimantName"],
        employeeId: json["employeeId"],
        claimant:
            json["claimant"] == null ? null : User.fromJson(json["claimant"]),
        claimantDepartment: json["claimantDepartment"] == null
            ? null
            : Organisation.fromJson(json["claimantDepartment"]),
        // claimantSign: json["claimantSign"] == null
        //     ? null
        //     : ImageContent.fromJson(json["claimantSign"]),
        handoverSecurity: json["handoverSecurity"] == null
            ? null
            : User.fromJson(json["handoverSecurity"]),
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
        "claimantName": claimantName,
        "employeeId": employeeId,
        "claimant": claimant?.toJson(),
        // "claimantSign": claimantSign?.toJson(),
        "claimantDepartment": claimantDepartment?.toJson(),
        "handoverSecurity": handoverSecurity?.toJson(),
        "claimantConfirmByEmail": claimantConfirmByEmail
      };
}
