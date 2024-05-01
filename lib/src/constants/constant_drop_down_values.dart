import 'package:db_atom/index.dart';

const List<Label> languagesDropDownValues = [
  Label(key: 'English', value: 'en'),
  Label(key: 'German', value: 'de'),
];
const List<Label> statusDropDownValues = [
  Label(key: 'Active', value: '1'),
  Label(key: 'InActive', value: '2'),
  Label(key: 'Leave', value: '3'),
  Label(key: 'WeekOff', value: '4'),
  Label(key: 'Already Assigned', value: '5'),
  Label(key: 'Cancelled', value: '-1'),
];

const List<Label> occurrenceStatusDropDownValues = [
  Label(key: 'Created', value: '0'),
  Label(key: 'Submitted', value: '1'),
  Label(key: 'Cancelled', value: '-1'),
];

const List<Label> sstIncidentType = [
  Label(key: 'Internal', value: '0'),
  Label(key: 'External', value: '1'),
];
const List<Label> systemAccessDropDownValues = [
  Label(key: 'Yes', value: '1'),
  Label(key: 'No', value: '2'),
  Label(key: 'Revoke', value: '3'),
];
const List<Label> maritalStatusDropDownValues = [
  Label(key: 'Single', value: '1'),
  Label(key: 'Married', value: '2'),
];
const List<Label> escalationLevelDropDownValues = [
  Label(key: 'Escalation Level 1', value: '0'),
  Label(key: 'Escalation Level 2', value: '1'),
];
const List<Label> genderDropDownValues = [
  Label(key: 'Male', value: '1'),
  Label(key: 'Female', value: '2'),
  Label(key: 'Transgender', value: '3'),
];
const List<Label> dutyTypeDropDownValues = [
  Label(key: 'Building', value: '1'),
  Label(key: 'Escort', value: '2'),
  Label(key: 'Facility', value: '3'),
  Label(key: 'Building & Escort', value: '4'),
];

const List<Label> systemDropDownValues = [
  Label(key: 'Access Control System', value: '1'),
  Label(key: 'Video Management System', value: '2'),
  Label(key: 'Intrusion Detection System', value: '3'),
  Label(key: 'ACS AND CCTV', value: '4'),
  Label(key: 'IDS AND CCTV', value: '5'),
  Label(key: 'ACS, CCTV AND IDS', value: '6'),
];

const List<Label> assetTypeValues = [
  Label(key: 'Personal', value: '0'),
  Label(key: 'Company', value: '1'),
];

const List<Label> incidentManagementStatus = [
  Label(key: 'Created', value: '0'),
  Label(key: 'Complainant Review', value: '1'),
  Label(key: 'IM Pre-Review', value: '2'),
  Label(key: 'IM Pre-Reject', value: '3'),
  Label(key: 'IM Pre-Approve', value: '4'),
  Label(key: 'IO Role Review', value: '5'),
  Label(key: 'IO Role Reject', value: '6'),
  Label(key: 'IO Role Approve', value: '7'),
  Label(key: 'Investigation', value: '8'),
  Label(key: 'Pass', value: '9'),
  Label(key: 'Pass Review', value: '10'),
  Label(key: 'Pass Reject', value: '11'),
  Label(key: 'Pass Approve', value: '12'),
  Label(key: 'RCA', value: '13'),
  Label(key: 'RCA Review', value: '14'),
  Label(key: 'RCA Reject', value: '15'),
  Label(key: 'RCA Approve', value: '16'),
  Label(key: 'RCA System Review', value: '17'),
  Label(key: 'RCA System Reject', value: '18'),
  Label(key: 'RCA System Approve', value: '19'),
  Label(key: 'Data Loss', value: '20'),
  Label(key: 'Data Loss Review', value: '21'),
  Label(key: 'Data Loss Reject', value: '22'),
  Label(key: 'Data Loss Approve', value: '23'),
  Label(key: 'Further Investigation', value: '24'),
  Label(key: 'RCA Action Plan', value: '25'),
  Label(key: 'RCA Action Plan Review', value: '26'),
  Label(key: 'RCA Action Plan Reject', value: '27'),
  Label(key: 'RCA Action Plan Approve', value: '28'),
  Label(key: 'IO Review', value: '29'),
  Label(key: 'IO Reject', value: '30'),
  Label(key: 'IO Approve', value: '31'),
  Label(key: 'FTE CWR Involved', value: '32'),
  Label(key: 'IM Final Review', value: '33'),
  Label(key: 'Read Across', value: '34'),
  Label(key: 'Read Across Review', value: '35'),
  Label(key: 'Read Across Reject', value: '36'),
  Label(key: 'Read Across Approve', value: '37'),
  Label(key: 'Investigation Done', value: '38'),
  Label(key: 'Closed', value: '39'),
  Label(key: 'Cancelled', value: '40'),
  Label(key: 'Cancelled', value: '-1'),
];

