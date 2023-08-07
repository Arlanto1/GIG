// To parse this JSON data, do
//
//     final refreshTokenResponseModel = refreshTokenResponseModelFromJson(jsonString);

import 'dart:convert';

RefreshTokenResponseModel refreshTokenResponseModelFromJson(String str) => RefreshTokenResponseModel.fromJson(json.decode(str));

String refreshTokenResponseModelToJson(RefreshTokenResponseModel data) => json.encode(data.toJson());

class RefreshTokenResponseModel {
  int? status;
  String? msg;
  String? token;

  RefreshTokenResponseModel({
    this.status,
    this.msg,
    this.token,
  });

  factory RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) => RefreshTokenResponseModel(
    status: json["status"],
    msg: json["msg"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "token": token,
  };
}
