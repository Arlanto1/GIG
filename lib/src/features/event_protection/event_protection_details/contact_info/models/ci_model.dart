import '../../../../../models/department.dart';
import '../../../../createfound/models/get_user_model.dart';

class CiModel {
  CiModel({
    this.id,
    this.lsm1,
    this.lsm1ContactNo,
    this.lsm2,
    this.lsm2ContactNo,
    this.bu1,
    this.bu1ContactNo,
    this.bu2,
    this.bu2ContactNo,
    this.requesterDepartment,
    this.epOfficers,
    this.srh1,
    this.srh2,
    this.bu1Dept,
    this.bu2Dept,
    this.systemVendor1,
    this.systemVendor2,
    this.systemVendor3,
    this.systemVendor1ContactNo,
    this.systemVendor2ContactNo,
    this.systemVendor3ContactNo,
    this.vendor1Primary,
    this.vendor1PrimaryContact,
    this.vendor1Secondary,
    this.vendor1SecondaryContact,
    this.vendor2Primary,
    this.vendor2PrimaryContact,
    this.vendor2Secondary,
    this.vendor2SecondaryContact,
    this.vendor3Primary,
    this.vendor3PrimaryContact,
    this.vendor3Secondary,
    this.vendor3SecondaryContact,
    this.extraSecurityDeployed,
  });

  int? id;
  GetUserDetails? lsm1;
  String? lsm1ContactNo;
  GetUserDetails? lsm2;
  String? lsm2ContactNo;
  GetUserDetails? bu1;
  String? bu1ContactNo;
  GetUserDetails? bu2;
  String ?bu2ContactNo;
  Department? requesterDepartment;
  String ?epOfficers;
  GetUserDetails? srh1;
  GetUserDetails ?srh2;
  Department ?bu1Dept;
  Department ?bu2Dept;
  String ?systemVendor1;
  String? systemVendor2;
  String? systemVendor3;
  String? systemVendor1ContactNo;
  String? systemVendor2ContactNo;
  String? systemVendor3ContactNo;
  String? vendor1Primary;
  String? vendor1PrimaryContact;
  String? vendor1Secondary;
  String? vendor1SecondaryContact;
  String? vendor2Primary;
  String? vendor2PrimaryContact;
  String? vendor2Secondary;
  String? vendor2SecondaryContact;
  String? vendor3Primary;
  String? vendor3PrimaryContact;
  String? vendor3Secondary;
  String? vendor3SecondaryContact;
  bool? extraSecurityDeployed;

  CiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lsm1 = GetUserDetails.fromJson(json['lsm1']);
    lsm1ContactNo = json['lsm1ContactNo'];
    lsm2 = GetUserDetails.fromJson(json['lsm2']);
    lsm2ContactNo = json['lsm2ContactNo'];
    bu1 = GetUserDetails.fromJson(json['bu1']);
    bu1ContactNo = json['bu1ContactNo'];
    bu2 = GetUserDetails.fromJson(json['bu2']);
    bu2ContactNo = json['bu2ContactNo'];
    requesterDepartment = Department.fromJson(json['requesterDepartment']);
    epOfficers = json['epOfficers'];
    srh1 = GetUserDetails.fromJson(json['srh1']);
    srh2 = GetUserDetails.fromJson(json['srh2']);
    bu1Dept = Department.fromJson(json['bu1Dept']);
    bu2Dept = Department.fromJson(json['bu2Dept']);
    systemVendor1 = json['systemVendor1'];
    systemVendor2 = json['systemVendor2'];
    systemVendor3 = json['systemVendor3'];
    systemVendor1ContactNo = json['systemVendor1ContactNo'];
    systemVendor2ContactNo = json['systemVendor2ContactNo'];
    systemVendor3ContactNo = json['systemVendor3ContactNo'];
    vendor1Primary = json['vendor1Primary'];
    vendor1PrimaryContact = json['vendor1PrimaryContact'];
    vendor1Secondary = json['vendor1Secondary'];
    vendor1SecondaryContact = json['vendor1SecondaryContact'];
    vendor2Primary = json['vendor2Primary'];
    vendor2PrimaryContact = json['vendor2PrimaryContact'];
    vendor2Secondary = json['vendor2Secondary'];
    vendor2SecondaryContact = json['vendor2SecondaryContact'];
    vendor3Primary = json['vendor3Primary'];
    vendor3PrimaryContact = json['vendor3PrimaryContact'];
    vendor3Secondary = json['vendor3Secondary'];
    vendor3SecondaryContact = json['vendor3SecondaryContact'];
    extraSecurityDeployed = json['extraSecurityDeployed'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['lsm1'] = lsm1?.toJson();
    _data['lsm1ContactNo'] = lsm1ContactNo;
    _data['lsm2'] = lsm2?.toJson();
    _data['lsm2ContactNo'] = lsm2ContactNo;
    _data['bu1'] = bu1?.toJson();
    _data['bu1ContactNo'] = bu1ContactNo;
    _data['bu2'] = bu2?.toJson();
    _data['bu2ContactNo'] = bu2ContactNo;
    _data['requesterDepartment'] = requesterDepartment?.toJson();
    _data['epOfficers'] = epOfficers;
    _data['srh1'] = srh1?.toJson();
    _data['srh2'] = srh2?.toJson();
    _data['bu1Dept'] = bu1Dept?.toJson();
    _data['bu2Dept'] = bu2Dept?.toJson();
    _data['systemVendor1'] = systemVendor1;
    _data['systemVendor2'] = systemVendor2;
    _data['systemVendor3'] = systemVendor3;
    _data['systemVendor1ContactNo'] = systemVendor1ContactNo;
    _data['systemVendor2ContactNo'] = systemVendor2ContactNo;
    _data['systemVendor3ContactNo'] = systemVendor3ContactNo;
    _data['vendor1Primary'] = vendor1Primary;
    _data['vendor1PrimaryContact'] = vendor1PrimaryContact;
    _data['vendor1Secondary'] = vendor1Secondary;
    _data['vendor1SecondaryContact'] = vendor1SecondaryContact;
    _data['vendor2Primary'] = vendor2Primary;
    _data['vendor2PrimaryContact'] = vendor2PrimaryContact;
    _data['vendor2Secondary'] = vendor2Secondary;
    _data['vendor2SecondaryContact'] = vendor2SecondaryContact;
    _data['vendor3Primary'] = vendor3Primary;
    _data['vendor3PrimaryContact'] = vendor3PrimaryContact;
    _data['vendor3Secondary'] = vendor3Secondary;
    _data['vendor3SecondaryContact'] = vendor3SecondaryContact;
    _data['extraSecurityDeployed'] = extraSecurityDeployed;
    return _data;
  }
}
