// To parse this JSON data, do
//
//     final dayPassInfoResponse = dayPassInfoResponseFromJson(jsonString);

import 'dart:convert';

DayPassInfoResponse dayPassInfoResponseFromJson(String str) => DayPassInfoResponse.fromJson(json.decode(str));

String dayPassInfoResponseToJson(DayPassInfoResponse data) => json.encode(data.toJson());

class DayPassInfoResponse {
    List<DaypassInfoListElement>? list;
    int? totalCount;
    int? currentPageNo;
    int? totalPageCount;

    DayPassInfoResponse({
        this.list,
        this.totalCount,
        this.currentPageNo,
        this.totalPageCount,
    });

    factory DayPassInfoResponse.fromJson(Map<String, dynamic> json) => DayPassInfoResponse(
        list: json["list"] == null ? [] : List<DaypassInfoListElement>.from(json["list"]!.map((x) => DaypassInfoListElement.fromJson(x))),
        totalCount: json["totalCount"],
        currentPageNo: json["currentPageNo"],
        totalPageCount: json["totalPageCount"],
    );

    Map<String, dynamic> toJson() => {
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
        "totalCount": totalCount,
        "currentPageNo": currentPageNo,
        "totalPageCount": totalPageCount,
    };
}

class DaypassInfoListElement {
    int? id;
    int? passType;
    String? passNo;
    String? mifareNo;
    String? expiryDate;
    bool? dws;
    int? status;
    Entity? location;
    Entity? region;
    Entity? entity;

    DaypassInfoListElement({
        this.id,
        this.passType,
        this.passNo,
        this.mifareNo,
        this.expiryDate,
        this.dws,
        this.status,
        this.location,
        this.region,
        this.entity,
    });

    factory DaypassInfoListElement.fromJson(Map<String, dynamic> json) => DaypassInfoListElement(
        id: json["id"],
        passType: json["passType"],
        passNo: json["passNo"],
        mifareNo: json["mifareNo"],
        expiryDate: json["expiryDate"],
        dws: json["dws"],
        status: json["status"],
        location: json["location"] == null ? null : Entity.fromJson(json["location"]),
        region: json["region"] == null ? null : Entity.fromJson(json["region"]),
        entity: json["entity"] == null ? null : Entity.fromJson(json["entity"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "passType": passType,
        "passNo": passNo,
        "mifareNo": mifareNo,
        "expiryDate": expiryDate,
        "dws": dws,
        "status": status,
        "location": location?.toJson(),
        "region": region?.toJson(),
        "entity": entity?.toJson(),
    };
}

class Entity {
    int? id;
    Name? name;

    Entity({
        this.id,
        this.name,
    });

    factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
    };
}

enum Name {
    DIPL,
    MTP,
    NORTH_EAST
}

final nameValues = EnumValues({
    "DIPL": Name.DIPL,
    "MTP": Name.MTP,
    "North & East": Name.NORTH_EAST
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
