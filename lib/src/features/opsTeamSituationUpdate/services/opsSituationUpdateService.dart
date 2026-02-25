import 'dart:developer';

import 'package:db_atom/index.dart';
import '../model/opsTeamSitutationModel.dart';
import '../model/requestmodel/buildingRepRequestModel.dart';
import '../model/requestmodel/lsmLocUpdateRequestModel.dart';
import '../model/requestmodel/opsTeamSituationRequestModel.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getLSMById = '$baseUrl/getLsmSUById';
  static final String _createLSMGi = '$baseUrl/saveLsmSU?';
  static final String _getBuildingReportById = '$baseUrl/getBuildOccReportById';
  static final String _createBuildingRep = '$baseUrl/createLsmReport/';
  static final String _getDBLocUpdateById = '$baseUrl/getDBLocUpdateById';
  static final String _createLocUpdate = '$baseUrl/createLsmUpdate/';
  static final String _dltDBLocUpdateById = '$baseUrl/deleteLsmUpdate';
  static final String _dltBuildingReportById  = '$baseUrl/deleteLsmReport';

}

class OpsSituationUpdateServices {

  Future<LsmSituationalModel> getLSMById(String id) async {
    final String url = '${Apis._getLSMById}/$id';
    var response = await BaseApiService().getRequest(
      url: url,
    );
    return LsmSituationalModel.fromJson(response);
  }

  Future<GenericResponse> createLSM({
    required LsmSituationModelRequest body,
    required bool isSubmit,
  }) async {
    final String url =
        "${Apis._createLSMGi}isSubmit=$isSubmit";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }


  Future<LsmOccupancyReport> getBuildingReportById(String id) async {
    final String url = '${Apis._getBuildingReportById}/$id';
    var response = await BaseApiService().getRequest(
      url: url,
    );
    return LsmOccupancyReport.fromJson(response);
  }


  Future<GenericResponse> createBuildingRepo({
    required BuildingRepModelRequest body,
    required int id,

  }) async {
    final String url =
        "${Apis._createBuildingRep}$id";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> dltBuildingReportById(String id) async {
    final String url = '${Apis._dltBuildingReportById}/$id';
    var response = await BaseApiService().deleteRequest(
      url: url,
    );
    return GenericResponse.fromJson(response);
  }

  Future<LsmLocationUpdate> getDBLocUpdateById(String id) async {
    final String url = '${Apis._getDBLocUpdateById}/$id';
    var response = await BaseApiService().getRequest(
      url: url,
    );
    return LsmLocationUpdate.fromJson(response);
  }



  Future<GenericResponse> createLocUpdate({
    required LsmLocUpdateModelRequest body,
    required int id,

  }) async {
    final String url =
        "${Apis._createLocUpdate}$id";
    log("API URL------2-2-2-2-2-: $url");
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }


  Future<GenericResponse> dltDBLocUpdateById(String id) async {
    final String url = '${Apis._dltDBLocUpdateById}/$id';
    var response = await BaseApiService().deleteRequest(
      url: url,
    );
    return GenericResponse.fromJson(response);
  }

}
