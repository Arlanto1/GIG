import 'package:db_atom/src/models/organisation.dart';

class VisitingOfficialsModel {
  String? designation;
  String? name;
  Organisation? department;
  String? address;
  String? email;
  String? contactNo;
  int? id;

  VisitingOfficialsModel(
      {this.designation,
      this.name,
      this.department,
      this.address,
      this.email,
      this.contactNo,
      this.id});

  factory VisitingOfficialsModel.fromJson(Map<String, dynamic> json) =>
      VisitingOfficialsModel(
        designation: json["designation"],
        name: json["name"],
        department: json["department"],
        address: json["address"],
        email: json["email"],
        contactNo: json["contactNo"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "designation": designation,
        "name": name,
        "department": department,
        "address": address,
        "email": email,
        "contactNo": contactNo,
        "id": id
      };
}
