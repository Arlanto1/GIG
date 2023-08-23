

import 'dart:convert';
import 'dart:io';

import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/createfound/models/create_organisation_model.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/lawenforcement/models/distribution_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/law_enforement_request.dart';
import 'package:db_atom/src/features/lawenforcement/models/leodepartments.dart';
import 'package:db_atom/src/features/lawenforcement/models/leopurposevisit.dart';
import 'package:db_atom/src/features/lawenforcement/models/submit_law_enforcement_response.dart';
import 'package:http/http.dart' as http;

import '../../../models/entry_security.dart';

class LawEnforcementService
{
 final endpoint = Environment().config.apiHost;
  Future<SubmitLawEnforcementResponse> createLawFoundArticle(
      LawEnforcementRequestBody requestBody, bool isSubmit, String username) async {
    final url = Uri.parse('$endpoint/saveLawEnfrcmnt?isSubmit=$isSubmit&userEmail=username');
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
        return SubmitLawEnforcementResponse.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }

  Future<SubmitLawEnforcementResponse> createLawFoundArticleHandle(
      Map<String, dynamic> requestBody, bool isSubmit, String username) async {
   
   print(requestBody);
    final url = Uri.parse('$endpoint/saveLawEnfrcmnt?isSubmit=$isSubmit&userEmail=username');
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
        return SubmitLawEnforcementResponse.fromJson(json.decode(response.body));
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

  // get Entities api call
  Future<LeoPurposeVisit> getLeopurposeofvisit(String name) async {
    
    final url = Uri.parse('$endpoint/getOrganisation?name=$name');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return LeoPurposeVisit.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }

  Future<LeoDepartments> getLeodepartments(String name) async {
    
    final url = Uri.parse('$endpoint/getOrganisation?name=$name');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return LeoDepartments.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }
  Future<GetDepositor> getDBOfficialdepartments(String name) async {
    
    final url = Uri.parse('$endpoint/getUsersByRole?roleName=$name');
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

  // get user Details api call
  Future<EntrySecurity> getUserDetails(String userId) async {
    
    final url = Uri.parse('$endpoint/getUserDetails?userId=$userId');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return EntrySecurity.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }

  // get distribution group Details api call
  Future<DistributionGroupModel> getDistributiongroupDetails() async {
    
    final url = Uri.parse('$endpoint/getGroup');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return DistributionGroupModel.fromJson(json.decode(response.body));
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


  

}