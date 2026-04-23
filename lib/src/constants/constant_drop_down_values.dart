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
  Label(key: 'Business User Review', value: '1'),
  Label(key: 'LSM Review', value: '2'),
  Label(key: 'LSM Approved', value: '3'),
  Label(key: 'LSM Rejected', value: '4'),
  Label(key: 'Vendor Review', value: '5'),
  Label(key: 'Vendor Approve', value: '6'),
  Label(key: 'Vendor Reject', value: '7'),
  Label(key: 'Business User POC Review', value: '8'),
  Label(key: 'Business User POC Approved', value: '9'),
  Label(key: 'Business User POC Rejected', value: '10'),
  Label(key: 'Security System Vendor Review', value: '11'),
  Label(key: 'Security Vendor Submitted', value: '12'),
  Label(key: 'EP Pre Review', value: '13'),
  Label(key: 'EP Pre Approved', value: '14'),
  Label(key: 'EP Pre Rejected', value: '15'),
  Label(key: 'SRH Review', value: '16'),
  Label(key: 'SRH Approved', value: '17'),
  Label(key: 'SRH Rejected', value: '18'),
  Label(key: 'PO Required', value: '19'),
  Label(key: 'PO Updated', value: '20'),
  Label(key: 'Event Started', value: '21'),
  Label(key: 'Event Ongoing', value: '22'),
  Label(key: 'Event Concluded', value: '23'),
  Label(key: 'EP Post-Event Approved', value: '25'),
  Label(key: 'EP Post-Event Rejected', value: '26'),
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
  Label(key: 'Guarding Agency', value: '0'),
  Label(key: 'Security Guard', value: '1'),
  Label(key: 'Security Lady', value: '2'),
  Label(key: 'Security Supervisor', value: '3'),
  Label(key: 'Security Officer', value: '4'),
  Label(key: 'Security Facilitator', value: '5'),
  Label(key: 'NA', value: '6'),
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
  Label(key: 'Under Process ', value: '3'),
];

