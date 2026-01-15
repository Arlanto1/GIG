class LocationModel {
  final bool? success;
  final Location? data;

  LocationModel({
    this.success,
    this.data,
  });

  LocationModel.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Location.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'data' : data?.toJson()
  };
}

class Location {
  final List<States>? states;
  final int? total;

  Location({
    this.states,
    this.total,
  });

  Location.fromJson(Map<String, dynamic> json)
      : states = (json['states'] as List?)?.map((dynamic e) => States.fromJson(e as Map<String,dynamic>)).toList(),
        total = json['total'] as int?;

  Map<String, dynamic> toJson() => {
    'states' : states?.map((e) => e.toJson()).toList(),
    'total' : total
  };
}

class States {
  final String? name;
  final String? code;
  final String? districts;
  final String? talukas;
  final String? villages;

  States({
    this.name,
    this.code,
    this.districts,
    this.talukas,
    this.villages,
  });

  States.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        code = json['code'] as String?,
        districts = json['districts'] as String?,
        talukas = json['talukas'] as String?,
        villages = json['villages'] as String?;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'code' : code,
    'districts' : districts,
    'talukas' : talukas,
    'villages' : villages
  };
}