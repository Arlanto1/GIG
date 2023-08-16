import 'dart:convert';

import '../../../models/department.dart';

EmployeeDepartments employeeDepartmentsFromJson(String str) =>
    EmployeeDepartments.fromJson(json.decode(str));

String employeeDepartmentsToJson(EmployeeDepartments data) => json.encode(data.toJson());

class EmployeeDepartments {
  List<Department>? employeeDepartments;

  EmployeeDepartments({
    this.employeeDepartments,
  });

  factory EmployeeDepartments.fromJson(Map<String, dynamic> json) => EmployeeDepartments(
        employeeDepartments: json["EMPLOYEE_DEPARTMENTS"] == null
            ? []
            : List<Department>.from(
                json["EMPLOYEE_DEPARTMENTS"]!.map((x) => Department.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "EMPLOYEE_DEPARTMENTS": employeeDepartments == null
            ? []
            : List<dynamic>.from(employeeDepartments!.map((x) => x.toJson())),
      };
}

