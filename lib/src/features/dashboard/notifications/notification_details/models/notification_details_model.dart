class NotificationDetailsModel {
  final int? id;
  final String? subject;
  final String? details;

  NotificationDetailsModel({
    this.id,
    this.subject,
    this.details,
  });

  NotificationDetailsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        subject = json['subject'] as String?,
        details = json['details'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'subject' : subject,
    'details' : details
  };
}