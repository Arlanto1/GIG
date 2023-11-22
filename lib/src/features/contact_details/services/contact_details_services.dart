import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/contact_details/models/contact_details_list_response_model.dart';
import 'package:db_atom/src/features/contact_details/models/contact_info.dart';
import 'package:db_atom/src/features/contact_details/models/requestModels/contact_details_gi_request.dart';
import '../models/contacts_list_response_model.dart';
import '../models/requestModels/contacts_request.dart';
import '../../../models/responseModels/generic_response.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getContactListByType = '$baseUrl/getGcdTypeById/';
  static final String _getGcd = '$baseUrl/getGcdList?';

  static final String _getById = '$baseUrl/getGcdGiById';

  static final String _createGeneralInformation = '$baseUrl/createCDGI?';

  static final String _getContactDetailsById = '$baseUrl/getCntInfoById';

  static final String _createContacts = '$baseUrl/createCDGI?';
}

class ContactDetailsServices {

  Future<ContactsListModel> getContactListByType({
    required String id,
    required String type,
    required String startPosition,
    required String maximumRecords,
  }) async {
    String url =
        '${Apis._getContactListByType}$id?type=$type';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return ContactsListModel.fromJson(response);
  }

  Future<ContactDetailsListResponseModel> getGcd({
    required String startPosition,
    required String maximumRecords,
  }) async {
    String url =
        '${Apis._getGcd}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return ContactDetailsListResponseModel.fromJson(response);
  }

  Future<ContactDetailModel> getGcdById(int id) async {
    final String url = '${Apis._getById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return ContactDetailModel.fromJson(response);
  }

  /// Create Services
  Future<GenericResponse> createContactDetailsGi({
    required ContactDetailsGiRequest body,
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


  Future<ContactListResponseModel> getCd({
    required String startPosition,
    required String maximumRecords,
  }) async {
    String url =
        '${Apis._getGcd}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return ContactListResponseModel.fromJson(response);
  }

  Future<ContactInfo> getCdById(int id) async {
    final String url = '${Apis._getContactDetailsById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return ContactInfo.fromJson(response);
  }

  /// Create Services
  Future<GenericResponse> createContactDetailsCd({
    required ContactsRequest body,
    required bool isSubmit,
  }) async {
    // var userId = await SharedPrefs.getUserId();
    final String url = "${Apis._createContacts}isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }
}
