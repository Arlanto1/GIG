
import 'package:db_atom/src/features/lawenforcement/models/leodepartments.dart';

class VistingOfficialsModel {


  String? designation;
  String? name;
  AtomLeoDepartment? department;
  String? officialaddress;
  String? email;
  String? conatctno;
  int? id;

  VistingOfficialsModel({
    this.designation,
    this.name,
    this.department,
    this.officialaddress,
    this.email,
    this.conatctno,
    this.id
  });

  factory VistingOfficialsModel.fromJson(Map<String, dynamic> json) => VistingOfficialsModel(
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