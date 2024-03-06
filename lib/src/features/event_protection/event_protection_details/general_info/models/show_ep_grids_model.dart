class ShowEPGridsModel {
  bool? before;
  bool? during;
  bool? after;
  bool? editBefore;
  bool? editDuring;
  bool? editAfter;

  ShowEPGridsModel({
    this.before,
    this.during,
    this.after,
    this.editBefore,
    this.editDuring,
    this.editAfter,
  });

  ShowEPGridsModel.fromJson(Map<String, dynamic> json)
      : before = json['before'] as bool?,
        during = json['during'] as bool?,
        after = json['after'] as bool?,
        editBefore = json['editBefore'] as bool?,
        editDuring = json['editDuring'] as bool?,
        editAfter = json['editAfter'] as bool?;

  Map<String, dynamic> toJson() => {
    'before' : before,
    'during' : during,
    'after' : after,
    'editBefore' : editBefore,
    'editDuring' : editDuring,
    'editAfter' : editAfter
  };
}