

import 'dart:convert';
import 'dart:io';

import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/createfound/models/create_organisation_model.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';

import 'package:db_atom/src/features/lawenforcement/models/law_enforement_request.dart';

import 'package:db_atom/src/features/lawenforcement/models/submit_law_enforcement_response.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/company_type_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/create_pass_mgmt_request_body.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/create_pass_mgmt_response.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_numbers_list.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_reason_model.dart';
import 'package:http/http.dart' as http;

class CreatePassMgmtService
{
 final endpoint = Environment().config.apiHost;
  Future<CreatePassMgmtResponse> createLawFoundArticle(
      CreatePassMgmtBody requestBody, bool isSubmit, String username) async {
        print(requestBody.toString());
    final url = Uri.parse('$endpoint/createPass?isSubmit=$isSubmit&userEmail=username');
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
        return CreatePassMgmtResponse.fromJson(json.decode(response.body));
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

  Future<CreatePassMgmtResponse> createLawFoundArticleHandle(
      Map<String, dynamic> requestBody, bool isSubmit, String username) async {
   
   print(requestBody);
    final url = Uri.parse('$endpoint/createPass?isSubmit=$isSubmit&userEmail=username');
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
        return CreatePassMgmtResponse.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }

  // get Entities api call
  Future<AddEntities> getEntities(String name) async {
    
    final url = Uri.parse('$endpoint/getOrganisation?name=$name');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return AddEntities.fromJson(json.decode(response.body));
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

  //Get Company types
  Future<CompanyTypes> getCompanyTypes(String departmentStr) async {
    
    final url = Uri.parse('$endpoint/getOrganisation?name=$departmentStr');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return CompanyTypes.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }

  //Get Day Pass reason
  Future<DayPassReason> getDayPassreason(String departmentStr) async {
    
    final url = Uri.parse('$endpoint/getOrganisation?name=$departmentStr');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return DayPassReason.fromJson(json.decode(response.body));
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


    //  Analyst api call
  Future<Analyst> getAnalyst(String name) async {
    
    final url = Uri.parse('$endpoint/getUsersByRole?roleName=$name');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return Analyst.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }

  //
  //  get pass api call
  Future<DayPassNumberLists> getPassno(String passtype, String locatonid) async {
    
    final url = Uri.parse('$endpoint/getActivePassInfo?passType=$passtype&locationId=$locatonid');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return DayPassNumberLists.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }



  

}