// // To parse this JSON data, do
// //
// //     final createFoundRequestBody = createFoundRequestBodyFromJson(jsonString);

// import 'dart:convert';

// CreateFoundRequestBody createFoundRequestBodyFromJson(String str) =>
//     CreateFoundRequestBody.fromJson(json.decode(str));

// String createFoundRequestBodyToJson(CreateFoundRequestBody data) => json.encode(data.toJson());

// class CreateFoundRequestBody {
//   Found? found;

//   CreateFoundRequestBody({
//     this.found,
//   });

//   factory CreateFoundRequestBody.fromJson(Map<String, dynamic> json) => CreateFoundRequestBody(
//         found: json["found"] == null ? null : Found.fromJson(json["found"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "found": found?.toJson(),
//       };
// }

// class Found {
//   int? id;
//   int? typeOfAsset;
//   Location? typeOfArticle;
//   String? foundLocation;
//   String? additionalInformation;
//   int? quantity;
//   String? color;
//   bool? depositorDbEmp;
//   DateTime? inputDate;
//   DateTime? foundDate;
//   Depositor? entrySecurity;
//   Location? location;
//   Depositor? depositor;
//   int? status;

//   Found({
//     this.id,
//     this.typeOfAsset,
//     this.typeOfArticle,
//     this.foundLocation,
//     this.additionalInformation,
//     this.quantity,
//     this.color,
//     this.depositorDbEmp,
//     this.inputDate,
//     this.foundDate,
//     this.entrySecurity,
//     this.location,
//     this.depositor,
//     this.status,
//   });

//   factory Found.fromJson(Map<String, dynamic> json) => Found(
//         id: json["id"],
//         typeOfAsset: json["typeOfAsset"],
//         typeOfArticle:
//             json["typeOfArticle"] == null ? null : Location.fromJson(json["typeOfArticle"]),
//         foundLocation: json["foundLocation"],
//         additionalInformation: json["additionalInformation"],
//         quantity: json["quantity"],
//         color: json["color"],
//         depositorDbEmp: json["depositorDbEmp"],
//         inputDate: json["inputDate"] == null ? null : DateTime.parse(json["inputDate"]),
//         foundDate: json["foundDate"] == null ? null : DateTime.parse(json["foundDate"]),
//         entrySecurity:
//             json["entrySecurity"] == null ? null : Depositor.fromJson(json["entrySecurity"]),
//         location: json["location"] == null ? null : Location.fromJson(json["location"]),
//         depositor: json["depositor"] == null ? null : Depositor.fromJson(json["depositor"]),
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "typeOfAsset": typeOfAsset,
//         "typeOfArticle": typeOfArticle?.toJson(),
//         "foundLocation": foundLocation,
//         "additionalInformation": additionalInformation,
//         "quantity": quantity,
//         "color": color,
//         "depositorDbEmp": depositorDbEmp,
//         "inputDate": inputDate?.toIso8601String(),
//         "foundDate": foundDate?.toIso8601String(),
//         "entrySecurity": entrySecurity?.toJson(),
//         "location": location?.toJson(),
//         "depositor": depositor?.toJson(),
//         "status": status,
//       };
// }

// class Depositor {
//   int? userId;

//   Depositor({
//     this.userId,
//   });

//   factory Depositor.fromJson(Map<String, dynamic> json) => Depositor(
//         userId: json["userId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//       };
// }

// class Location {
//   int? id;

//   Location({
//     this.id,
//   });

//   factory Location.fromJson(Map<String, dynamic> json) => Location(
//         id: json["id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//       };
// }
// To parse this JSON data, do
//
//     final createFoundRequestBody = createFoundRequestBodyFromJson(jsonString);

// import 'dart:convert';

// CreateFoundRequestBody createFoundRequestBodyFromJson(String str) => CreateFoundRequestBody.fromJson(json.decode(str));

// String createFoundRequestBodyToJson(CreateFoundRequestBody data) => json.encode(data.toJson());

