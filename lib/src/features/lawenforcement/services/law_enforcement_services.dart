import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_list_response.dart';
import 'package:db_atom/src/features/lawenforcement/models/distribution_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/law_enforement_request.dart';
import 'package:db_atom/src/features/lawenforcement/models/leopurposevisit.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/getLawEnfrcmntList?';
  static final String _getById = '$baseUrl/getLawEnfrcmnt';
  static final String _create = '$baseUrl/saveLawEnfrcmnt';
  static final String _getLocations = '$baseUrl/getOrganisation?name=';
  static final String _getSlNo = '$baseUrl/getSlNo?';
  static final String _getUsersByRole = '$baseUrl/getUsersByRole?roleName=';
  static final String _getUserDetails = '$baseUrl/getUserDetails?userId=';
  static final String _getGroup = '$baseUrl/getGroup';
  static final String _createOrganisation = '$baseUrl/createOrganisation?';
  static final String _createUser = '$baseUrl/createUser?';
  static final String _getLeoVisitingOfficials =
      '$baseUrl/getLeoVisitingOfficials/';
  static final String _getLeoVisitingOfficialById =
      '$baseUrl/getLeoVisitingOfficialById/';
  static final String _createVisitingOfficial =
      '$baseUrl/createVisitingOfficial/';
  static final String _deleteVisitingOfficial =
      '$baseUrl/deleteVisitingOfficial/';
}

class LawEnforcementServices {
  final endpoint = Environment().config.apiHost;

  Future<LawEnforcementListResponse> getList({
    required String startPosition,
    required String maximumRecords,
    required String userId,
    BuildContext? context,
  }) async {
    String url =
        '${Apis._getList}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return LawEnforcementListResponse.fromJson(response);
  }

  Future<LawEnforcementListResponse> getListWithFilters({
    required String startPosition,
    required String maximumRecords,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis._getList}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return LawEnforcementListResponse.fromJson(response);
  }

  Future<LawEnforcementDetailsModel> getById(
    int id,
    BuildContext context,
  ) async {
    final String url = '${Apis._getById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
      isAuthenticated: true,
    );

    return LawEnforcementDetailsModel.fromJson(response);
  }

  Future<SubmitLawEnforcementResponse> createLawFoundArticle({
    required LawEnforcementRequestBody body,
    required bool isSubmit,
  }) async {
    var username = await SharedPrefs.getUsername();
    final String url = "${Apis._create}?userEmail=$username&isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return SubmitLawEnforcementResponse.fromJson(response);
  }

  // get Entities api call
  Future<AddEntities> getEntities(
    String name,
  ) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return AddEntities.fromJson(response);
  }

  //Get locations
  Future<Locations> getLocations(String name, BuildContext? context) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return Locations.fromJson(response);
  }

  // get serailnumber Details api call
  Future<SerialNumberModel> getSerialnumberDetails(
    String locationId,
    String moduleCode,
    BuildContext? context,
  ) async {
    String url =
        '${Apis._getSlNo}locationId=$locationId&moduleCode=$moduleCode';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return SerialNumberModel.fromJson(response);
  }

  Future<LeoPurposeVisit> getLeopurposeofvisit(
      String name, BuildContext? context) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return LeoPurposeVisit.fromJson(response);
  }

  Future<LeoDepartments> getLeodepartments(String name) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return LeoDepartments.fromJson(response);
  }

  Future<GetDepositor> getDBOfficialdepartments(
    String roleName,
    BuildContext? context,
  ) async {
    String url = '${Apis._getUsersByRole}$roleName';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GetDepositor.fromJson(response);
  }

  //Get Employee Departments
  Future<EmployeeDepartments> getEmployeeDepartments(
      String name, BuildContext? context) async {
    String url = '${Apis._getLocations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return EmployeeDepartments.fromJson(response);
  }

  Future<User> getUserDetails(
    String userId,
    BuildContext? context,
  ) async {
    String url = '${Apis._getUserDetails}$userId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return User.fromJson(response);
  }

  Future<DistributionGroupModel> getDistributiongroupDetails(
    BuildContext? context,
  ) async {
    String url = Apis._getGroup;
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return DistributionGroupModel.fromJson(response);
  }

  Future<Organisation> createOrganisation(
    String name,
    String orgName,
    BuildContext? context,
  ) async {
    final String url = "${Apis._createOrganisation}name=$name&orgName=$orgName";
    final response =
        await BaseApiService().postRequest(url: url, requestedData: {});
    return Organisation.fromJson(response);
  }

// Create user api call
  Future<CreateUserModel> createUser(
    String firstName,
    String lastName,
    String email,
    String role,
    BuildContext? context,
  ) async {
    final String url =
        "${Apis._createUser}firstName=$firstName&lastName=$lastName&email=$email&role=$role";
    final response =
        await BaseApiService().postRequest(url: url, requestedData: {});
    return CreateUserModel.fromJson(response);
  }

  Future<List<LawVisitingOfficial>> getLeoVisitingOfficials({
    required int id,
  }) async {
    String url = '${Apis._getLeoVisitingOfficials}$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    if (response == null) {
      return [];
    }
    return List<LawVisitingOfficial>.from(
        response.map((x) => LawVisitingOfficial.fromJson(x)));
  }

  Future<LawVisitingOfficial> getLeoVisitingOfficialById({
    required int id,
  }) async {
    final String url = '${Apis._getLeoVisitingOfficialById}$id';
    final response = await BaseApiService().getRequest(
      url: url,
      isAuthenticated: true,
    );

    return LawVisitingOfficial.fromJson(response);
  }

  Future<GenericResponse> createVisitingOfficial({
    required int parentId,
    required LawVisitingOfficialRequest body,
  }) async {
    // var username = await SharedPrefs.getUsername();
    final String url =
        "${Apis._createVisitingOfficial}$parentId?isSubmit=false";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> deleteVisitingOfficial(int id) async {
    final String url = '${Apis._deleteVisitingOfficial}$id';
    final response = await BaseApiService().deleteRequest(
      url: url,
    );
    return GenericResponse.fromJson(response);
  }
}
