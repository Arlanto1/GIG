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
        ranks = (json['ranks'] as List?)?.map((dynamic e) => Rank.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'ranks' : ranks?.map((e) => e.toJson()).toList()
  };
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
        shifts = (json['shifts'] as List?)?.map((dynamic e) => Shift.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'rank' : rank,
    'shifts' : shifts?.map((e) => e.toJson()).toList()
  };
}

class Shift {
  String? shift;
  int? allowed;
  List<Guard>? selectedGuards;
  List<Guard>? availableGuards;
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
        selectedGuards = (json['selectedGuards'] as List?)?.map((dynamic e) => Guard.fromJson(e as Map<String,dynamic>)).toList(),
        availableGuards = (json['availableGuards'] as List?)?.map((dynamic e) => Guard.fromJson(e as Map<String,dynamic>)).toList(),
        replacement = json['replacement'];

  Map<String, dynamic> toJson() => {
    'shift' : shift,
    'allowed' : allowed,
    'selectedGuards' : selectedGuards?.map((e) => e.toJson()).toList(),
    'availableGuards' : availableGuards?.map((e) => e.toJson()).toList(),
    'replacement' : replacement
  };
}

class Guard {
  int? userId;
  String? name;

  Guard({
    this.userId,
    this.name,
  });

  Guard.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'name' : name
  };
}