// class CreateFoundRequestBody {
//     Found? found;

//     CreateFoundRequestBody({
//         this.found,
//     });

//     factory CreateFoundRequestBody.fromJson(Map<String, dynamic> json) => CreateFoundRequestBody(
//         found: json["found"] == null ? null : Found.fromJson(json["found"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "found": found?.toJson(),
//     };
// }

// class Found {
//     String? slNo;
//     int? typeOfAsset;
//     Location? typeOfArticle;
//     String? foundLocation;
//     String? additionalInformation;
//     int? quantity;
//     String? color;
//     bool? depositorDbEmp;
//    // DateTime? inputDate;
//    // DateTime? foundDate;
//     String? inputDate;
//     String? foundDate;
//     Depositor? entrySecurity;
//     Location? location;
//     Depositor? depositor;
//     int? status;

//     Found({
//         this.slNo,
//         this.typeOfAsset,
//         this.typeOfArticle,
//         this.foundLocation,
//         this.additionalInformation,
//         this.quantity,
//         this.color,
//         this.depositorDbEmp,
//         this.inputDate,
//         this.foundDate,
//         this.entrySecurity,
//         this.location,
//         this.depositor,
//         this.status,
//     });

//     factory Found.fromJson(Map<String, dynamic> json) => Found(
//         slNo: json["slNo"],
//         typeOfAsset: json["typeOfAsset"],
//         typeOfArticle: json["typeOfArticle"] == null ? null : Location.fromJson(json["typeOfArticle"]),
//         foundLocation: json["foundLocation"],
//         additionalInformation: json["additionalInformation"],
//         quantity: json["quantity"],
//         color: json["color"],
//         depositorDbEmp: json["depositorDbEmp"],
//         inputDate: json["inputDate"],//json["inputDate"] == null ? null : DateTime.parse(json["inputDate"]),
//         foundDate:json["foundDate"], //json["foundDate"] == null ? null : DateTime.parse(json["foundDate"]),
//         entrySecurity: json["entrySecurity"] == null ? null : Depositor.fromJson(json["entrySecurity"]),
//         location: json["location"] == null ? null : Location.fromJson(json["location"]),
//         depositor: json["depositor"] == null ? null : Depositor.fromJson(json["depositor"]),
//         status: json["status"],
//     );

//     Map<String, dynamic> toJson() => {
//         "slNo": slNo,
//         "typeOfAsset": typeOfAsset,
//         "typeOfArticle": typeOfArticle?.toJson(),
//         "foundLocation": foundLocation,
//         "additionalInformation": additionalInformation,
//         "quantity": quantity,
//         "color": color,
//         "depositorDbEmp": depositorDbEmp,
//         "inputDate": inputDate,//inputDate?.toIso8601String(),
//         "foundDate": foundDate,//foundDate?.toIso8601String(),
//         "entrySecurity": entrySecurity?.toJson(),
//         "location": location?.toJson(),
//         "depositor": depositor?.toJson(),
//         "status": status,
//     };
// }

// class Depositor {
//     int? userId;

//     Depositor({
//         this.userId,
//     });

//     factory Depositor.fromJson(Map<String, dynamic> json) => Depositor(
//         userId: json["userId"],
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId,
//     };
// }

// class Location {
//     int? id;

//     Location({
//         this.id,
//     });

//     factory Location.fromJson(Map<String, dynamic> json) => Location(
//         id: json["id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//     };
// }

// To parse this JSON data, do
//
//     final serialNumberModel = serialNumberModelFromJson(jsonString);

import 'dart:convert';

 CreateFoundRequestBody createFoundRequestBodyFromJson(String str) => CreateFoundRequestBody.fromJson(json.decode(str));

 String createFoundRequestBodyToJson(CreateFoundRequestBody data) => json.encode(data.toJson());


class CreateFoundRequestBody {
    Found? found;

    CreateFoundRequestBody({
        this.found,
    });

