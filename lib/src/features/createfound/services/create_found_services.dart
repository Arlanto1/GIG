import 'dart:convert';
import 'dart:io';

import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/configurations/prod_config.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/create_found_submit_model.dart';
import 'package:db_atom/src/features/createfound/models/create_organisation_model.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_articletype_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:http/http.dart' as http;

class CreateFoundServices {
   final endpoint = Environment().config.apiHost;
  Future<SubmitCreateFoundModel> createFoundArticle(
      CreateFoundRequestBody requestBody, bool isSubmit, String username) async {
    final url = Uri.parse('$endpoint/addFound?isSubmit=$isSubmit&userEmail=username');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(requestBody),
      );
      print(response);
      if (response.statusCode == 200) {
        return SubmitCreateFoundModel.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }

  Future<SubmitCreateFoundModel> createFoundArticleHandle(
      Map<String, dynamic> requestBody, bool isSubmit, String username) async {
   
   print(requestBody);
    final url = Uri.parse('$endpoint/addFound?isSubmit=$isSubmit&userEmail=username');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(requestBody),
      );
      print(response);
      if (response.statusCode == 200) {
        return SubmitCreateFoundModel.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }

  //Get Depositor users by role
  Future<GetDepositor> getUserByRoleDepositor(String userRole) async {
   
    final url = Uri.parse('$endpoint/getUsersByRole?roleName=$userRole');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return GetDepositor.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }

  //Get locations
  Future<GetLocations> getLocations(String locationStr) async {
   
    final url = Uri.parse('$endpoint/getOrganisation?name=$locationStr');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return GetLocations.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }

  //Get Employee Departments
  Future<EmployeeDepartments> getEmployeeDepartments(String departmentStr) async {
    
    final url = Uri.parse('$endpoint/getOrganisation?name=$departmentStr');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return EmployeeDepartments.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }

  //Get Article Type
  Future<GetArticleType> getArticleType(String articleTypeStr) async {
    
    final url = Uri.parse('$endpoint/getOrganisation?name=$articleTypeStr');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return GetArticleType.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }

  // Create organisation api call
  Future<CreateOrganisation> createOrganisation(String name, String orgName) async {
    
    final url = Uri.parse('$endpoint/createOrganisation?name=$name&orgName=$orgName');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return CreateOrganisation.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }

  // Create user api call
  Future<CreateUserModel> createUser(
      String firstName, String lastName, String email, String role) async {
   
    final url = Uri.parse(
        '$endpoint/createUser?firstName=$firstName&lastName=$lastName&email=$email&role=$role');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return CreateUserModel.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }

  // get user Details api call
  Future<GetUserDetails> getUserDetails(String userId) async {
    
    final url = Uri.parse('$endpoint/getUserDetails?userId=$userId');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return GetUserDetails.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }

  // get serailnumber Details api call
  Future<SerialNumberModel> getSerialnumberDetails(String locationId, String moduleCode) async {
    
   // https: //api.integration.dbatom.arlanto.com/api/atomrestservice/getSlNo?locationId=32&moduleCode=AF
    final url = Uri.parse('$endpoint/getSlNo?locationId=$locationId&moduleCode=$moduleCode');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return SerialNumberModel.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }
}
