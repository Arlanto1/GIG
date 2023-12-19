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
  String? userName;
  String? password;
  String? otp;
  String? deviceToken;
  String? deviceType;

  Request({
    this.userName,
    this.password,
    this.otp,
    this.deviceToken,
    this.deviceType,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        userName: json["userName"],
        password: json["password"],
        deviceToken: json["deviceToken"],
        deviceType: json["deviceType"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "password": password,
        "deviceToken": deviceToken,
        "deviceType": deviceType,
        "otp": otp,
      };
}
