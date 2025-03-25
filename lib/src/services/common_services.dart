import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/models/day_pass_reason_model.dart';
import 'package:db_atom/src/features/passmanagement/models/vendor_pass_reason_model.dart';

class   CommonApis {
  static final String baseUrl = Environment().config.apiHost;
  static const String v2 = '';

  // static const String v2 = '/v2';
  static final String _getUiLabels = '$baseUrl/getLabels?';
  static final String _getOrganisations = '$baseUrl/getOrganisation?name=';
  static final String _getLocationsNew =
      '$baseUrl/getAtomLocations?isSezLocations=';
  static final String _getArticleType = '$baseUrl/getOrganisation?name=';
  static final String _getUserDetails = '$baseUrl/getUserDetails?userId=';
  static final String _getSlNo = '$baseUrl/getSlNo?';
  static final String _getUsersByRole = '$baseUrl/getUsersByRole?roleName=';
  static final String _getUsersByRoles = '$baseUrl/getUsersByRoles?roleNames=';
  static final String _getQualification =
      '$baseUrl$v2/getOrganisation?name=GUARD_QUALIFICATIONS';
  static final String _getUsers = '$baseUrl/getUsers?roleName=ATOM_STATIC_USER';

  static final String _createOrganisation = '$baseUrl/createOrganisation?';
  static final String _createUser = '$baseUrl/createUser?';
  static final String _getDashboardChart = '$baseUrl/getDashboard?module=';

  static final String _updateRecordStatus = '$baseUrl/updateStatus/';

  static final String _getLocations = '$baseUrl/getLocations';
  static final String _getStatusesByModuleId = '$baseUrl/getStatus?';
  static final String _getModuleAccessByUserRole =
      '$baseUrl/getModuleAccessByUserRole?';
  static final String _unlock = '$baseUrl/unlock';
  static final String _logout = '$baseUrl/logout';

  static const String exportDetailPagePDF = 'exportDeatilPagePDF?id=';
  static final String _getPassNo = '$baseUrl/getActivePassInfo?passType=';
  static final String _getPassType = '$baseUrl/getPassType?passType=';
  static final String _getPassValidUntil = '$baseUrl/getPassValidUntil?';
  static final String _getGroup = '$baseUrl/getGroup';

}

class CommonServices {
  Future<dynamic> getUiLabels(
      {required String language,
      required String moduleCode,
      BuildContext? context,
      f}) async {
    String url =
        '${CommonApis._getUiLabels}locale=$language&module=$moduleCode';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return response;
  }

  Future<List<Organisation>> getOrganisations({
    required String name,
    int? filter,
    BuildContext? context,
  }) async {
    String url =
        '${CommonApis._getOrganisations}$name&noRole=true&filter=${filter ?? ''}';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    if (response == null || response['dimension'] == null) {
      return [];
    }
    return List<Organisation>.from(
        response['dimension'].map((x) => Organisation.fromJson(x)));
  }

  // Future<Locations> getRegionsWithLocations({
  //   required String name,
  //   BuildContext? context,
  //   int? filter,
  // }) async {
  //   String url = '${CommonApis._getOrganisations}$name&filter=${filter ?? ''}';
  //   final response = await BaseApiService().getRequest(
  //     url: url,
  //   );
  //   return Locations.fromJson(response);
  // }

  Future<Locations> getRegionsWithLocations({
    @Deprecated('this parameter is not required.')
    required String name, // TODO: Remove this parameter
    BuildContext? context,
    int? filter,
    bool? isSezLocations = false,
  }) async {
    String url = '${CommonApis._getLocationsNew}$isSezLocations';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return Locations.fromJson(response);
  }

  Future<DayPassReason> getDayPassreason({
    required String name,
    BuildContext? context,
  }) async {
    String url = '${CommonApis._getOrganisations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return DayPassReason.fromJson(response);
  }

  Future<VendorPassReason> getVendorPassReason({
    required String name,
    BuildContext? context,
  }) async {
    String url = '${CommonApis._getOrganisations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return VendorPassReason.fromJson(response);
  }

  Future<EmployeeDepartments> getDepartments({
    required String name,
  }) async {
    String url = '${CommonApis._getOrganisations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return EmployeeDepartments.fromJson(response);
  }

  Future<Vendors> getVendors({
    required String name,
  }) async {
    String url = '${CommonApis._getOrganisations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return Vendors.fromJson(response);
  }

  Future<KeyType> getKeyType({
    required String name,
  }) async {
    String url = '${CommonApis._getOrganisations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return KeyType.fromJson(response);
  }

