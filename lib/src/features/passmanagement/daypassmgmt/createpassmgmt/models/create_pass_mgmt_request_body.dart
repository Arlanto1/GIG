// To parse this JSON data, do
//
//     final createPassMgmtBody = createPassMgmtBodyFromJson(jsonString);

import 'dart:convert';

import 'package:db_atom/src/features/createfound/models/create_found_request.dart';

import '../../../../createfound/models/user.dart';

CreatePassMgmtBody createPassMgmtBodyFromJson(String str) => CreatePassMgmtBody.fromJson(json.decode(str));

String createPassMgmtBodyToJson(CreatePassMgmtBody data) => json.encode(data.toJson());

class CreatePassMgmtBody {
    PassManagement? passManagement;

    CreatePassMgmtBody({
        this.passManagement,
    });

    factory CreatePassMgmtBody.fromJson(Map<String, dynamic> json) => CreatePassMgmtBody(
        passManagement: json["passManagement"] == null ? null : PassManagement.fromJson(json["passManagement"]),
    );

    Map<String, dynamic> toJson() => {
        "passManagement": passManagement?.toJson(),
    };
}

class PassManagement {
    int? id;
    String? slNo;
    String? inputDate;
    PassMgmtLocation? location;
    PassMgmtLocation? dayPassReason;
    PassMgmtLocationregion? locationRegion;
    List<PassMgmtTypEntity>? entities;
    int? status;
    int? updatedStatus;
    List<dynamic>? history;
    int? passType;
    PassCompanyType? companyType;
    String? companyName;
    String? employeeName;
    String? employeeId;
    String? email;
    String? hostEmployeeId;
    bool? exceptionalApproval;
    PassmgmtInfo? passInfo;
    String? endTime;
    List<dynamic>? evidenceDocuments;
    String? contactNo;
    bool? escortedByHost;
    String? escortedBy;
    String? escortedEmployeeId;
    String? visitorComingFrom;
    bool? idValidated;
    int? idValidationType;
    String? visitingPurpose;
    int? category;
    String? passIssuedOn;
    String? hostName;
    String? entrySecurityName;
    String? escortedByName;
    String? passNo;
    String? handOverSecurityName;
    String? mifareNo;
    List<CreateImage>? images;
    PassDept? department;
    User? host;
    String? visitorName;
    List<CreateImage>? visitorImage;
    PassDept? visitingDepartment;
    String? startTime;
    PassEntrySecurity? entrySecurity;
    
        PassManagement({
        this.id,
        this.slNo,
        this.inputDate,
        this.location,
        this.locationRegion,
        this.entities,
        this.status,
        this.history,
        this.passType,
        this.companyType,
        this.companyName,
        this.employeeName,
        this.employeeId,
        this.email,
        this.hostEmployeeId,
        this.exceptionalApproval,
        this.passInfo,
        this.endTime,
        this.evidenceDocuments,
        this.contactNo,
        this.escortedByHost,
        this.escortedBy,
        this.escortedEmployeeId,
        this.visitorComingFrom,
        this.idValidated,
        this.idValidationType,
        this.visitingPurpose,
        this.category,
        this.passIssuedOn,
        this.hostName,
        this.entrySecurityName,
        this.escortedByName,
        this.passNo,
        this.handOverSecurityName,
        this.mifareNo,
        this.images,
        this.department,
        this.host,
        this.visitorName,
        this.visitorImage,
        this.visitingDepartment,
        this.dayPassReason,
        this.startTime,
        this.updatedStatus,
        this.entrySecurity,
    });

