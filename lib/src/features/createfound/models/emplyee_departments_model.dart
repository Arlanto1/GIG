import 'dart:convert';

EmployeeDepartments employeeDepartmentsFromJson(String str) =>
    EmployeeDepartments.fromJson(json.decode(str));

String employeeDepartmentsToJson(EmployeeDepartments data) => json.encode(data.toJson());

class EmployeeDepartments {
  List<EmployeeDepartment>? employeeDepartments;

  EmployeeDepartments({
    this.employeeDepartments,
  });

  factory EmployeeDepartments.fromJson(Map<String, dynamic> json) => EmployeeDepartments(
        employeeDepartments: json["EMPLOYEE_DEPARTMENTS"] == null
            ? []
            : List<EmployeeDepartment>.from(
                json["EMPLOYEE_DEPARTMENTS"]!.map((x) => EmployeeDepartment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "EMPLOYEE_DEPARTMENTS": employeeDepartments == null
            ? []
            : List<dynamic>.from(employeeDepartments!.map((x) => x.toJson())),
      };
}

class EmployeeDepartment {
  int? id;
  String? name;

  EmployeeDepartment({
    this.id,
    this.name,
  });

  factory EmployeeDepartment.fromJson(Map<String, dynamic> json) => EmployeeDepartment(
        id: json["Id"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
