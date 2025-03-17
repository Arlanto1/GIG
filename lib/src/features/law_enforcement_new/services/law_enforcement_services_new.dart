import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/law_enforcement_new/models/law_enforcement_model_new.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/getLawEnfrcmntList?';
  static final String _getById = '$baseUrl/getLawEnfrcmnt';
  static final String _create = '$baseUrl/saveLawEnfrcmnt';
}

class LawEnforcementServicesNew {
  final endpoint = Environment().config.apiHost;

  Future<LawEnforcementResponseModel> getListWithFilters({
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
    return LawEnforcementResponseModel.fromJson(response);
  }

  Future<LawEnforcementModelNew> getById(
      int id,
      ) async {
    final String url = '${Apis._getById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
      isAuthenticated: true,
    );

    return LawEnforcementModelNew.fromJson(response);
  }

  Future<GenericResponse> createLawEnforcement({
    required LawEnforcementRequestBody body,
    required bool isSubmit,
  }) async {
    final String url = "${Apis._create}&isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  // Future<List<LawVisitingOfficial>> getLeoVisitingOfficials({
  //   required int id,
  // }) async {
  //   String url = '${Apis._getLeoVisitingOfficials}$id';
  //   final response = await BaseApiService().getRequest(
  //     url: url,
  //   );
  //
  //   if (response == null) {
  //     return [];
  //   }
  //   return List<LawVisitingOfficial>.from(
  //       response.map((x) => LawVisitingOfficial.fromJson(x)));
  // }

  // Future<LawVisitingOfficial> getLeoVisitingOfficialById({
  //   required int id,
  // }) async {
  //   final String url = '${Apis._getLeoVisitingOfficialById}$id';
  //   final response = await BaseApiService().getRequest(
  //     url: url,
  //     isAuthenticated: true,
  //   );
  //
  //   return LawVisitingOfficial.fromJson(response);
  // }
  //
  // Future<GenericResponse> createVisitingOfficial({
  //   required int parentId,
  //   required LawVisitingOfficialRequest body,
  // }) async {
  //   // var username = await SharedPrefs.getUsername();
  //   final String url =
  //       "${Apis._createVisitingOfficial}$parentId?isSubmit=false";
  //   final response = await BaseApiService().postRequest(
  //     url: url,
  //     requestedData: body.toJson(),
  //   );
  //   return GenericResponse.fromJson(response);
  // }
  //
  // Future<GenericResponse> deleteVisitingOfficial(int id) async {
  //   final String url = '${Apis._deleteVisitingOfficial}$id';
  //   final response = await BaseApiService().deleteRequest(
  //     url: url,
  //   );
  //   return GenericResponse.fromJson(response);
  // }
}
