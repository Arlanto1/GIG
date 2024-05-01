import 'package:db_atom/index.dart';

class DutyPostRequest {
  final DutyPostModel? dutyPost;

  DutyPostRequest({
    this.dutyPost,
  });

  DutyPostRequest.fromJson(Map<String, dynamic> json)
      : dutyPost = (json['shiftDutyPost'] as Map<String, dynamic>?) != null
            ? DutyPostModel.fromJson(
                json['shiftDutyPost'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'shiftDutyPost': dutyPost?.toJson()};
}
