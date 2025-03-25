import 'package:db_atom/src/models/organisation.dart';

class VisitingOfficialsModel {
  int? id;
  String? name;
  String? designation;
  Organisation? department;
  String? address;
  String? contactNo;
  String? email;
  bool? mandatory;

  VisitingOfficialsModel({
    this.id,
    this.name,
    this.designation,
    this.department,
    this.address,
    this.contactNo,
    this.email,
    this.mandatory,
  });

  factory VisitingOfficialsModel.fromJson(Map<String, dynamic> json) =>
      VisitingOfficialsModel(
        id: json["id"],
        name: json["name"],
        designation: json["designation"],
        department: json["department"] == null
            ? null
            : Organisation.fromJson(json["department"]),
        address: json["address"],
        contactNo: json["contactNo"],
        email: json["email"],
        mandatory: json["mandatory"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "designation": designation,
    "department": department?.toJson(),
    "address": address,
    "contactNo": contactNo,
    "email": email,
    "mandatory": mandatory,
  };
}