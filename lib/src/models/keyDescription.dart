// import 'package:json_annotation/json_annotation.dart';
//
// // part 'organisation.g.dart';
//
// // @JsonSerializable()
// class KeyDescription {
//   int? id;
//   String? keyDescription;
//   @JsonKey(name: 'keyname')
//   int? noKeys;
//   bool? isSelected;
//
//   KeyDescription({
//     this.id,
//     this.keyDescription,
//     this.noKeys,
//     this.isSelected = false,
//   });
//
//   // factory Organisation.fromJson(Map<String, dynamic> json) => _$OrganisationFromJson(json);
//   //
//   // Map<String, dynamic> toJson() => _$OrganisationToJson(this);
//
//   KeyDescription.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         keyDescription = json['keyDescription'] as String,
//         noKeys = json['noKeys'] as int?;
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'keyDescription': keyDescription,
//     'noKeys': noKeys,
//   };
// }
