// To parse this JSON data, do
//
//     final serialNumberModel = serialNumberModelFromJson(jsonString);

import 'dart:convert';

SerialNumberModel serialNumberModelFromJson(String str) => SerialNumberModel.fromJson(json.decode(str));

String serialNumberModelToJson(SerialNumberModel data) => json.encode(data.toJson());

class SerialNumberModel {
    String? serialNo;

    SerialNumberModel({
        this.serialNo,
    });

    factory SerialNumberModel.fromJson(Map<String, dynamic> json) => SerialNumberModel(
        serialNo: json["Serial No."],
    );

    Map<String, dynamic> toJson() => {
        "Serial No.": serialNo,
    };
}