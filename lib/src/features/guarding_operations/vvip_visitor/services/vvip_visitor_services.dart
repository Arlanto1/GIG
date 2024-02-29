import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';

import '../../../../models/responseModels/generic_response.dart';
import '../models/requestModels/vvip_visitor_request.dart';
import '../models/requestModels/vvip_visitors_record_request.dart';
import '../models/vvip_visitor_record_model.dart';
import '../models/vvip_visitor_records_response.dart';
import '../models/vvip_visitor_response_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getVipVisitorRecordsListByType =
      '$baseUrl/getVipListById/';

  static final String _getVVIP = '$baseUrl/getVipList?';

  static final String _getStaffCategoriesValues =
      '$baseUrl/getStaffCategAndViolations';

  static final String _getById = '$baseUrl/getVipById';

  static final String _createGeneralInformation = '$baseUrl/createVipGi?';

  static final String _getVVIPVisitorsById = '$baseUrl/getVipVisitorById';
  static final String _deleteVVIPVisitorsRecordById = '$baseUrl/deleteVipVisitor';

  static final String _createVVIPVisitorsRecord = '$baseUrl/createVipVisitors';
}

class VVIPVisitorServices {
  Future<List<VIVPVisitorRecordModel>> getVVIPVisitorRecordsList({
    required String id,
  }) async {
    String url = '${Apis._getVipVisitorRecordsListByType}$id';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return List<VIVPVisitorRecordModel>.from(
        response.map((x) => VIVPVisitorRecordModel.fromJson(x)));
  }

  Future<VVIPVisitorResponseModel> getGVVIP({
    required String startPosition,
    required String maximumRecords,
  }) async {
    String url =
        '${Apis._getVVIP}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return VVIPVisitorResponseModel.fromJson(response);
  }

  Future<VIVPVisitorModel> getGVipById(int id) async {
    final String url = '${Apis._getById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return VIVPVisitorModel.fromJson(response);
  }

  /// Create Services
  Future<GenericResponse> createGIVVIPVisitor({
    required VVIPVisitorRequest body,
    required bool isSubmit,
  }) async {
    // var userId = await SharedPrefs.getUserId();
    final String url = "${Apis._createGeneralInformation}isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  Future<VVIPVisitorRecordsResponseModel> getVp({
    required String startPosition,
    required String maximumRecords,
  }) async {
    String url =
        '${Apis._getVVIP}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return VVIPVisitorRecordsResponseModel.fromJson(response);
  }

  Future<VIVPVisitorRecordModel> getVIPById(num id) async {
    final String url = '${Apis._getVVIPVisitorsById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return VIVPVisitorRecordModel.fromJson(response);
  }

  Future<GenericResponse> deleteVipById(int id) async {
    final String url = '${Apis._deleteVVIPVisitorsRecordById}/$id';
    final response = await BaseApiService().deleteRequest(
      url: url,
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> createVVIPVisitorsRecord({
    required VVIPVisitorRecordRequest body,
    required bool isSubmit,
    required String id,
  }) async {
    // var userId = await SharedPrefs.getUserId();
    final String url =
        "${Apis._createVVIPVisitorsRecord}/$id?isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }
}
