import 'dart:convert';

import '../../../../../../index.dart';

GetIpadSerialNo getIpadSerialNoFromJson(String str) =>
    GetIpadSerialNo.fromJson(json.decode(str));

String getIpadSerialNoToJson(GetIpadSerialNo data) => json.encode(data.toJson());

class GetIpadSerialNo {
  List<Organisation>? ipadSerialNum;

  GetIpadSerialNo({
    this.ipadSerialNum,
  });

  factory GetIpadSerialNo.fromJson(Map<String, dynamic> json) => GetIpadSerialNo(
    ipadSerialNum: json["IPAD_SERIAL_NO"] == null
        ? []
        : List<Organisation>.from(
        json["IPAD_SERIAL_NO"]!.map((x) => Organisation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "IPAD_SERIAL_NO": ipadSerialNum == null
        ? []
        : List<dynamic>.from(ipadSerialNum!.map((x) => x.toJson())),
  };
}
