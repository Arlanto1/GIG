class NextAvailableDateRange {
  final String? fromDate;
  final List<String>? availableDates;
  final String? toDate;
  final String? fromDateMin;
  final String? fromDateMax;
  final String? toDateMin;
  final String? toDateMax;

  NextAvailableDateRange({
    this.fromDate,
    this.availableDates,
    this.toDate,
    this.fromDateMin,
    this.fromDateMax,
    this.toDateMin,
    this.toDateMax,
  });

  NextAvailableDateRange.fromJson(Map<String, dynamic> json)
      : fromDate = json['fromDate'] as String?,
        availableDates = (json['availableDates'] as List?)
            ?.map((dynamic e) => e as String)
            .toList(),
        toDate = json['toDate'] as String?,
        fromDateMin = json['fromDateMin'] as String?,
        fromDateMax = json['fromDateMax'] as String?,
        toDateMin = json['toDateMin'] as String?,
        toDateMax = json['toDateMax'] as String?;

  Map<String, dynamic> toJson() => {
        'fromDate': fromDate,
        'availableDates': availableDates,
        'toDate': toDate,
    'fromDateMin':fromDateMin,
    'fromDateMax':fromDateMax,
    'toDateMin':toDateMin,
    'toDateMax':toDateMax,
      };
}
