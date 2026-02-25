// import 'package:db_atom/src/configurations/base_api_service.dart';
// import 'package:db_atom/src/configurations/environment_config.dart';
// import 'package:db_atom/src/features/material_movement/models/material_items_model.dart';
// import 'package:db_atom/src/features/material_movement/models/material_movement_model.dart';
// import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';
// import 'package:db_atom/src/features/material_movement/models/requestModels/material_movement_request.dart';
// import 'package:db_atom/src/models/base_filter_model.dart';
//
// import '../../../models/responseModels/generic_response.dart';
//
// class Apis {
//   static final String baseUrl = Environment().config.apiHost;
//
//   static final String _getMaterialMovements = '$baseUrl/getMMList?';
//
//   static final String _getMaterialMovement = '$baseUrl/getMMById';
//
//   static final String _createMaterialMovement = '$baseUrl/createMtrlMvmt';
//   static final String _getMaterialItems = '$baseUrl/getMMItemsByMMId';
// }
//
// class MaterialMovementServices {
//   Future<MaterialMovementsModel> getMaterialMovements({
//     required String startPosition,
//     required String maximumRecords,
//     required int mmType,
//   }) async {
//     String url =
//         '${Apis._getMaterialMovements}mmType=$mmType&startPos=$startPosition&maxResults=$maximumRecords';
//     var response = await BaseApiService().getRequest(
//       isAuthenticated: true,
//       url: url,
//     );
//     return MaterialMovementsModel.fromJson(response);
//   }
//
//   Future<MaterialMovementsModel> getMaterialMovementsWithFilters({
//     required String startPosition,
//     required String maximumRecords,
//     required int mmType,
//     required BaseFilterModel filters,
//     bool? returnable,
//   }) async {
//     String url =
//         '${Apis._getMaterialMovements}mmType=$mmType&startPos=$startPosition&maxResults=$maximumRecords';
//     if (returnable != null) {
//       url = '$url&returnable=$returnable';
//     }
//     var response = await BaseApiService().postRequest(
//       requestedData: filters.toJson(),
//       isAuthenticated: true,
//       url: url,
//     );
//     return MaterialMovementsModel.fromJson(response);
//   }
//
//   Future<MaterialMovementModel> getById(int id) async {
//     final String url = '${Apis._getMaterialMovement}/$id';
//     final response = await BaseApiService().getRequest(
//       url: url,
//     );
//     return MaterialMovementModel.fromJson(response);
//   }
//
//   /// Create Services
//   Future<GenericResponse> createMaterialMovement({
//     required MaterialMovementRequest body,
//     required int flow,
//   }) async {
//     // var userId = await SharedPrefs.getUserId();
//     final String url = "${Apis._createMaterialMovement}?flow=$flow";
//     final response = await BaseApiService().postRequest(
//       url: url,
//       requestedData: body.toJson(),
//     );
//     return GenericResponse.fromJson(response);
//   }
//
//
//   // Future<MaterialMovementItemsModel> getItems(int id) async {
//   //   final String url = '${Apis._getMaterialItems}/$id';
//   //   final response = await BaseApiService().getRequest(
//   //     url: url,
//   //   );
//   //   return MaterialMovementItemsModel.fromJson(response);
//   // }
// }
//


import 'dart:developer';

import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/material_movement/models/material_movement_model.dart';
import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';
import 'package:db_atom/src/features/material_movement/models/requestModels/material_movement_request.dart';
import 'package:db_atom/src/models/base_filter_model.dart';

import '../../../../index.dart';
import '../../../models/responseModels/generic_response.dart';
import '../models/approval_model.dart';
import '../models/material_items_model.dart';
import '../models/material_items_response_model.dart';
import '../models/requestModels/approval_request.dart';
import '../models/requestModels/material_items_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getMaterialMovements = '$baseUrl/getMMList?';

  static final String _getMaterialMovement = '$baseUrl/getMMById';

  static final String _createMaterialMovement = '$baseUrl/createMtrlMvmt';
  static final String _createMaterialItems= '$baseUrl/createMMItem';
  static final String _getMaterialItemsListById = '$baseUrl/getMMItemsByMMId/';
  static final String _deleteRecordsById= '$baseUrl/deleteMMItem';
  static final String _getMaterialById= '$baseUrl/getMMItemById';
  static final String _getMaterialApprovalById= '$baseUrl/mmApprovalForm';

  static final String _createMaterialApproval= '$baseUrl/mmApprovalDecision';

}

