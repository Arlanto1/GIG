class NextAvailableDate {
  final String? fromDate;
  final String? toDate;

  NextAvailableDate({
    this.fromDate,
    this.toDate,
  });

  NextAvailableDate.fromJson(Map<String, dynamic> json)
      : fromDate = json['fromDate'] as String?,
        toDate = json['toDate'] as String?;

  Map<String, dynamic> toJson() => {
    'fromDate' : fromDate,
    'toDate' : toDate
  };
}