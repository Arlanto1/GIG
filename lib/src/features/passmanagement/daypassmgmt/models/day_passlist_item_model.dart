// To parse this JSON data, do
//
//     final passListItemResponse = passListItemResponseFromJson(jsonString);

import 'dart:convert';

DayPassListItemResponse passListItemResponseFromJson(String str) => DayPassListItemResponse.fromJson(json.decode(str));

String passListItemResponseToJson(DayPassListItemResponse data) => json.encode(data.toJson());

class DayPassListItemResponse {
    int? id;
    String? slNo;
    int? inputDate;
    CompanyType? location;
    CompanyType? locationRegion;
    List<CompanyType>? entities;
    int? status;
    int? modifiedDate;
    String? modifiedBy;
    List<dynamic>? history;
    int? passType;
    CompanyType? companyType;
    String? companyName;
    String? employeeName;
    String? employeeId;
    String? email;
    bool? exceptionalApproval;
    PassInfo? passInfo;
    int? endTime;
    List<dynamic>? evidenceDocuments;
    bool? escortedByHost;
    bool? idValidated;
    int? category;
    int? passIssuedOn;
    String? hostName;
    String? entrySecurityName;
    String? passNo;
    String? handOverSecurityName;
    String? mifareNo;

    DayPassListItemResponse({
        this.id,
        this.slNo,
        this.inputDate,
        this.location,
        this.locationRegion,
        this.entities,
        this.status,
        this.modifiedDate,
        this.modifiedBy,
        this.history,
        this.passType,
        this.companyType,
        this.companyName,
        this.employeeName,
        this.employeeId,
        this.email,
        this.exceptionalApproval,
        this.passInfo,
        this.endTime,
        this.evidenceDocuments,
        this.escortedByHost,
        this.idValidated,
        this.category,
        this.passIssuedOn,
        this.hostName,
        this.entrySecurityName,
        this.passNo,
        this.handOverSecurityName,
        this.mifareNo,
    });

    factory DayPassListItemResponse.fromJson(Map<String, dynamic> json) => DayPassListItemResponse(
        id: json["id"],
        slNo: json["slNo"],
        inputDate: json["inputDate"],
        location: json["location"] == null ? null : CompanyType.fromJson(json["location"]),
        locationRegion: json["locationRegion"] == null ? null : CompanyType.fromJson(json["locationRegion"]),
        entities: json["entities"] == null ? [] : List<CompanyType>.from(json["entities"]!.map((x) => CompanyType.fromJson(x))),
        status: json["status"],
        modifiedDate: json["modifiedDate"],
        modifiedBy: json["modifiedBy"],
        history: json["history"] == null ? [] : List<dynamic>.from(json["history"]!.map((x) => x)),
        passType: json["passType"],
        companyType: json["companyType"] == null ? null : CompanyType.fromJson(json["companyType"]),
        companyName: json["companyName"],
        employeeName: json["employeeName"],
        employeeId: json["employeeId"],
        email: json["email"],
        exceptionalApproval: json["exceptionalApproval"],
        passInfo: json["passInfo"] == null ? null : PassInfo.fromJson(json["passInfo"]),
        endTime: json["endTime"],
        evidenceDocuments: json["evidenceDocuments"] == null ? [] : List<dynamic>.from(json["evidenceDocuments"]!.map((x) => x)),
        escortedByHost: json["escortedByHost"],
        idValidated: json["idValidated"],
        category: json["category"],
        passIssuedOn: json["passIssuedOn"],
        hostName: json["hostName"],
        entrySecurityName: json["entrySecurityName"],
        passNo: json["passNo"],
        handOverSecurityName: json["handOverSecurityName"],
        mifareNo: json["mifareNo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "slNo": slNo,
        "inputDate": inputDate,
        "location": location?.toJson(),
        "locationRegion": locationRegion?.toJson(),
        "entities": entities == null ? [] : List<dynamic>.from(entities!.map((x) => x.toJson())),
        "status": status,
        "modifiedDate": modifiedDate,
        "modifiedBy": modifiedBy,
        "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x)),
        "passType": passType,
        "companyType": companyType?.toJson(),
        "companyName": companyName,
        "employeeName": employeeName,
        "employeeId": employeeId,
        "email": email,
        "exceptionalApproval": exceptionalApproval,
        "passInfo": passInfo?.toJson(),
        "endTime": endTime,
        "evidenceDocuments": evidenceDocuments == null ? [] : List<dynamic>.from(evidenceDocuments!.map((x) => x)),
        "escortedByHost": escortedByHost,
        "idValidated": idValidated,
        "category": category,
        "passIssuedOn": passIssuedOn,
        "hostName": hostName,
        "entrySecurityName": entrySecurityName,
        "passNo": passNo,
        "handOverSecurityName": handOverSecurityName,
        "mifareNo": mifareNo,
    };
}

class CompanyType {
    int? id;
    String? name;

    CompanyType({
        this.id,
        this.name,
    });

    factory CompanyType.fromJson(Map<String, dynamic> json) => CompanyType(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class PassInfo {
    int? id;
    int? passType;
    String? passNo;
    String? mifareNo;
    int? expiryDate;
    CompanyType? location;
    CompanyType? region;
    CompanyType? entity;
    bool? dws;
    dynamic remarks;
    dynamic status;

    PassInfo({
        this.id,
        this.passType,
        this.passNo,
        this.mifareNo,
        this.expiryDate,
        this.location,
        this.region,
        this.entity,
        this.dws,
        this.remarks,
        this.status,
    });

    factory PassInfo.fromJson(Map<String, dynamic> json) => PassInfo(
        id: json["id"],
        passType: json["passType"],
        passNo: json["passNo"],
        mifareNo: json["mifareNo"],
        expiryDate: json["expiryDate"],
        location: json["location"] == null ? null : CompanyType.fromJson(json["location"]),
        region: json["region"] == null ? null : CompanyType.fromJson(json["region"]),
        entity: json["entity"] == null ? null : CompanyType.fromJson(json["entity"]),
        dws: json["dws"],
        remarks: json["remarks"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "passType": passType,
        "passNo": passNo,
        "mifareNo": mifareNo,
        "expiryDate": expiryDate,
        "location": location?.toJson(),
        "region": region?.toJson(),
        "entity": entity?.toJson(),
        "dws": dws,
        "remarks": remarks,
        "status": status,
    };
}