class MaterialMovementServices {
  Future<MaterialMovementsModel> getMaterialMovements({
    required String startPosition,
    required String maximumRecords,
    required int mmType,
  }) async {
    String url =
        '${Apis._getMaterialMovements}mmType=$mmType&startPos=$startPosition&maxResults=$maximumRecords';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    debugPrint('url: $url');
    print('url: $url');
    return MaterialMovementsModel.fromJson(response);
  }

  Future<MaterialMovementsModel> getMaterialMovementsWithFilters({
    required String startPosition,
    required String maximumRecords,
    required int mmType,
    required BaseFilterModel filters,
    bool? returnable,
  }) async {
    String url =
        '${Apis._getMaterialMovements}mmType=$mmType&startPos=$startPosition&maxResults=$maximumRecords';
    if (returnable != null) {
      url = '$url&returnable=$returnable';
    }
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return MaterialMovementsModel.fromJson(response);
  }

  Future<MaterialMovementModel> getById(int id) async {
    final String url = '${Apis._getMaterialMovement}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return MaterialMovementModel.fromJson(response);
  }

  /// Create Services
  Future<GenericResponse> createMaterialMovement({
    required MaterialMovementRequest body,
    required int flow,
  }) async {
    // var userId = await SharedPrefs.getUserId();
    final String url = "${Apis._createMaterialMovement}?flow=$flow";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

  /// Create Services
  // Future<GenericResponse> createMaterialItems({
  //   required MaterialItemsRequest body,
  //   required bool isSubmit,
  //   required String id,
  // }) async {
  //   // var userId = await SharedPrefs.getUserId();
  //   final String url =
  //       "${Apis._createMaterialItems}/$id";
  //   final response = await BaseApiService().postRequest(
  //     url: url,
  //     requestedData: body.toJson(),
  //   );
  //   return GenericResponse.fromJson(response);
  // }


  Future<GenericResponse> createMaterialItems({
    required MaterialItemsRequest body,
    required String id,
  }) async {
    // var userId = await SharedPrefs.getUserId();
    final String url =
        "${Apis._createMaterialItems}/$id";
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }


  // Future<MaterialMovementItem> getMMListById(int id) async {
  //   final String url = '${Apis._getMaterialItemsListById}/$id';
  //   final response = await BaseApiService().getRequest(
  //     url: url,
  //   );
  //   return MaterialMovementItem.fromJson(response);
  // }

  // Future<MaterialMovementItem> getMMListById(num id) async {
  //   final String url = '${Apis._getMaterialItemsListById}/$id';
  //   final response = await BaseApiService().getRequest(
  //     url: url,
  //   );
  //   return MaterialMovementItem.fromJson(response);


  Future<List<MaterialMovementItem>> getViolationPenaltyList({
    required String id,
  }) async {
    String url = '${Apis._getMaterialItemsListById}$id';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return List<MaterialMovementItem>.from(
        response.map((x) => MaterialMovementItem.fromJson(x)));
  }

  Future<MaterialMovementItem> getVPById(num id) async {
    final String url = '${Apis._getMaterialById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return MaterialMovementItem.fromJson(response);
  }

  Future<GenericResponse> deleteVpById(int id) async {
    final String url = '${Apis._deleteRecordsById}/$id';
    final response = await BaseApiService().deleteRequest(
      url: url,
    );
    return GenericResponse.fromJson(response);
  }

  Future<ApprovalModel> getApprovalById(num id) async {
    final String url = '${Apis._getMaterialApprovalById}?apStepId=$id';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return ApprovalModel.fromJson(response);
  }




  Future<GenericResponse> createMaterialApproval({
    required MaterialApprovalRequest body,
  }) async {
    // var userId = await SharedPrefs.getUserId();
    final String url =
        Apis._createMaterialApproval;
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }



}
