import 'package:db_atom/index.dart';
import '../models/contacts_list_response_model.dart';
import '../models/requestModels/contacts_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getContactListByType = '$baseUrl/getGcdTypeById/';
  static final String _getGcd = '$baseUrl/getGcdList?';

  static final String _getById = '$baseUrl/getGcdGiById';

  static final String _createGeneralInformation = '$baseUrl/createCDGI?';

  static final String _getContactDetailsById = '$baseUrl/getCntInfoById';
  static final String _deleteContactDetailsById = '$baseUrl/deleteContactInfo';

  static final String _createContactRecord = '$baseUrl/createContactInfo?';

  //static final String _deleteContacts = '$baseUrl/deleteContactInfo';
}

class ContactDetailsServices {
  Future<ContactsListModel> getContactListByType({
    required String id,
    required String type,
  }) async {
    String url = '${Apis._getContactListByType}$id?type=$type';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return ContactsListModel.fromJson(response);
  }

  Future<ContactDetailsListResponseModel> getGcd({
    required String startPosition,
    required String maximumRecords,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis._getGcd}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return ContactDetailsListResponseModel.fromJson(response);
  }

  Future<ContactDetailsListResponseModel> getGcdWithFilters({
    required String startPosition,
    required String maximumRecords,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis._getGcd}startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
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

  Future<ContactRecord> getCdById(int id) async {
    final String url = '${Apis._getContactDetailsById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return ContactRecord.fromJson(response);
  }

  Future<GenericResponse> deleteCdById(int id) async {
    final String url = '${Apis._deleteContactDetailsById}/$id';
    final response = await BaseApiService().deleteRequest(
      url: url,
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> createContactRecord({
    required ContactRecordRequest body,
    required bool isSubmit,
  }) async {
    // var userId = await SharedPrefs.getUserId();
    final String url = "${Apis._createContactRecord}isSubmit=$isSubmit";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  // Future<ContactRecord> deleteContacts(int id) async {
  //   final String url = '${Apis._deleteContacts}/$id';
  //   final response = await BaseApiService().getRequest(
  //     url: url,
  //   );
  //   return ContactRecord.fromJson(response);
  // }
}
