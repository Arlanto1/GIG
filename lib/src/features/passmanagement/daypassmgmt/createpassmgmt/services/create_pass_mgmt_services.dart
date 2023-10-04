

import 'dart:convert';

import 'package:db_atom/main_DEV.dart';
import 'package:db_atom/src/appservices/app_service_handler.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/createfound/models/create_organisation_model.dart';
import 'package:db_atom/src/features/createfound/models/create_user_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/company_type_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/create_pass_mgmt_request_body.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/create_pass_mgmt_response.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_numbers_list.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_reason_model.dart';

import '../../../../../models/entry_security.dart';
import '../../../../../models/organisation.dart';

class CreatePassMgmtService
{
 final endpoint = Environment().config.apiHost;
  Future<CreatePassMgmtResponse> createLawFoundArticle(
      CreatePassMgmtBody requestBody, bool isSubmit, String username,BuildContext context) async {
        print(requestBody.toString());

    var value  = await  AppServicesHandler().globalPostServiceCall('/createPass?isSubmit=$isSubmit&userEmail=username',context,json.encode(requestBody));

   return  CreatePassMgmtResponse.fromJson(value);
  }

  // Create user api call
  Future<CreateUserModel> createUser(
      String firstName, String lastName, String email, String role,BuildContext context) async {
   
    // final url = Uri.parse(
    //     '$endpoint/createUser?firstName=$firstName&lastName=$lastName&email=$email&role=$role');
    // try {
    //   final response = await http.post(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     return CreateUserModel.fromJson(json.decode(response.body));
    //   } else {
    //     throw json.decode(response.body);
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }
      var value  = await  AppServicesHandler().globalPostServiceCall('/createUser?firstName=$firstName&lastName=$lastName&email=$email&role=$role',context,'');