const List<Label> eventProtectionGiStatus = [
  Label(key: 'Draft', value: '0'),
  Label(key: 'Business Review', value: '1'),
  Label(key: 'LSM Review', value: '2'),
  Label(key: 'LSM Approved', value: '3'),
  Label(key: 'LSM Rejected', value: '4'),
  Label(key: 'Vendor Review', value: '5'),
  Label(key: 'Vendor Approved', value: '6'),
  Label(key: 'Vendor Rejected', value: '7'),
  Label(key: 'Business POC Review', value: '8'),
  Label(key: 'Business POC Approved', value: '9'),
  Label(key: 'Business POC Rejected', value: '10'),
  Label(key: 'Security Vendor Review', value: '11'),
  Label(key: 'Security Vendor Submitted', value: '12'),
  Label(key: 'EP Pre Review', value: '13'),
  Label(key: 'EP Pre Approved', value: '14'),
  Label(key: 'EP Pre Rejected', value: '15'),
  Label(key: 'SRH Review', value: '16'),
  Label(key: 'SRH Approved', value: '17'),
  Label(key: 'SRH Rejected', value: '18'),
  Label(key: 'EP PO Required', value: '19'),
  Label(key: 'EP PO Updated', value: '20'),
  Label(key: 'Event Started', value: '21'),
  Label(key: 'During Event', value: '22'),
  Label(key: 'Event Concluded', value: '23'),
  Label(key: 'EP Post Approve', value: '25'),
  Label(key: 'EP Post Reject', value: '26'),
  Label(key: 'Invoice Requested', value: '27'),
  Label(key: 'Invoice Raised', value: '28'),
  Label(key: 'Invoice Submitted', value: '29'),
  Label(key: 'Closed', value: '30'),
  Label(key: 'Cancelled', value: '-1'),
];

const List<Label> guardRankDropDownValues = [
  Label(key: 'Security Guard', value: '1'),
  Label(key: 'Security Officer', value: '2'),
  Label(key: 'Security Supervisor', value: '3'),
  Label(key: 'Security Facilitator', value: '4'),
  Label(key: 'Gun Man', value: '5'),
  Label(key: 'Lady Security Guard', value: '6'),
];

const List<Label> staffCategoryDropDownValues = [
  Label(key: 'Guarding Agency', value: '1'),
  Label(key: 'Security Guard', value: '2'),
  Label(key: 'Security Lady', value: '3'),
  Label(key: 'Security Supervisor', value: '4'),
  Label(key: 'Security Officer', value: '5'),
  Label(key: 'Security Facilitator', value: '6'),
  Label(key: 'NA', value: '7'),
];
const List<Label> deploymentTypeDropDownValues = [
  Label(key: 'New Deployment', value: '1'),
  Label(key: 'Redeployment', value: '2'),
];

const List<Label> categoryValues = [
  Label(key: 'Permanent', value: '0'),
  Label(key: 'Temporary', value: '1'),
];

const List<Label> mSGBFormBSubmittedDropDownValues = [
  Label(key: 'Yes', value: '1'),
  Label(key: 'No', value: '2'),
  Label(key: 'Under ', value: '3'),
];

const List<Label> incidentTypeValues = [
  Label(key: 'Loss', value: '0'),
  Label(key: 'Damage', value: '1'),
  Label(key: 'Workplace violence', value: '2'),
  Label(key: 'Negligence', value: '3'),
  Label(key: 'General', value: '4'),
];

const List<Label> employeeTypeDropDownValues = [
  Label(key: 'FTE', value: '1'),
  Label(key: 'CWR T1', value: '2'),
  Label(key: 'CWR T2', value: '3'),
];

const List<Label> keyHandingOverDurationValues = [
  Label(key: 'Daily', value: '1'),
  Label(key: 'More than One Day', value: '2'),
];

const List<Label> keyTypeDropDownValues = [
  Label(key: 'Normal', value: '1'),
  Label(key: 'Master', value: '2'),
];

const List<Label> typesDropDownValues = [
  Label(key: 'Has Lock Changed', value: '0'),
  Label(key: 'Has Key Lost', value: '1'),
  Label(key: 'Has Key/Lock Damaged', value: '2'),
  Label(key: 'Key Destruction Process', value: '3'),
];

