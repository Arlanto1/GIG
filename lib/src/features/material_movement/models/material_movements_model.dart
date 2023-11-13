import 'dart:developer';

import 'package:db_atom/src/features/material_movement/models/material_movement_model.dart';

class MaterialMovementsModel {
  List<MaterialMovementModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  MaterialMovementsModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  MaterialMovementsModel.fromJson(Map<String, dynamic> json) {
    List list = json['list'] as List;
    List<MaterialMovementModel> modellist = list.map((e) {
      try {
        return MaterialMovementModel.fromJson(e as Map<String, dynamic>);
      } catch (e) {
        // Handle the exception, you can log it or take any appropriate action.
        // For example, you can log the error and return a default value.
        print('Error parsing MaterialMovementModel: $e');
        return MaterialMovementModel(); // Return a default instance of MaterialMovementModel.
      }
    }).toList();

    log('--modellist---${modellist.length}');

    try {
      if (json['list'] is List) {
        items = (json['list'] as List)
            .map((dynamic e) =>
                MaterialMovementModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        // Handle the case where 'list' is not a List
        items = [];
      }
      totalCount = json['totalCount'] as int?;
      currentPageNo = json['currentPageNo'] as int?;
      totalPageCount = json['totalPageCount'] as int?;
    } catch (e) {
      // Print debug information
      log('Error parsing MaterialMovementsModel: $e');
      log('json: $json');
    }
  }

  Map<String, dynamic> toJson() => {
        'list': items?.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPageNo': currentPageNo,
        'totalPageCount': totalPageCount
      };
}

