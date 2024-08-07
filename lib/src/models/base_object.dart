class BaseObject {
  String? lock;
  // bool? isEligibleToEdit;
  // bool? isEligibleToCancel;

  BaseObject({
    this.lock,
    // this.isEligibleToEdit,
    // this.isEligibleToCancel,
  });

  BaseObject.fromJson(Map<String, dynamic> json)
      : lock = json['lock'] as String?
  // ,
  //       isEligibleToEdit = json['isEligibleToEdit'] as bool?,
  //       isEligibleToCancel = json['isEligibleToCancel'] as bool?
  ;

  Map<String, dynamic> toJson() => {
        'lock': lock,
        // 'isEligibleToEdit': isEligibleToEdit,
        // 'isEligibleToCancel': isEligibleToCancel,
      };
}
