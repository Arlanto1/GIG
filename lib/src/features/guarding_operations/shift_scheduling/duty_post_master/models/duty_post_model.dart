import '../../../../../../index.dart';

class DutyPostModel {
  int? id;
  String? name;
  List<Rank>? ranks;

  DutyPostModel({
    this.id,
    this.name,
    this.ranks,
  });

  DutyPostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        ranks = (json['ranks'] as List?)
            ?.map((dynamic e) => Rank.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'ranks': ranks?.map((e) => e.toJson()).toList()};
}

class Rank {
  int? rank;
  List<Shift>? shifts;

  Rank({
    this.rank,
    this.shifts,
  });

  Rank.fromJson(Map<String, dynamic> json)
      : rank = json['rank'] as int?,
        shifts = (json['shifts'] as List?)
            ?.map((dynamic e) => Shift.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'rank': rank, 'shifts': shifts?.map((e) => e.toJson()).toList()};
}

class Shift {
  String? shift;
  int? allowed;
  List<BaseUser>? selectedGuards;
  List<BaseUser>? availableGuards;
  List<Replacement>? replacements;
  dynamic replacement;

  Shift({
    this.shift,
    this.allowed,
    this.selectedGuards,
    this.availableGuards,
    this.replacement,
  });

  Shift.fromJson(Map<String, dynamic> json)
      : shift = json['shift'] as String?,
        allowed = json['allowed'] as int?,
        selectedGuards = (json['selectedGuards'] as List?)
            ?.map((dynamic e) => BaseUser.fromJson(e as Map<String, dynamic>))
            .toList(),
        availableGuards = (json['availableGuards'] as List?)
            ?.map((dynamic e) => BaseUser.fromJson(e as Map<String, dynamic>))
            .toList(),
        replacements = (json['replacements'] as List?)
            ?.map(
                (dynamic e) => Replacement.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'shift': shift,
        'allowed': allowed,
        'selectedGuards': selectedGuards?.map((e) => e.toJson()).toList(),
        'availableGuards': availableGuards?.map((e) => e.toJson()).toList(),
        'replacement': replacement
      };
}

class Replacement {
  final int? id;
  final BaseUser? replacedFor;
  final BaseUser? replacementBy;
  final String? fromDate;
  final String? toDate;
  final int? status;

  Replacement({
    this.id,
    this.replacedFor,
    this.replacementBy,
    this.fromDate,
    this.toDate,
    this.status,
  });

  Replacement.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        replacedFor = (json['replacedFor'] as Map<String, dynamic>?) != null
            ? BaseUser.fromJson(json['replacedFor'] as Map<String, dynamic>)
            : null,
        replacementBy = (json['replacementBy'] as Map<String, dynamic>?) != null
            ? BaseUser.fromJson(json['replacementBy'] as Map<String, dynamic>)
            : null,
        fromDate = json['fromDate'] as String?,
        toDate = json['toDate'] as String?,
        status = json['status'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'replacedFor': replacedFor?.toJson(),
        'replacementBy': replacementBy?.toJson(),
        'fromDate': fromDate,
        'toDate': toDate,
        'status': status
      };
}
