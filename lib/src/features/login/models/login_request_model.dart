// To parse this JSON data, do
//
//     final loginRequestModel = loginRequestModelFromJson(jsonString);

import 'dart:convert';

LoginRequestModel loginRequestModelFromJson(String str) =>
    LoginRequestModel.fromJson(json.decode(str));

String loginRequestModelToJson(LoginRequestModel data) =>
    json.encode(data.toJson());

class LoginRequestModel {
  Request? request;

  LoginRequestModel({
    this.request,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestModel(
        request:
            json["request"] == null ? null : Request.fromJson(json["request"]),
      );

  Map<String, dynamic> toJson() => {
        "request": request?.toJson(),
      };
}

class Request {
  String? id;
  String? password;
  String? otp;

  Request({
    this.id,
    this.password,
    this.otp,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: json["id"],
        password: json["password"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "otp": otp,
      };
}
