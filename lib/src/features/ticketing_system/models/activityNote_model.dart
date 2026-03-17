class ActivityNote {
  int? id;
  String activityNotes;
  String submittedDate;
  bool submitted;

  ActivityNote({
    this.id,
    required this.activityNotes,
    required this.submittedDate,
    this.submitted = false,
  });

  ActivityNote.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        activityNotes = json['activityNotes']  as String,
        submittedDate = json['submittedDate'] as String,
        submitted = json['submitted'] as bool;


  Map<String, dynamic> toJson() => {
    'id': id,
    'activityNotes': activityNotes,
    'submittedDate': submittedDate,
    'submitted': submitted,
  };
}