const List<Label> shiftDutyTypeDropDownValues = [
  Label(key: 'Transport', value: '1'),
  Label(key: 'Building', value: '2'),
  Label(key: 'Transport and Building', value: '3'),
];

const List<Label> keyTaggingDropDownValues = [
  Label(key: 'Yes', value: '1'),
  Label(key: 'No', value: '2'),
  Label(key: 'NA', value: '3'),
];
const List<Label> keyManagementStatus = [
  Label(key: 'Cancelled', value: '-1'),
  Label(key: 'Draft', value: '0'),
  Label(key: 'Open', value: '1'),
  Label(key: 'Closed', value: '2'),
];

const List<Label> keyManagementHistoryStatus = [
  Label(key: 'Cancelled', value: '11'),
  Label(key: 'Created', value: '0'),
  Label(key: 'Lock Change Initiated', value: '1'),
  Label(key: 'Lost Initiated', value: '2'),
  Label(key: 'Damaged Initiated', value: '3'),
  Label(key: 'Lost Approved', value: '4'),
  Label(key: 'Damaged Approved', value: '5'),
  Label(key: 'Investigation Initiated', value: '6'),
  Label(key: 'Destroy Initiated', value: '7'),
  Label(key: 'Destroy Rejected', value: '8'),
  Label(key: 'Destroy Approved', value: '9'),
  Label(key: 'Closed', value: '10'),
];

const List<Label> sstIncidentsStatusItems = [
  Label(key: 'Cancelled', value: '-1'),
  Label(key: 'Created', value: '1'),
  Label(key: 'Submitted', value: '2'),
  Label(key: 'Acknowledge', value: '3'),
  Label(key: 'Hold', value: '4'),
  Label(key: 'Rework', value: '5'),
  Label(key: 'Review', value: '6'),
  Label(key: 'Solve Proposed', value: '7'),
  Label(key: 'Quotes Rejected', value: '8'),
  Label(key: 'Quotes Approved', value: '9'),
  Label(key: 'Po Raised', value: '10'),
  Label(key: 'Work Completed', value: '11'),
  Label(key: 'Invoice Requested', value: '12'),
  Label(key: 'Invoice Submit', value: '13'),
  Label(key: 'Closed', value: '14'),
];

const List<Label> reasonDropDownValues = [
  Label(key: 'Leave', value: '1'),
  Label(key: 'Week Off', value: '2'),
  Label(key: 'Resigned', value: '3'),
  Label(key: 'Terminated', value: '4'),
  Label(key: 'Absent', value: '5'),
];
const List<Label> dutyPostNameMasterStatusValues = [
  Label(key: 'Cancelled', value: '-1'),
  Label(key: 'Draft', value: '0'),
  Label(key: 'Active', value: '1'),
];
const List<Label> dutyPostMasterStatusValues = [
  Label(key: 'Cancelled', value: '-1'),
  Label(key: 'Active', value: '1'),
  Label(key: 'InActive', value: '2')
];

const List<Label> slaStatusDropDownValues = [
  Label(key: 'Draft ', value: '0 '),
  Label(key: 'Active', value: '1'),
  Label(key: 'Finalize', value: '2'),
  Label(key: 'Cancelled', value: '-1'),
];
const List<Label> attendanceTypeDropDownValues = [
  Label(key: 'Regular', value: '1'),
  Label(key: 'AD HOC', value: '2'),
];

const List<Label> attendanceStatusDropDownValues = [
  Label(key: 'Draft', value: '0'),
  Label(key: 'Active', value: '1'),
  Label(key: 'InActive', value: '2'),
  Label(key: 'Cancelled', value: '-1'),
];

const List<Label> materialMovementStatusValues = [
  Label(key: 'Draft', value: '0'),
  Label(key: 'Business User Review', value: '1'),
  Label(key: 'Submitted', value: '2'),
  Label(key: 'LSM Review', value: '3'),
  Label(key: 'LSM Approved', value: '4'),
  Label(key: 'LSM Rejected', value: '5'),
  Label(key: 'Approved', value: '6'),
  Label(key: 'Rejected', value: '7'),
  Label(key: 'Outward Waiting', value: '8'),
  Label(key: 'Inward Waiting', value: '9'),
  Label(key: 'Closed/Finalized', value: '10'),
  Label(key: 'Cancelled', value: '-1'),
];
const List<Label> shiftScheduleStatusDropDownValues = [
  Label(key: 'Draft', value: '0'),
  Label(key: 'Active', value: '1'),
  Label(key: 'Finalized', value: '2'),
  Label(key: 'Cancelled', value: '-1'),
];
