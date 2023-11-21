import 'dart:convert';

import '../../../models/organisation.dart';

EmployeeDepartments employeeDepartmentsFromJson(String str) =>
    EmployeeDepartments.fromJson(json.decode(str));

String employeeDepartmentsToJson(EmployeeDepartments data) =>
    json.encode(data.toJson());

class EmployeeDepartments {
  List<Organisation>? employeeDepartments;

  EmployeeDepartments({
    this.employeeDepartments,
  });

  factory EmployeeDepartments.fromJson(Map<String, dynamic> json) =>
      EmployeeDepartments(
        employeeDepartments: json["EMPLOYEE_DEPARTMENTS"] == null
            ? []
            : List<Organisation>.from(json["EMPLOYEE_DEPARTMENTS"]!
                .map((x) => Organisation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "EMPLOYEE_DEPARTMENTS": employeeDepartments == null
            ? []
            : List<dynamic>.from(employeeDepartments!.map((x) => x.toJson())),
      };
}