  Future<TypeOfServices> getTypeOfService({
    required String name,
  }) async {
    String url = '${CommonApis._getOrganisations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return TypeOfServices.fromJson(response);
  }

  Future<GetArticleType> getArticleType({
    required String name,
  }) async {
    String url = '${CommonApis._getArticleType}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GetArticleType.fromJson(response);
  }

  Future<User> getUserDetails({
    required String userId,
  }) async {
    String url = '${CommonApis._getUserDetails}$userId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return User.fromJson(response);
  }

  Future<SerialNumberModel> getSlNo({
    required String locationId,
    required String moduleCode,
    BuildContext? context,
  }) async {
    String url =
        '${CommonApis._getSlNo}locationId=$locationId&moduleCode=$moduleCode';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    log('--response--${response.toString()}----');

    return SerialNumberModel.fromJson(response);
  }

  Future<SerialNumberModel> getKLDSlNo({
    required String locationId,
    required String moduleCode,
    required int? kmId,
    BuildContext? context,
    int? type,
  }) async {
    String url =
        '${CommonApis._getSlNo}locationId=$locationId&moduleCode=$moduleCode&type=$type&kmId=$kmId';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    log('--response--${response.toString()}----');

    return SerialNumberModel.fromJson(response);
  }

  Future<Analyst> getUsersByRole({
    required String roleName,
    int? locationId,
  }) async {
    String url = '${CommonApis._getUsersByRole}$roleName';
    if (locationId != null) {
      url = '$url&locationId=$locationId';
    }
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return Analyst.fromJson(response);
  }

  Future<List<BaseUser>> getBaseUsers({
    required String? roleName,
    int? locationId,
     bool? isDbUser,
    dynamic search
  }) async {
    String url = '${CommonApis._getUsersByRole}$roleName';
    if (locationId != null) {
      url = '$url&locationId=$locationId';
    }
    if (isDbUser != null) {
      url = '$url&isDbUser=$isDbUser';
    }
    log("isDbUser $isDbUser");
    if (search != null) {
      url = '$url&search=$search';
    }
    final response = await BaseApiService().getRequest(
      url: url,
    );

    if (response == null || response[roleName] == null) {
      return [];
    }
    return List<BaseUser>.from(
        response[roleName].map((x) => BaseUser.fromJson(x)));
  }

  Future<List<BaseUser>> getBaseUsersByRoles({
    required String roleNames,
    int? locationId,
    bool? isDbUser,
    dynamic search
  }) async {
    String url = '${CommonApis._getUsersByRoles}$roleNames';
    if (locationId != null) {
      url = '$url&locationId=$locationId';
    }
    if (isDbUser != null) {
      url = '$url&isDbUser=$isDbUser';
    }
    // if (search != null) {
    //   url = '$url&search=$search';
    // }
    final response = await BaseApiService().getRequest(
      url: url,
    );
    // if (response == null || response[roleNames] == null) {
    //   return [];
    // }
    return List<BaseUser>.from(
        response['users'].map((x) => BaseUser.fromJson(x)));
  }

  Future<GetDepositor> getAtomStaticUsers({
    required String roleName,
    int? locationId,
    bool? isDbUser,
    int? search,
  }) async {
    String url = '${CommonApis._getUsersByRole}$roleName';
    if (locationId != null) {
      url = '$url&locationId=$locationId';
    }
    if (isDbUser != null) {
      url = '$url&isDbUser=$isDbUser';
    }
    if (search != null) {
      url = '$url&search=$search';
    }
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return GetDepositor.fromJson(response);
  }

  Future<AddEntities> getEntities({
    required String name,
  }) async {
    String url = '${CommonApis._getOrganisations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return AddEntities.fromJson(response);
  }

  Future<AddQualifications> getQualification({
    required String name,
  }) async {
    String url = CommonApis._getQualification;
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return AddQualifications.fromJson(response);
  }

  Future<List<User>> getUsers() async {
    String url = CommonApis._getUsers;
    final response = await BaseApiService().getRequest(
      url: url,
    );

    return List<User>.from(response.map((x) => User.fromJson(x)));
  }

  Future<Organisation> createOrganisation({
    required String name,
    String? keyname,
    required String orgName,
    BuildContext? context,
  }) async {
    final String url =
        "${CommonApis._createOrganisation}name=$name&orgName=$orgName&keyname=$keyname";
    final response =
        await BaseApiService().postRequest(url: url, requestedData: {});
    return Organisation.fromJson(response);
  }