    factory CreateFoundRequestBody.fromJson(Map<String, dynamic> json) => CreateFoundRequestBody(
        found: json["found"] == null ? null : Found.fromJson(json["found"]),
    );

    Map<String, dynamic> toJson() => {
        "found": found?.toJson(),
    };
}

class Found {
    String? slNo;
    int? typeOfAsset;
    TypeOfArticle? typeOfArticle;
    String? foundLocation;
    String? additionalInformation;
    int? quantity;
    String? color;
    bool? depositorDbEmp;
    //DateTime? inputDate;
   // DateTime? foundDate;
    String? inputDate;
    String? foundDate;
    EntrySecurity? entrySecurity;
    CreateLocation? location;
    String? depositorName;
    Depositor? depositor;
    String? employeeId;
    DepositorDepartment? depositorDepartment;
    int? status;

    Found({
        this.slNo,
        this.typeOfAsset,
        this.typeOfArticle,
        this.foundLocation,
        this.additionalInformation,
        this.quantity,
        this.color,
        this.depositorDbEmp,
        this.inputDate,
        this.foundDate,
        this.entrySecurity,
        this.location,
        this.depositorName,
        this.depositor,
        this.employeeId,
        this.depositorDepartment,
        this.status,
    });

    factory Found.fromJson(Map<String, dynamic> json) => Found(
        slNo: json["slNo"],
        typeOfAsset: json["typeOfAsset"],
        typeOfArticle: json["typeOfArticle"] == null ? null : TypeOfArticle.fromJson(json["typeOfArticle"]),
        foundLocation: json["foundLocation"],
        additionalInformation: json["additionalInformation"],
        quantity: json["quantity"],
        color: json["color"],
        depositorDbEmp: json["depositorDbEmp"],
        inputDate: json["inputDate"],//json["inputDate"] == null ? null : DateTime.parse(json["inputDate"]),
        foundDate: json["foundDate"],//json["foundDate"] == null ? null : DateTime.parse(json["foundDate"]),
        entrySecurity: json["entrySecurity"] == null ? null : EntrySecurity.fromJson(json["entrySecurity"]),
        location: json["location"] == null ? null : CreateLocation.fromJson(json["location"]),
        depositorName: json["depositorName"],
        depositor: json["depositor"] == null ? null : Depositor.fromJson(json["depositor"]),
        employeeId: json["employeeId"],
        depositorDepartment: json["depositorDepartment"] == null ? null : DepositorDepartment.fromJson(json["depositorDepartment"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "slNo": slNo,
        "typeOfAsset": typeOfAsset,
        "typeOfArticle": typeOfArticle?.toJson(),
        "foundLocation": foundLocation,
        "additionalInformation": additionalInformation,
        "quantity": quantity,
        "color": color,
        "depositorDbEmp": depositorDbEmp,
        "inputDate": inputDate,//inputDate?.toIso8601String(),
        "foundDate": foundDate,//foundDate?.toIso8601String(),
        "entrySecurity": entrySecurity?.toJson(),
        "location": location?.toJson(),
        "depositorName": depositorName,
        "depositor": depositor?.toJson(),
        "employeeId": employeeId,
        "depositorDepartment": depositorDepartment?.toJson(),
        "status": status,
    };
}

class Depositor {
    int? userId;

    Depositor({
        this.userId,
    });

    factory Depositor.fromJson(Map<String, dynamic> json) => Depositor(
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
    };
}
class EntrySecurity {
    int? userId;

    EntrySecurity({
        this.userId,
    });

    factory EntrySecurity.fromJson(Map<String, dynamic> json) => EntrySecurity(
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
    };
}

class DepositorDepartment {
    int? id;

    DepositorDepartment({
        this.id,
    });

    factory DepositorDepartment.fromJson(Map<String, dynamic> json) => DepositorDepartment(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}
class CreateLocation {
    int? id;

    CreateLocation({
        this.id,
    });

    factory CreateLocation.fromJson(Map<String, dynamic> json) => CreateLocation(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
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