    factory PassManagement.fromJson(Map<String, dynamic> json) => PassManagement(
        id: json["id"],
        slNo: json["slNo"],
        host: json["host"] == null ? null : User.fromJson(json["host"]),
        inputDate: json["inputDate"],
        location: json["location"] == null ? null : PassMgmtLocation.fromJson(json["location"]),
        dayPassReason: json["dayPassReason"] == null ? null : PassMgmtLocation.fromJson(json["dayPassReason"]),
        locationRegion: json["locationRegion"] == null ? null : PassMgmtLocationregion.fromJson(json["locationRegion"]),
        entities: json["entities"] == null ? [] : List<PassMgmtTypEntity>.from(json["entities"]!.map((x) => PassMgmtTypEntity.fromJson(x))),
        status: json["status"],
        updatedStatus: json["updatedStatus"],
        history: json["history"] == null ? [] : List<dynamic>.from(json["history"]!.map((x) => x)),
        passType: json["passType"],
        companyType: json["companyType"] == null ? null : PassCompanyType.fromJson(json["companyType"]),
        companyName: json["companyName"],
        employeeName: json["employeeName"],
        employeeId: json["employeeId"],
        email: json["email"],
        hostEmployeeId: json["hostEmployeeId"],
        exceptionalApproval: json["exceptionalApproval"],
        passInfo: json["passInfo"] == null ? null : PassmgmtInfo.fromJson(json["passInfo"]),
        endTime: json["endTime"],
        evidenceDocuments: json["evidenceDocuments"] == null ? [] : List<dynamic>.from(json["evidenceDocuments"]!.map((x) => x)),
        contactNo: json["contactNo"],
        escortedByHost: json["escortedByHost"],
        escortedBy: json["escortedBy"],
        escortedEmployeeId: json["escortedEmployeeId"],
        visitorComingFrom: json["visitorComingFrom"],
        idValidated: json["idValidated"],
        idValidationType: json["idValidationType"],
        visitingPurpose: json["visitingPurpose"],
        category: json["category"],
        passIssuedOn: json["passIssuedOn"],
        hostName: json["hostName"],
        entrySecurityName: json["entrySecurityName"],
        escortedByName: json["escortedByName"],
        passNo: json["passNo"],
        handOverSecurityName: json["handOverSecurityName"],
        mifareNo: json["mifareNo"],
        images: json["images"] == null
            ? []
            : List<CreateImage>.from(
                json["images"]!.map((x) => CreateImage.fromJson(x))),
         department: json["department"] == null ? null : PassDept.fromJson(json["department"]),
         visitingDepartment: json["visitingDepartment"] == null ? null : PassDept.fromJson(json["visitingDepartment"]),
         visitorName: json["visitorName"],
          visitorImage: json["visitorImage"] == null
            ? []
            : List<CreateImage>.from(
                json["visitorImage"]!.map((x) => CreateImage.fromJson(x))),
         startTime: json["startTime"],   
          entrySecurity: json["entrySecurity"] == null
            ? null
            : PassEntrySecurity.fromJson(json["entrySecurity"]),      
                      
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "slNo": slNo,
        "host": host?.toJson(),
        "inputDate": inputDate,
        "location": location?.toJson(),
        "locationRegion": locationRegion?.toJson(),
        "entities": entities == null ? [] : List<dynamic>.from(entities!.map((x) => x.toJson())),
        "status": status,
        "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x)),
        "passType": passType,
        "companyType": companyType?.toJson(),
        "companyName": companyName,
        "employeeName": employeeName,
        "employeeId": employeeId,
        "email": email,
        "hostEmployeeId": hostEmployeeId,
        "exceptionalApproval": exceptionalApproval,
        "passInfo": passInfo?.toJson(),
        "endTime": endTime,
        "evidenceDocuments": evidenceDocuments == null ? [] : List<dynamic>.from(evidenceDocuments!.map((x) => x)),
        "contactNo": contactNo,
        "escortedByHost": escortedByHost,
        "escortedBy": escortedBy,
        "escortedEmployeeId": escortedEmployeeId,
        "visitorComingFrom": visitorComingFrom,
        "idValidated": idValidated,
        "idValidationType": idValidationType,
        "visitingPurpose": visitingPurpose,
        "category": category,
        "passIssuedOn": passIssuedOn,
        "hostName": hostName,
        "entrySecurityName": entrySecurityName,
        "escortedByName": escortedByName,
        "passNo": passNo,
        "handOverSecurityName": handOverSecurityName,
        "mifareNo": mifareNo,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "department": department?.toJson(),
        "visitorName": visitorName,
        "visitorImage" :  visitorImage == null
            ? []
            : List<dynamic>.from(visitorImage!.map((x) => x.toJson())),
        "visitingDepartment": visitingDepartment?.toJson(), 
        "dayPassReason": dayPassReason?.toJson(),  
        "startTime" :startTime,
        "updatedStatus": updatedStatus,
        "entrySecurity": entrySecurity?.toJson(),
            
    };
}
class PassEntrySecurity {
  int? userId;

  PassEntrySecurity({
    this.userId,
  });

  factory PassEntrySecurity.fromJson(Map<String, dynamic> json) => PassEntrySecurity(
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
      };
}
class PassHost {
    int? id;
    String? name;
    String? email;
    String? firstName;
    String? lastName;
   

    PassHost({
        this.id,
        this.email,
        this.firstName,
        this.lastName,
        this.name,
    });

    factory PassHost.fromJson(Map<String, dynamic> json) => PassHost(
        id: json["id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "name": name,
    };
}




class PassCompanyType {
    int? id;
    String? name;

    PassCompanyType({
        this.id,
        this.name,
    });

    factory PassCompanyType.fromJson(Map<String, dynamic> json) => PassCompanyType(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
class PassMgmtLocation {
    int? id;
    String? name;

    PassMgmtLocation({
        this.id,
        this.name,
    });

    factory PassMgmtLocation.fromJson(Map<String, dynamic> json) => PassMgmtLocation(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
class PassMgmtLocationregion {
    int? id;
    String? name;

    PassMgmtLocationregion({
        this.id,
        this.name,
    });

    factory PassMgmtLocationregion.fromJson(Map<String, dynamic> json) => PassMgmtLocationregion(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
class PassMgmtTypEntity {
    int? id;
    String? name;

    PassMgmtTypEntity({
        this.id,
        this.name,
    });

    factory PassMgmtTypEntity.fromJson(Map<String, dynamic> json) => PassMgmtTypEntity(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class PassDept {
    int? id;
    String? name;

    PassDept({
        this.id,
        this.name,
    });

    factory PassDept.fromJson(Map<String, dynamic> json) => PassDept(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}


class PassmgmtInfo {
    int? id;
    int? passType;
    String? passNo;
    String? mifareNo;
    String? expiryDate;
    bool? dws;
    int? status;

    PassmgmtInfo({
        this.id,
        this.passType,
        this.passNo,
        this.mifareNo,
        this.expiryDate,
        this.dws,
        this.status,
    });

    factory PassmgmtInfo.fromJson(Map<String, dynamic> json) => PassmgmtInfo(
        id: json["id"],
        passType: json["passType"],
        passNo: json["passNo"],
        mifareNo: json["mifareNo"],
        expiryDate: json["expiryDate"],
        dws: json["dws"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "passType": passType,
        "passNo": passNo,
        "mifareNo": mifareNo,
        "expiryDate": expiryDate,
        "dws": dws,
        "status": status,
    };
}