  Future<User> createUser({
    required String firstName,
    required String lastName,
    required String email,
    required String employeeId,
    required String role,
    required int locationId,
    BuildContext? context,
  }) async {
    final String url =
        "${CommonApis._createUser}firstName=$firstName&lastName=$lastName&email=$email&role=$role&locationId=$locationId&employeeId=$employeeId";
    final response =
        await BaseApiService().postRequest(url: url, requestedData: {});
    return User.fromJson(response);
  }

  Future<List<PieChartData>> getDashboardChart({required String module}) async {
    String url = CommonApis._getDashboardChart + module;
    Map<String, dynamic> response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );

    // Convert response to List<PieChartData>
    List<PieChartData> pieChartDataList = [];
    response.forEach((key, value) {
      double count = (value is int) ? value.toDouble() : 0.0;
      pieChartDataList.add(
        PieChartData(key, count, Utils().getRandomColor()),
      );
    });

    return pieChartDataList;
  }

  Future<void> updateRecordStatus({
    required String id,
    required String module,
    int? status = -1,
    int? type,
    int? aps,
    BuildContext? context,
  }) async {
    String url =
        '${CommonApis._updateRecordStatus}$id?module=$module&status=$status&type=$type&aps=$aps';
    await BaseApiService().patchRequest(
      url: url,
    );
    return;
  }

  /// id '2' is for Fetching only Regions
  /// otherwise pass Region Id to get Locations By Region Id
  Future<List<Organisation>> getRegionsOrLocationsByRegionId({
    int? id,
    BuildContext? context,
  }) async {
    String url = CommonApis._getLocations;
    if(id !=null) {
      url = '$url?id=$id';
    }
    final response = await BaseApiService().getRequest(
      url: url,
    );

    if (response == null) {
      return [];
    }
    return List<Organisation>.from(
        response.map((x) => Organisation.fromJson(x)));
  }

  Future<List<Organisation>> getStatusesByModuleId({
    required String module,
    int? filter, // For Pass Management Status
    BuildContext? context,
  }) async {
    String url =
        '${CommonApis._getStatusesByModuleId}module=$module&filter=${filter ?? ''}';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    if (response == null) {
      return [];
    }
    return List<Organisation>.from(
        response.map((x) => Organisation.fromJson(x)));
  }

  Future<bool> getModuleAccessByUserRole({
    required String moduleCode,
    BuildContext? context,
    int? filter,
  }) async {
    String url =
        '${CommonApis._getModuleAccessByUserRole}moduleCode=$moduleCode';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return response['hasWritePermission'] as bool;
  }

  Future<void> unlock() async {
    final String url = CommonApis._unlock;
    await BaseApiService().postRequest(url: url, requestedData: {});
  }

  Future<void> logout() async {
    final String url = CommonApis._logout;
    await BaseApiService().postRequest(url: url, requestedData: {});
  }

  Future<DayPassNumberLists> getPassNo({
    required int passType,
    required int locationId,
    required bool isDwsPass,
  }) async {
    String url = '${CommonApis._getPassNo}$passType&locationId=$locationId&isDwsPass=$isDwsPass';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return DayPassNumberLists.fromJson(response);
  }

  Future<List<Organisation>> getPassType({
    required int passType,
    required int locationId,
  }) async {
    String url = '${CommonApis._getPassType}$passType&locationId=$locationId';
    final response = await BaseApiService().getRequest(
      url: url,
    );

    if (response == null) {
      return [];
    }
    return List<Organisation>.from(
        response.map((x) => Organisation.fromJson(x)));
  }

  Future<String> getPassValidUntil({required int passCategory}) async {
    final String url = '${CommonApis._getPassValidUntil}category=$passCategory';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return response['date'];
  }

  Future<LeoDepartments> getLeoDepartments({
    required String name,
  }) async {
    String url = '${CommonApis._getOrganisations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return LeoDepartments.fromJson(response);
  }

  Future<LeoPurposeVisit> getLeoVisitPurpose({
    required String name,
  }) async {
    String url = '${CommonApis._getOrganisations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return LeoPurposeVisit.fromJson(response);
  }

  Future<LeoDepartments> getLeoVisitDepartment({
    required String name,
  }) async {
    String url = '${CommonApis._getOrganisations}$name';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return LeoDepartments.fromJson(response);
  }

  Future<DistributionGroupModel> getLeoDistributionGroup() async {
    String url = CommonApis._getGroup;
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return DistributionGroupModel.fromJson(response);
  }

}