const List<Label> staffMsgbCompliantDropDownValues = [
  Label(key: 'Complaint', value: '1'),
  Label(key: 'Non Complaint', value: '2'),
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
  Label(key: 'Keys', value: '1'),
  Label(key: 'Master Keys', value: '2'),
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

const List<Label> shiftScheduleReasonDropDownValues = [
  Label(key: 'Leave', value: '0'),
  Label(key: 'Week Off', value: '1'),
  Label(key: 'Resigned', value: '2'),
  Label(key: 'Terminated', value: '3'),
  Label(key: 'Shift Completed', value: '4'),
  Label(key: 'Absent', value: '5'),
];


const List<Label> attendanceReasonDropDownValues  = [
  Label(key: 'Leave', value: '0'),
  Label(key: 'Week Off', value: '1'),
  Label(key: 'Resigned', value: '2'),
  Label(key: 'Terminated', value: '3'),
  Label(key: 'Absent', value: '4'),
  Label(key: 'AlreadyAssigned', value: '5'),
];
const List<Label> dutyPostNameMasterStatusValues = [
  Label(key: 'Cancelled', value: '-1'),
  Label(key: 'Draft', value: '0'),
  Label(key: 'Active', value: '1'),
];
const List<Label> dutyPostMasterStatusValues = [
  Label(key: 'Active', value: '1'),
  Label(key: 'Closed', value: '2')
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
  Label(key: 'Closed', value: '2'),
  Label(key: 'Cancelled', value: '-1'),
];

const List<Label> materialMovementStatusValues = [
  Label(key: 'Draft', value: '0'),
  Label(key: 'Business User Review', value: '1'),
  Label(key: 'Submitted', value: '2'),
  Label(key: 'Security Review', value: '3'),
  Label(key: 'Approval from Approver is awaited', value: '4'),
  Label(key: 'Security Rejected', value: '5'),
  Label(key: 'Outward Pending', value: '6'),
  Label(key: 'Rejected', value: '7'),
  Label(key: 'Return Pending', value: '8'),
  Label(key: 'Inward Pending', value: '9'),
  Label(key: 'Closed/Finalized', value: '10'),
  Label(key: 'Material Return Overdue', value: '12'),
  Label(key: 'Material Return Pending', value: '11'),
  Label(key: 'Cancelled', value: '-1'),
];
const List<Label> shiftScheduleStatusDropDownValues = [
  Label(key: 'Draft', value: '0'),
  Label(key: 'Active', value: '1'),
  Label(key: 'InActive', value: '2'),
  Label(key: 'Cancelled', value: '-1'),
];

const List<Label> issueTypeDropDownValues = [
  Label(key: 'Hardware', value: '1'),
  Label(key: 'Software', value: '2'),
  Label(key: 'Network Issue', value: '3'),
];

const List<Label> passManagementStatusValues = [
  Label(key: 'Created', value: '0'),
  Label(key: 'Handed Over', value: '1'),
  Label(key: 'Returned', value: '2'),
  Label(key: 'Non Returned', value: '3'),
  Label(key: 'Lost', value: '4'),
  // Label(key: 'Damaged/De-Activated', value: '5'),
  // Label(key: 'Defaced/De-Activated', value: '6'),
  Label(key: 'Cancelled', value: '7'),
  Label(key: 'Returned/Damaged', value: '8'),
  Label(key: 'Returned/Defaced', value: '9'),
  Label(key: 'Record Cancelled', value: '-1'),
];

const List<Label> passTypeValues = [
  Label(key: 'Day Pass', value: '0'),
  Label(key: 'Visitor Pass', value: '1'),
  Label(key: 'Vendor Pass', value: '2'),
  Label(key: 'SEZ Pass', value: '3'),
  Label(key: 'DWS Day Pass', value: '4'),
  Label(key: 'DWS Visitor Pass', value: '5'),
  Label(key: 'DWS Vendor Pass', value: '6'),
];

const List<Label> dayPassTypeValues = [
  Label(key: 'Day Pass', value: '0'),
];


const List<Label> photoIdentityValidationValues = [
  Label(key: 'Aadhaar Card', value: '0'),
  Label(key: 'Pan Card', value: '1'),
  Label(key: 'Passport', value: '2'),
  Label(key: 'Driving License', value: '3'),
  Label(key: 'Voter Card', value: '4'),
];

const List<Label> passCategoryValues = [
  Label(key: 'Permanent', value: '1'),
  Label(key: 'Temporary', value: '2'),
];


const List<Label> articleFoundStatus = [
  Label(key: 'Found', value: '0'),
  Label(key: 'Under Security Custody', value: '1'),
  Label(key: 'Handed Over/ Claimed', value: '2'),
  Label(key: 'Cancelled', value: '-1'),

];


const List<Label> workShift = [
  Label(key: 'A Shift (7AM-3PM)', value: '0'),
  Label(key: 'B Shift (3PM-11PM)', value: '1'),
  Label(key: 'C Shift (11PM-7AM)', value: '2'),
  Label(key: 'G Shift (9AM-6PM)', value: '3'),
];


const List<Label> approveReject = [
  Label(key: 'Approve', value: '1'),
  Label(key: 'Reject', value: '0'),
];


const List<Label> mediaExposure = [
  Label(key: 'No media / no public appearance', value: '0'),
  Label(key: 'Only local media / or financial industry media exposure', value: '2'),
  Label(key: 'Broad media and public exposure', value: '3'),

];

const List<Label> riskInfo = [
  Label(key: 'No Sensitive Information', value: '0'),
  Label(key: 'Sensitive but no confidential information discussed during event', value: '2'),
  Label(key: 'Confidential information discussed during event', value: '3'),
];


const List<Label> assistanceInfo = [
  Label(key: 'Escalation 1(SSM)', value: '8'),
  Label(key: 'Escalation 2(ASL)', value: '9'),
  Label(key: 'Escalation 3(SRH)', value: '10'),
  Label(key: 'ROC', value: '11'),
];



const List<Label> ticketStatusDropDownValues = [
  Label(key: 'Draft', value: '0'),
  Label(key: 'Open', value: '1'),
  Label(key: 'Duplicate', value: '2'),
  Label(key: 'Invalid', value: '3'),
  Label(key: 'In progress', value: '4'),
  Label(key: 'Dev Completed', value: '5'),
  Label(key: 'Testing', value: '6'),
  Label(key: 'Done', value: '7'),
  Label(key: 'Reopen', value: '8'),
  Label(key: 'Released', value: '9'),
  Label(key: 'Closed', value: '10'),
  Label(key: 'Cancelled', value: '-1'),
];



const List<Label> ticketTypeDropDownValues = [
  Label(key: 'Bugs', value: '1'),
  Label(key: 'Improvements', value: '2'),
  Label(key: 'Support', value: '3'),
  Label(key: 'Feature', value: '4'),
];
const List<Label> priorityTypeDropDownValues = [
  Label(key: 'Urgent', value: '1'),
  Label(key: 'High', value: '2'),
  Label(key: 'Medium', value: '3'),
  Label(key: 'Low', value: '4'),
];

const List<Label> ticketRaisedForDropDownValues = [
  Label(key: 'Web', value: '1'),
  Label(key: 'ATOM App', value: '2'),
  Label(key: 'Both App and Web', value: '3'),
];

const List<Label> ragStatusDropDownValues = [
  Label(key: 'Green', value: '1'),
  Label(key: 'Amber', value: '2'),
  Label(key: 'Red', value: '3'),
];


const List<Label> transportIncidentTypeValues = [
  Label(key: 'Transport', value: '0'),
  Label(key: 'Medical Emergency', value: '1'),
];

const List<Label> transportTypeValues = [
  Label(key: 'Ambulance', value: '0'),
  Label(key: 'Cab', value: '1'),
  Label(key: 'Personal', value: '2'),
  Label(key: 'Company', value: '3'),

];


const List<Label> patrollingShift = [
  Label(key: 'A', value: '0'),
  Label(key: 'B', value: '1'),
  Label(key: 'C', value: '2'),
];


const List<Label> patrollingStatusDropDownValues = [
  Label(key: 'Draft', value: '0'),
  Label(key: 'LSM Actions', value: '1'),
  Label(key: 'Owner Actions', value: '2'),
  Label(key: 'Closed', value: '3'),
  Label(key: 'Cancelled', value: '-1'),
];


const List<Label> shift = [
  Label(key: 'A', value: '0'),
  Label(key: 'B', value: '1'),
  Label(key: 'C', value: '2'),
];


const List<Label> progressStatus = [
  Label(key: 'In Progress', value: '0'),
  Label(key: 'Closed', value: '1'),
];

const List<Label> reviewStatus = [
  Label(key: 'Approved', value: '1'),
  Label(key: 'Rejected', value: '2'),
];
const List<Label> severityDropDown = [
  Label(key: 'High', value: '1'),
  Label(key: 'Medium', value: '2'),
  Label(key: 'Low', value: '3'),

];

// const List<String> ownerDropDownValues = [
//   'Security',
//   'Facilities',
//   'Management',
//   'Other',
// ];

const List<Label> ownerDropDownValues = [
  Label(key: 'Security', value: 'Security'),
  Label(key: 'Facility', value: 'Facility'),
  Label(key: 'Engineering', value: 'Engineering'),
  Label(key: 'Other', value: 'Other'),

];


const List<Label> csrEventProtectionGiStatus = [
  Label(key: 'Draft', value: '0'),
  Label(key: 'Business User Review', value: '1'),
  Label(key: 'LSM Review', value: '2'),
  Label(key: 'LSM Approved', value: '3'),
  Label(key: 'LSM Rejected', value: '4'),
  Label(key: 'Vendor Review', value: '5'),
  Label(key: 'Vendor Approve', value: '6'),
  Label(key: 'Vendor Reject', value: '7'),
  Label(key: 'Business User POC Review', value: '8'),
  Label(key: 'Business User POC Approved', value: '9'),
  Label(key: 'Business User POC Rejected', value: '10'),
  Label(key: 'Security System Vendor Review', value: '11'),
  Label(key: 'Security Vendor Submitted', value: '12'),
  Label(key: 'EP Pre Review', value: '13'),
  Label(key: 'EP Pre Approved', value: '14'),
  Label(key: 'EP Pre Rejected', value: '15'),
  Label(key: 'SRH Review', value: '16'),
  Label(key: 'SRH Approved', value: '17'),
  Label(key: 'SRH Rejected', value: '18'),
  Label(key: 'PO Required', value: '19'),
  Label(key: 'PO Updated', value: '20'),
  Label(key: 'Event Started', value: '21'),
  Label(key: 'Event Ongoing', value: '22'),
  Label(key: 'Event Concluded', value: '23'),
  Label(key: 'EP Post-Event Approved', value: '25'),
  Label(key: 'EP Post-Event Rejected', value: '26'),
  Label(key: 'Invoice Requested', value: '27'),
  Label(key: 'Invoice Raised', value: '28'),
  Label(key: 'Invoice Submitted', value: '29'),
  Label(key: 'Closed', value: '30'),
  Label(key: 'Cancelled', value: '-1'),
];