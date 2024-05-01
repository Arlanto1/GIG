class NextAvailableDateRange {
  final String? fromDate;
  final String? toDate;

  NextAvailableDateRange({
    this.fromDate,
    this.toDate,
  });

  NextAvailableDateRange.fromJson(Map<String, dynamic> json)
      : fromDate = json['fromDate'] as String?,
        toDate = json['toDate'] as String?;

  Map<String, dynamic> toJson() => {'fromDate': fromDate, 'toDate': toDate};
}
