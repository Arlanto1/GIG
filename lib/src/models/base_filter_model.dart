import 'package:db_atom/index.dart';

class BaseFilterModel {
  FilterCriteria? filterCriteria;

  BaseFilterModel({
    this.filterCriteria,
  });

  BaseFilterModel.fromJson(Map<String, dynamic> json)
      : filterCriteria =
            (json['filterCriteria'] as Map<String, dynamic>?) != null
                ? FilterCriteria.fromJson(
                    json['filterCriteria'] as Map<String, dynamic>)
                : null;

  Map<String, dynamic> toJson() => {'filterCriteria': filterCriteria?.toJson()};
}

class FilterCriteria {
  String? all;
  Filters? filters;

  FilterCriteria({
    this.all,
    this.filters,
  });

  FilterCriteria.fromJson(Map<String, dynamic> json)
      : all = json['all'] as String?,
        filters = (json['filters'] as Map<String, dynamic>?) != null
            ? Filters.fromJson(json['filters'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'all': all, 'filters': filters?.toJson()};
}

class Filters {
  int? id;
  int? locationId;
  int? regionId;
  String? fromDate;
  String? toDate;
  String? createdBy;
  int? status;
  String? foundDate;

  Filters({
    this.id,
    this.locationId,
    this.regionId,
    this.fromDate,
    this.toDate,
    this.createdBy,
    this.status,
    this.foundDate
  });

  Filters.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        locationId = json['locationId'] as int?,
        regionId = json['regionId'] as int?,
        fromDate = json['fromDate'] as String?,
        toDate = json['toDate'] as String?,
        createdBy = json['createdBy'] as String?,
        status = json['status'] as int?,
        foundDate= json['foundDate'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'locationId': locationId,
        'regionId': regionId,
        'fromDate': fromDate,
        'toDate': toDate,
        'createdBy': createdBy,
        'status': status,
       'foundDate':foundDate
      };
}

class CommonFilters {
  final List<Organisation>? regions;
  final List<Organisation>? statuses;

  CommonFilters({required this.regions, required this.statuses});
}
