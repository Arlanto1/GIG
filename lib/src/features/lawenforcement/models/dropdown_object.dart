import 'package:db_atom/src/models/organisation.dart';

class VisitingOfficialsModel {
  String? designation;
  String? name;
  Organisation? department;
  String? officialaddress;
  String? email;
  String? conatctno;
  int? id;

  VisitingOfficialsModel(
      {this.designation,
      this.name,
      this.department,
      this.officialaddress,
      this.email,
      this.conatctno,
      this.id});

  factory VisitingOfficialsModel.fromJson(Map<String, dynamic> json) =>
      VisitingOfficialsModel(
        designation: json["designation"],
        name: json["name"],
        department: json["department"],
        officialaddress: json["officialaddress"],
        email: json["email"],
        conatctno: json["conatctno"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "designation": designation,
        "name": name,
        "department": department,
        "officialaddress": officialaddress,
        "email": email,
        "conatctno": conatctno,
        "id": id
      };
}
