class VIVPVisitorRecordModel {
  int? id;
  String? name;
  String? email;
  String? designation;
  String? baseLocation;
  String? purpose;
  String? startDateVisit;
  String? endDateVisit;
  String? lock;

  VIVPVisitorRecordModel({
    this.id,
    this.name,
    this.email,
    this.designation,
    this.baseLocation,
    this.purpose,
    this.startDateVisit,
    this.endDateVisit,
    this.lock,
    // required users,
  });

  VIVPVisitorRecordModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        email = json['email'] as String?,
        designation = json['designation'] as String?,
        baseLocation = json['baseLocation'] as String?,
        purpose = json['purpose'] as String?,
        startDateVisit = json['startDateVisit'] as String?,
        endDateVisit = json['endDateVisit'] as String?,
        lock = json['lock'] as String?;

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'email': email,
        'designation': designation,
        'baseLocation': baseLocation,
        'purpose': purpose,
        'startDateVisit': startDateVisit,
        'endDateVisit': endDateVisit,
        'lock': lock,
      };
}