   return  CreateUserModel.fromJson(value);
  }

  Future<CreatePassMgmtResponse> createLawFoundArticleHandle(
      Map<String, dynamic> requestBody, bool isSubmit, String username,BuildContext context) async {
   
  //  print(requestBody);
  //   final url = Uri.parse('$endpoint/createPass?isSubmit=$isSubmit&userEmail=username');
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: json.encode(requestBody),
  //     );
  //     print(response);
  //     if (response.statusCode == 200) {
  //       return CreatePassMgmtResponse.fromJson(json.decode(response.body));
  //     } else {
  //       throw json.decode(response.body);
  //     }
  //   } on SocketException {
  //     throw json.decode('{"errorMessage":"Network Lost"}');
  //   }
   var value  = await  AppServicesHandler().globalPostServiceCall('/createPass?isSubmit=$isSubmit&userEmail=username',context,json.encode(requestBody));

   return  CreatePassMgmtResponse.fromJson(value);
  }

  // get Entities api call
  Future<AddEntities> getEntities(String name,BuildContext context) async {
    
    // final url = Uri.parse('$endpoint/getOrganisation?name=$name');
    // try {
    //   final response = await http.get(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     return AddEntities.fromJson(json.decode(response.body));
    //   } else {
    //     throw json.decode(response.body);
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }
    var value  = await  AppServicesHandler().globalpopupGetServiceCall('/getOrganisation?name=$name',context);

   return  AddEntities.fromJson(value);
  }

  //Get Depositor users by role
  Future<GetDepositor> getUserByRoleDepositor(String userRole,BuildContext context) async {
   
    // final url = Uri.parse('$endpoint/getUsersByRole?roleName=$userRole');
    // try {
    //   final response = await http.get(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     return GetDepositor.fromJson(json.decode(response.body));
    //   } else {
    //     throw json.decode(response.body);
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }
    var value  = await  AppServicesHandler().globalpopupGetServiceCall('/getUsersByRole?roleName=$userRole',context);

   return  GetDepositor.fromJson(value);
  }

  //Get locations
  Future<GetLocations> getLocations(String locationStr,BuildContext context) async {
   
    // final url = Uri.parse('$endpoint/getOrganisation?name=$locationStr');
    // try {
    //   final response = await http.get(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     return GetLocations.fromJson(json.decode(response.body));
    //   } else {
    //     throw json.decode(response.body);
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }
    var value  = await  AppServicesHandler().globalpopupGetServiceCall('/getOrganisation?name=$locationStr',context);

   return  GetLocations.fromJson(value);
  }

  // get serailnumber Details api call
  Future<SerialNumberModel> getSerialnumberDetails(String locationId, String moduleCode,BuildContext context) async {
    
   // https: //api.integration.dbatom.arlanto.com/api/atomrestservice/getSlNo?locationId=32&moduleCode=AF
    // final url = Uri.parse('$endpoint/getSlNo?locationId=$locationId&moduleCode=$moduleCode');
    // try {
    //   final response = await http.get(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     return SerialNumberModel.fromJson(json.decode(response.body));
    //   } else {
    //     throw json.decode(response.body);
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }
    var value  = await  AppServicesHandler().globalpopupGetServiceCall('/getSlNo?locationId=$locationId&moduleCode=$moduleCode',context);

   return  SerialNumberModel.fromJson(value);
  }

 
  //Get Employee Departments
  Future<EmployeeDepartments> getEmployeeDepartments(String departmentStr,BuildContext context) async {
    
    // final url = Uri.parse('$endpoint/getOrganisation?name=$departmentStr');
    // try {
    //   final response = await http.get(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     return EmployeeDepartments.fromJson(json.decode(response.body));
    //   } else {
    //     throw json.decode(response.body);
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }
     var value  = await  AppServicesHandler().globalpopupGetServiceCall('/getOrganisation?name=$departmentStr',context);

   return  EmployeeDepartments.fromJson(value);
  }

  //Get Company types
  Future<CompanyTypes> getCompanyTypes(String departmentStr,BuildContext context) async {
    
    // final url = Uri.parse('$endpoint/getOrganisation?name=$departmentStr');
    // try {
    //   final response = await http.get(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     return CompanyTypes.fromJson(json.decode(response.body));
    //   } else {
    //     throw json.decode(response.body);
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }
    var value  = await  AppServicesHandler().globalpopupGetServiceCall('/getOrganisation?name=$departmentStr',context);

   return  CompanyTypes.fromJson(value);
  }

  //Get Day Pass reason
  Future<DayPassReason> getDayPassreason(String departmentStr,BuildContext context) async {
    
    // final url = Uri.parse('$endpoint/getOrganisation?name=$departmentStr');
    // try {
    //   final response = await http.get(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     return DayPassReason.fromJson(json.decode(response.body));
    //   } else {
    //     throw json.decode(response.body);
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }
    var value  = await  AppServicesHandler().globalpopupGetServiceCall('/getOrganisation?name=$departmentStr',context);

   return  DayPassReason.fromJson(value);
  }

  // get user Details api call
  Future<EntrySecurity> getUserDetails(String userId, BuildContext context) async {
    
    // final url = Uri.parse('$endpoint/getUserDetails?userId=$userId');
    // try {
    //   final response = await http.get(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     return EntrySecurity.fromJson(json.decode(response.body));
    //   } else {
    //     throw json.decode(response.body);
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }
    var value  = await  AppServicesHandler().globalpopupGetServiceCall('/getUserDetails?userId=$userId',context);

   return  EntrySecurity.fromJson(value);
  }

  // Create organisation api call
  Future<Organisation> createOrganisation(String name, String orgName,BuildContext context) async {
    
    // final url = Uri.parse('$endpoint/createOrganisation?name=$name&orgName=$orgName');
    // try {
    //   final response = await http.post(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     return CreateOrganisation.fromJson(json.decode(response.body));
    //   } else {
    //     throw json.decode(response.body);
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }
    var value  = await  AppServicesHandler().globalpopupGetServiceCall('/createOrganisation?name=$name&orgName=$orgName',context);

   return  Organisation.fromJson(value);
  }


    //  Analyst api call
  Future<Analyst> getAnalyst(String name,BuildContext context) async {
    
    // final url = Uri.parse('$endpoint/getUsersByRole?roleName=$name');
    // try {
    //   final response = await http.get(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     return Analyst.fromJson(json.decode(response.body));
    //   } else {
    //     throw json.decode(response.body);
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }
    var value  = await  AppServicesHandler().globalpopupGetServiceCall('/getUsersByRole?roleName=$name',context);

   return  Analyst.fromJson(value);
  }

  //
  //  get pass api call
  Future<DayPassNumberLists> getPassno(String passtype, String locatonid,BuildContext context) async {
    
    // final url = Uri.parse('$endpoint/getActivePassInfo?passType=$passtype&locationId=$locatonid');
    // try {
    //   final response = await http.get(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     return DayPassNumberLists.fromJson(json.decode(response.body));
    //   } else {
    //     throw json.decode(response.body);
    //   }
    // } on SocketException {
    //   throw json.decode('{"errorMessage":"Network Lost"}');
    // }

     var value  = await  AppServicesHandler().globalpopupGetServiceCall('/getActivePassInfo?passType=$passtype&locationId=$locatonid',context);

   return  DayPassNumberLists.fromJson(value);
  }



  

}