class NextAvailableDateRange {
  final String? fromDate;
  final List<String>? availableDates;
  final String? toDate;

  NextAvailableDateRange({
    this.fromDate,
    this.availableDates,
    this.toDate,
  });

  NextAvailableDateRange.fromJson(Map<String, dynamic> json)
      : fromDate = json['fromDate'] as String?,
        availableDates = (json['availableDates'] as List?)
            ?.map((dynamic e) => e as String)
            .toList(),
        toDate = json['toDate'] as String?;

  Map<String, dynamic> toJson() => {
        'fromDate': fromDate,
        'availableDates': availableDates,
        'toDate': toDate
      };
}
