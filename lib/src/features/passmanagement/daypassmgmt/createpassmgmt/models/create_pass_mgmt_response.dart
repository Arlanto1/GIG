// To parse this JSON data, do
//
//     final createPassMgmtResponse = createPassMgmtResponseFromJson(jsonString);

import 'dart:convert';

CreatePassMgmtResponse createPassMgmtResponseFromJson(String str) => CreatePassMgmtResponse.fromJson(json.decode(str));

String createPassMgmtResponseToJson(CreatePassMgmtResponse data) => json.encode(data.toJson());

class CreatePassMgmtResponse {
    String? passManagementId;
    String? message;

    CreatePassMgmtResponse({
        this.passManagementId,
        this.message,
    });

    factory CreatePassMgmtResponse.fromJson(Map<String, dynamic> json) => CreatePassMgmtResponse(
        passManagementId: json["Pass Management ID"],
        message: json["Message"],
    );

    Map<String, dynamic> toJson() => {
        "Pass Management ID": passManagementId,
        "Message": message,
    };
}
