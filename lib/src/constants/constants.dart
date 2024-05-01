import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class Constants {
  // static const inactivityDuration = Duration(minutes: 5);

  /// Pagination
  static const int maxResults = 20;

  static const double cancelButtonWidth = 170;

  /// Text Form Field Character Limit
  static const int characterLimitContactNo = 17;
  static const int characterLimitIdTextFormField = 250;
  static const int characterLimitDescTextFormField = 4000;

  /// Module Codes
  static const String materialMovementInwardReturnableModule = 'MMINN';
  static const String materialMovementOutwardReturnableModule = 'MMOUTY';
  static const String materialMovementOutwardNonReturnableModule = 'MMOUTN';
  static const String guardingMasterDataModule = 'GM';
  static const String passManagementModule = 'PMDYP';
  static const String passManagementSEZModule = 'PMSEZ';
  static const String visitorManagementModule = 'PMVSP';
  static const String vendorPassManagementModule = 'PMVNP';
  static const String eventProtectionModule = 'EP';
  static const String annualPowerShutDownModule = 'APS';
  static const String securitySystemModule = 'SSSLA';
  static const String guardingRatesModule = 'GR';
  static const String occurrenceModule = 'OCC';
  static const String incidentManagementModule = 'IM';
  static const String contactDetailsModule = 'CD';
  static const String slaViolationPenaltyDetailsModule = 'SVP';
  static const String keyManagementIssuanceModule = 'KMISS';
  static const String keyManagementMasterModule = 'KeyMM';
  static const String keyLossDestructionModule = 'KLD';
  static const String vipVisitorsDetailsModule = 'VIP';
  static const String shiftScheduleModule = 'SS';
  static const String dutyPostNameMasterModule = 'SSDP';
  static const String attendanceModule = 'ATD';
  static const String keyReconciliationModule = 'KR';

  /// UI Labels Module Code
  static const String articleFoundModuleCode = 'AF';
  static const String passManagementModuleCode = 'PM';
  static const String leoModuleCode = 'LEO';
  static const String materialMovementModuleCode = 'MM';
  static const String contactDetailsModuleCode = 'CD';
  static const String guardingMasterModuleCode = 'GM';
  static const String eventProtectionModuleCode = 'EP';
  static const String slaViolationPenaltyDetailsModuleCode = 'SVP';
  static const String shiftScheduleModuleCode = 'SS';
  static const String dutyPostNameMasterModuleCode = 'SSDP';
  static const String attendanceModuleCode = 'ATD';

  /// Rank Types for Contact Details
  static const String contactGeneralRank = 'CONTACT_GENERAL_RANK';
  static const String contactGuardingAgencyEscalationRank =
      'CONTACT_GUARDING_AGENCY_ESCALATION_RANK';
  static const String contactSystemEscalationRank =
      'CONTACT_SYSTEM_ESCALATION_RANK';
  static const String contactZone = 'CONTACT_ZONE';
  static const String contactSupervisorRank = 'CONTACT_SUPERVISOR_RANK';

  static const String userRoles = 'userRoles';
  static const String defaultLocation = 'defaultLocation';

  // static const String customFontFamily = 'Poppins';
  // static const String customFontMediumFamily = 'Poppins-Medium';
  // static const String customFontBoldFamily = 'Poppins-Bold';
  // static const String customFontRegularFamily = 'Poppins-Regular';
  // static const String customFontSemiBoldFamily = 'Poppins-SemiBold';
  // static const String customFontMixedFamily = 'Poppins-Mixed';

  ///DeutscheBank Font
  static const String customFontFamily = 'DeutscheBankDisplay_A';
  static const String customFontMediumFamily = 'DeutscheBankDisplay_A_Rg';
  static const String customFontBoldFamily = 'DeutscheBankDisplay_A_Rg';
  static const String customFontRegularFamily = 'DeutscheBankDisplay_A_Rg';
  static const String customFontSemiBoldFamily = 'DeutscheBankDisplay_A_Rg';
  static const String customFontMixedFamily = 'DeutscheBankDisplay_A_Rg';
  static const String appname = 'AtomEdge';
  static const String unsaveddata = 'Unsaved Data';
  static const String unsaveddatadesc =
      "There is unsaved data. Do you want to exit anyhow?";

  // Validations
  static const String enterusername = 'Please enter valid username';
  static const String enterpassword = 'Please enter valid password';
  static const String enterValidEmail = 'Please enter valid email';

  static const String invalidusername = 'Invalid username';
  static const String logoutValidation =
      "Are you  sure, do you want to logout?";

  // Sharedpreferences keys
  static const String isLoggedInKey = 'isLoggedIn';
  static const String isUserNameKey = 'isUserName';
  static const String isEmailKey = 'isEmail';
  static const String isRequiredPasswordChangeKey = 'isRequiredPasswordChange';
  static const String lastInteractionTime = 'lastInteractionTime';
  static const String languageCode = 'languageCode';
  static const String deviceToken = 'deviceToken';

  static const String isUserIdKey = 'isUserId';
  static const String isFoundIdKey = 'isFoundId';
  static const String isMenuIndexIdentifyKey = 'isMenuIndexIdentify';
  static const String isMaterialMovementIdKey = 'isMaterialMovementId';
  static const String isAccessToken = 'isAccessToken';
  static const String isSessionToken = 'isSessionToken';

  // Images
  static const String bg = 'assets/images/bg.png';

  //static const String splashscreen = 'assets/images/Arlantologin.png';
  static const String splashscreen = 'assets/images/atom_login.png';

  // Names
  static const String version = 'Version';

  //Login
  static const String hintUserName = 'Enter username';
  static const String hintPassword = "Enter password";
  static const String hintEmail = "Enter email";
  static const String hintOtp = "Enter Otp";
  static const String userError = "Please enter username";
  static const String otpError = "Please enter otp";

  static const String passwordError = "Please enter password";
  static const String confirmPasswordError = "Please enter Confirm password";
  static const String passwordLengthError =
      "Please enter password minimum 6 characters";
  static const String loginButtonTitle = "Login";
  static const String resetPwdTitle = "Reset Password";

  static const String loginVerifyOtpTitle = "Verify";
  static const String send = "Send";
  static const String update = "Update";
  static const String otpVerificationTitle = "OTP Verification";
  static const String forgotPwdTitle = "Forgot Password";
  static const String ResetPwdTitle = "Reset Password";
  static const String titleHeaderLogin = "Welcome back, Login!!";
  static const String email = "Email";
  static const String username = "Username";
  static const String otp = "OTP";
  static const String updatePassword = "Update Password";
  static const String password = "Password";
  static const String oldPassword = "Old Password";
  static const String newPassword = "New Password";
  static const String confirmNewPassword = "Confirm New Password";
  static const String forgotPassowrd = 'Forgot Password?';
  static const String support = "Support :";
  static const String supportContact = "+91 6150 961 6244";
  static const String copyrightText = "Copyright Â© 2024 Arlanto.";
  static const String submit = "Submit";

  //Dashboard
  static const String home = 'Home';
  static const String dashboard = 'Dashboard';
  static const String securityFunctions = 'Security Functions';
  static const String operations = "Operations";
  static const String costAndBilling = "Cost & Billing";
  static const String securitySystems = "Security System";
  static const String securitySystemTickets = "Security System Tickets";
  static const String settings = "Settings";
  static const String administration = "Administration";
  static const String profile = 'Profile';
  static const String articleFoundRegister = 'Article Found Register';
  static const String lawEnforcementVisitsList = 'Law Enforcement Visits List';
  static const String eventProtectionList = 'Event Protection List';
  static const String annualPowerShutdownList = 'Annual Power Shutdown List';
  static const String annualPowerShutdownListDetails =
      'Annual Power Shutdown List Details';
  static const String sCRI = 'SCRI';
  static const String incidentManagement = 'Incident Management';
  static const String shiftOccurrence = 'Shift Occurrence';
  static const String occurrenceList = 'Occurrence List';
  static const String materialMovement = 'Material Movement';
  static const String passManagement = 'Non-Magnetic Pass Management';
  static const String guardingOperations = 'Guarding Operations';
  static const String logout = 'Logout';
  static const String deleteAllNotifications = 'Delete All';
  static const String deleteAllNotificationWarningMessage =
      'Are you sure, do you want to delete all notifications';
  static const String eventProtectionByRegion = 'Event Protection By Region';
  static const String eventProtectionByEntity = 'Event Protection By Entity';
  static const String lawEnforcementVisitsByEntity =
      'Law Enforcement Visits By Entity';
  static const String lawEnforcementVisitsByRegion =
      'Law Enforcement Visits By Region';
  static const String eventProtectionAttendees = 'Event Protection Attendees';
  static const String eventProtectionBySupport = 'Event Protection By Support';

  static const String notifications = 'Notifications';

  static const String materialMovementInward = 'Material Movement Inward';
  static const String materialMovementInwardCreate =
      'Create Inward Material Movement';
  static const String materialMovementInwardEdit =
      'Edit Inward Material Movement';

  static const String materialMovementOutward = 'Material Movement Outward';
  static const String materialMovementOutwardCreate =
      'Create Outward Material Movement';
  static const String materialMovementOutwardEdit =
      'Edit Outward Material Movement';

  static const String dayPassManagement = 'Day Pass Management';
  static const String daypassregister = 'Day Pass Register';
  static const String visitorpassmgmt = 'Visitor Pass Management';
  static const String visitorpassregister = 'Visitor Pass Register';
  static const String vendorpassmgmt = 'Vendor Pass Management';
  static const String vendorpassregister = 'Vendor Pass Register';
  static const String sezpassmgmt = 'SEZ Pass Management';
  static const String sezpassregister = 'SEZ Pass Register';
  static const String someThingWentWrong = 'Something went wrong';
  static const String otpSendSuccessfully = 'Otp sent successfully';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String name = 'Name';
  static const String state = 'State';
  static const String key = 'Key';

  // Create Found
  static const String createFound = 'Create Found';
  static const String editFound = 'Edit Found';
  static const String foundList = 'Found List';
  static const String generalinformation = 'General Information';
  static const String assettype = 'Asset Type';
  static const String foundlocation = 'Found Location';
  static const String quantity = 'Quantity';
  static const String colour = 'Colour';
  static const String depositoremployeeid = 'Depositor Employee Id';
  static const String claimantemployeeid = 'Claimant Employee Id';
  static const String claimant = 'Claimant';
  static const String status = 'Status';
  static const String updatestatus = 'Update Status';
  static const String dateofcreation = 'Date of Creation';
  static const String createDate = 'Create Date';
  static const String createOn = 'Create On';
  static const String assetype = 'Asset Type';
  static const String founddate = 'Found Date';
  static const String articlename = 'Article Name';
  static const String handedoverdate = 'Handed over Date';
  static const String isdepositordbemployee = 'Is Depositor DB Employee';
  static const String createdby = 'Created By';
  static const String itemhandoverby = 'Item Handover By';
  static const String slno = 'Sl No.';
  static const String articleType = 'Article Type';
  static const String depositor = 'Depositor';
  static const String employeedepartment = 'Employee Department';
  static const String claimantdepartment = 'Claimant Department';
  static const String additionalinformation = 'Additional Information';
  static const String claimantSignature = 'Claimant Signature';
  static const String informationhere = 'Information here';
  static const String location = 'Location';
  static const String height = 'Height (cm)';
  static const String weight = 'Weight (kg)';
  static const String chest = 'Chest (inch)';

  static const String buildinglocation = 'Building Location';
  static const String addemployeedepartment = 'Add Employee Department';
  static const String addreasonfordaypass = 'Add Reason for Day Pass';
  static const String addreasonforvendorpass = 'Add Reason for Vendor Pass';
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String cancelRecord = 'Cancel Record';
  static const String cancelRecordWarningMessage =
      'Are you sure, do you want to cancel the record?';
  static const String close = 'Close';
  static const String closeRecordWarningMessage =
      'Are you sure, do you want to close the record?';
  static const String showList = 'Show List';
  static const String add = 'Add';
  static const String open = 'Open';
  static const String newuser = 'New User';
  static const String newuserdesc =
      'Provide the below data to create a new User.';
  static const String createnewuser = 'Create New User';
  static const String firstname = 'First Name';
  static const String lastname = 'Last Name';
  static const String uploadfile = 'Upload File';
  static const String captureOrUpload = 'Capture or Upload';
  static const String gallery = 'Gallery';
  static const String camera = 'Camera';
  static const String document = 'Document';
  static const String addarticletype = 'Add Article Type';
  static const String clicktoupload = 'Click to upload';
  static const String abort = 'Abort';
  static const String internationalization = 'Internationalization';
  static const String nodata = 'No Data Found';
  static const String ok = 'Ok';
  static const String isclaimantdbemployee = 'Is Claimant DB Employee';
  static const String isclaimantacceptedtosign = 'Claimant accepted to sign';
  static const String isclaimantacceptedbyemail = 'Claimant Confirmed by Email';

  // Law enforcement
  static const String createlawenforcement =
      'Create Law Enforcement Official Visit';
  static const String editlawenforcement =
      'Edit Law Enforcement Official Visit';
  static const String addcompanytype = 'Add Company Type';
  static const String addentitytype = 'Add Entity';
  static const String addpurposeofvisittype = 'Add Puropose Of Visit';
  static const String addleoofficialtype = 'Add Leo Department';

  //static const String editlawenforcement = 'Edit Found';
  static const String entity = 'Entity';
  static const String actualtimeofvisit = 'Actual Time of Visit';
  static const String purposeofvsit = 'Purpose of visit';
  static const String dbofficialwanttomeet = 'DB official want to meet';
  static const String dbofficialdepartment = 'DB official department';
  static const String dbofficialemailidaccompaniedleoofficial =
      'DB Official email ID Accompanied LEO official';
  static const String officialsidcardverified = 'Officials Id Card Verified?';
  static const String documentifanytoconfirmpurpose =
      'Document if any to confirm purpose';
  static const String incaseofpolicewasofficialinuniform =
      'In case of Police, was official in uniform?';
  static const String designation = 'Designation';
  static const String officeAddress = 'Office Address';
  static const String emailId = 'Email Id';
  static const String contactNo = 'Contact No';
  static const String department = 'Department';
  static const String distributiongroups = 'Distribution Groups';
  static const String upload = 'Upload';
  static const String attachments = 'Attachments';
  static const String evidenceDocuments = 'Evidence Documents Name';
  static const String uploadPhoto = 'Upload Photo';
  static const String addvisitingofficialdetails =
      "Add Another Visiting Official Details";
  static const String visitingOfficialDetails = "Visiting Official Details";
  static const String visitingOfficials = "Visiting Officials";

  // Pass mgmt
  static const String companyType = 'Company Type';
  static const String companyName = 'Company Name';
  static const String employeeid = 'Employee Id';
  static const String hostemployeeid = 'Host Employee Id';
  static const String host = 'Host';
  static const String passCollectedBy = 'Pass Collected By';
  static const String passReturnedOn = 'Pass Returned On';

  static const String passIssuedOn = 'Pass Issued On';
  static const String passvlidfrom = 'Pass Valid From';
  static const String passCategory = 'Pass Category';

  static const String exceptionalApproval =
      'Exceptional Approval for External Auditors/ External Regulators';
  static const String passvliduntil = 'Pass Valid Until';
  static const String escortedby = 'Escorted By';
  static const String identifiedBy = 'Identified By';
  static const String escortedbyemployeeid = 'Escorted by Employee Id';
  static const String identifiedByEmployeeId = 'Identified By Employee Id';
  static const String reasonfordaypass = 'Reason for Day Pass';
  static const String daypassno = 'Day Pass No';
  static const String passtype = 'Pass Type';
  static const String sezPassInfo = 'Sez Pass';
  static const String passValidUntil = '31/03/2023';

  //List page - Found Article
  static const String searchHintText = 'Search....';

  //Server error
  static const String errorText =
      'We are facing technical issues right now! Please try after some time';

  // Language codes for localization
  static const String french = 'French';
  static const String chineseTraditional = 'Chinese Traditional';
  static const String chineseSimplified = 'Chinese Simplified';
  static const String english = 'English';

  // Info about localization
  //static const String hintUserName = 'login.hintUsernameText'; // you can find this login.hintusername in json file or api load key

  //below line:this is how we load the localization string
  //LocaleSupportedMethod.getLocaleString(context, Constants.hintUserName)

  // Date formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm:ss a';
  static const String fulldateFormat = 'dd/MM/yyyy hh:mm:ss a';

// static const String dateFormat = 'yyyy-MM-dd';
// static const String fulldateFormat = 'dd/MM/yyyy a HH:mm:ss';

  /// Material Movement
  static const String materialMovementsType = 'Material Movement Type';
  static const String signatureTitle = 'Give Signature';
  static const String materialMovementsInwardTitle =
      'Inward Material Movement List';
  static const String materialMovementsOutwardTitle =
      'Outward Material Movement List';
  static const String createMaterialMovementInwardTitle =
      'Create Inward Material Movement';
  static const String createMaterialMovementOutwardTitle =
      'Create Outward Material Movement';
  static const String editMaterialMovementInwardTitle =
      'Edit Inward Material Movement';
  static const String editMaterialMovementOutwardTitle =
      'Edit OutWard Material Movement';
  static const String entryBy = 'Entry By';
  static const String materialReturnedChallanNo =
      'Material Returned Challan No';
  static const String inwardMaterialMovementType = 'Inward';
  static const String returnedQuantity = 'Returned Quantity';
  static const String outwardMaterialMovementType = 'Outward';
  static const String id = 'ID';
  static const String date = 'Date';
  static const String challan = 'Challan/ Invoice Nos/ Gate Pass';
  static const String poNumber = 'PO Number';
  static const String materialBriefDescription = 'Material Brief Description';
  static const String materialComingFromBriefDescription =
      'Material coming from (Brief Description)';
  static const String sendersName = 'Senders Name';
  static const String isOriginalReceiverReceiving =
      'Is original receiver receiving';
  static const String receivedFor = 'Received For';
  static const String receiverEmployeeId = 'Received by Employee Id';
  static const String receiverDepartment = 'Receiver Department';
  static const String receivedBy = 'Received By';
  static const String receivedForEmployeeId = 'Received for Employee Id';
  static const String receiverSignature = 'Receiver Signature';
  static const String securitySignature = 'Security Signature';
  static const String addQuantity = 'Add Unit';
  static const String isPhysicallyChecked = 'Is Material Physically Checked';
  static const String comment = 'Comment';
  static const String rejectionComment = 'Rejection Comment';

  static const String isMaterialPhysicallyChecked =
      'Is Material Physically Checked';
  static const String actualDateOfReturn = 'Actual Date Of Return';
  static const String equipmentNo = 'Equipment No/Identification';
  static const String address = 'Address';
  static const String requestorEmail = 'Requestor Email';
  static const String requestorEmployeeId = 'Requestor Employee Id';
  static const String requestorDepartment = 'Requestor Department';
  static const String sentTo = 'Sent To';
  static const String purpose = 'Purpose';
  static const String preparedBy = 'Prepared By';
  static const String preparedByDepartment = 'Prepared By Department';
  static const String approver1Email = 'Approver1 Email';
  static const String returnReceiverEmail = 'Return Receiver Email';
  static const String approver2Email = 'Approver2 Email';
  static const String approver1Department = 'Approver1 Department ';
  static const String approver2Department = 'Approver2 Department ';
  static const String takenOutBy = 'Taken Out By';
  static const String takenOutByContactNo = 'Taken Out By Contact No.';
  static const String takenOutAddress = 'Taken Out Address';
  static const String takenOutOn = 'Taken Out On';
  static const String expectedDateOfReturn = 'Expected Date Of Return';
  static const String rejectedBy = 'Rejected By';
  static const String rejectedDate = 'Rejected Date';
  static const String rejectedComment = 'Rejected Comment';

  static const String approvedBy = 'Approved By';
  static const String approvedDate = 'Approved Date';

  ///Guarding Operations
  static const String guardingRates = 'Guarding Rates';
  static const String createGuardingRatingCards =
      'Create Guarding Rating Cards';
  static const String guardingOfficialRatingCards =
      'Guarding Official Rating Cards';
  static const String guardingRatingInformation = 'Guarding Rating Information';
  static const String guardingMasterData = 'Guarding Master Data';
  static const String guardingMasterReport = 'Guarding Master Report';
  static const String guardingRate = 'Guarding Rates';
  static const String escalationMatrix = 'Escalation Matrix';
  static const String femaleDropPickUp = 'Female Drop PickUp';
  static const String keyManagementData = 'Key Management Data';
  static const String slaViolationPenalty = 'SLA Violation Penalty';

  static const String vendor = 'Vendor';
  static const String guardingVendor = 'Guarding Vendor';
  static const String previous = 'Previous';
  static const String next = "Next";
  static const String createSecurityGuard = 'Create Security Guard';
  static const String createSecuritySupervisor = 'Create Security Supervisor';
  static const String createSecurityOfficer = 'Create Security Officer';
  static const String createSecurityFacilitator = 'Create Security Facilitator';
  static const String createGunMan = 'Create Gun Man';
  static const String addSecurityGuard = 'Security Guard';
  static const String createOthers = 'Create Others';

  static const String monthlyCost = 'Monthly Cost';
  static const String days = 'Days';
  static const String perHour = 'Per Hour';
  static const String fromDate = 'From Date';
  static const String toDate = 'To Date';

  static const String guardingMasterReportTitle = 'Guarding Master Report List';
  static const String guardingMasterDataTitle = 'Guarding Master Data List';

  /// Guarding Master Data
  static const String createGuardingMasterData = 'Create Guarding Master Data';
  static const String editGuardingMasterData = 'Edit Guarding Master Data';
  static const String guardingPoc = 'Guarding Partner POC';
  static const String guardingAgencyEmpCode = 'Guarding Agency Employee Code';
  static const String rank = 'Rank';
  static const String selectForShift = 'Select For Shift: ';
  static const String zone = 'Zone';
  static const String areaNameManager = 'Area  Manager Name';
  static const String guardName = 'Name';
  static const String typeOfDuty = 'Type of Duty';
  static const String gender = 'Gender';
  static const String maritalStatus = 'Marital Status';
  static const String typeOfDeployment = 'Type of Deployment';
  static const String mSGBFormBSubmitted = 'MSGB Form B Submitted';
  static const String systemAccess = 'System Access';
  static const String deploymentOrderSubmitted = 'Deployment Order Submitted?';
  static const String mSGBExempted = 'MSGB Exempted';
  static const String trainingCertificate = 'Training Certificate?';
  static const String onBoarded = 'MIS Trigger(for on-boarding)';
  static const String specialAchievements = 'Special Achievements?';
  static const String csrParticipation = 'Participated in CSR';
  static const String additionalQualification =
      'Additional Qualification/Certifications';
  static const String qualificationCompletionDate =
      'Qualification Completion Date';
  static const String specialAchievementsInfo = 'Special Achievements Info';
  static const String achievementsDate = 'Achievement Date';
  static const String additionalInitiativesInfo = 'Additional Initiatives Info';
  static const String initiativesDate = 'Initiative Date';

  static const String participationDate = 'Participation Date';
  static const String csrParticipationDate = 'Add CSR Participation Date';
  static const String dbEmployeeId = 'DB Employee ID';
  static const String buildingLocation = 'Building Location';
  static const String mobileNum = 'Mobile Number';
  static const String dependentsNo = 'Dependents';
  static const String physicallyFit = 'Physically Fit?';
  static const String qualifications = 'Qualifications';
  static const String dateOfBirth = 'Date of Birth';
  static const String dateOfJoining = 'Date of Joining';
  static const String pvcIssuedDate = 'PVC Issued Date';
  static const String pvcExpiryDate = 'PVC Expiry Date';
  static const String medicalCertificateValidUntil =
      'Medical Certificate Valid Until';
  static const String dateOfFirstCovidDose = 'Date of First COVID Dose';
  static const String dateOfSecondCovidDose = 'Date of Second COVID Dose';
  static const String dateOfPrecautionaryCovidDose =
      'Date of Precautionary COVID Dose';
  static const String ertCertificationDate = 'ERT Certification Date';
  static const String firstAidTrainingCompletionDate =
      ' First Aid Training Completion Date';
  static const String esicNo = 'ESIC NO';
  static const String uanNo = 'UAN NO';
  static const String mSGBExemptionDate = 'MSGB Exemption Date';
  static const String localAddress = 'Local Address';
  static const String localLanguage = 'Local Language';
  static const String localLanguageProficiency = 'Local Language Proficiency';
  static const String hindiLanguageProficiency = 'Hindi Language Proficiency';
  static const String englishLanguageProficiency =
      'English Language Proficiency';
  static const String read = 'Read';
  static const String write = 'Write';
  static const String speak = 'Speak';
  static const String permanentAddress = 'Permanent Address';
  static const String uploadPermanentAddressProof =
      'Upload Permanent Address Proof';
  static const String uploadLocalAddressProof = 'Upload Local Address Proof';
  static const String securityExperience = 'Security Experience';
  static const String addParticipationDates = 'Add Participation Date';
  static const String uploadBioData = 'Upload Bio Data';
  static const String uploadMedicalCertificate = 'Upload Medical Certificate';
  static const String uploadTrainingCertificate = 'Upload Training Certificate';
  static const String uploadDeploymentOrderFile =
      'Upload Deployment Order File';
  static const String addQualificationType = 'Add Qualification';

  // Event Protection
  static const String eventProtectionTitle = 'Event Protection';
  static const String generalInformation = 'General Information';
  static const String guardInformation = 'Guard Information';
  static const String beforeEventInformation = 'Before the Event Information';
  static const String duringEventInformation = 'During the Event Information';
  static const String afterEventInformation = 'After the Event Information';
  static const String eventStartedAt = 'Event Started at';
  static const String eventConcludedAt = 'Event Concluded at';
  static const String additionalEmails = 'Additional Emails';
  static const String eventProtectionManager1 = 'Event protection Manager 1';
  static const String eventProtectionManager2 = 'Event protection Manager 2';
  static const String locationSecurityManager1 = 'Location Security Manager 1';
  static const String locationSecurityManager2 = 'Location Security Manager 2';
  static const String lsm1ContactNo = 'LSM 1 Contact No';
  static const String lsm2ContactNo = 'LSM 2 Contact No';
  static const String businessPoc = 'Business POC';
  static const String businessPocEscalation = 'Business POC Escalation';
  static const String pONumber = 'PO Number';
  static const String budget = 'Budget Costs (in INR)';
  static const String isExtraSecurityDeployed = 'Is Extra Security Deployed';
  static const String totalDutyHours = 'Total Duty Hours';
  static const String numOfSecurityOfficers = 'No. Of Security Officers';
  static const String numOfSecuritySupervisor = 'No. Of Security Supervisor';
  static const String numOfSecurityGuards = 'No. Of Security Guards';
  static const String numOfSecurityFacilitators =
      'No. Of Security Facilitators';
  static const String guardingVendorId = 'Guarding Vendor Id';
  static const String guardingAgencyPOC = 'Guarding Agency POC';
  static const String subRegionalHead1 = 'Sub Regional Head (SRH) 1';
  static const String subRegionalHead2 = 'Sub Regional Head (SRH) 2';
  static const String businessPocContactNo = 'Business POC Contact No';
  static const String businessPocEscalationContactNo =
      'Business POC Escalation Contact No';
  static const String requesterDepartment = 'Requester Department';
  static const String isExtraSecurityDeploymentRequired =
      'Is Extra Security Deployment Required';
  static const String systemVendor1Email = 'System Vendor 1 Email';
  static const String systemVendor2Email = 'System Vendor 2 Email';
  static const String vendor1ContactNO = 'Vendor 1 Contact No';
  static const String vendor2ContactNO = 'Vendor 2 Contact No';
  static const String systemVendor3Email = 'System Vendor 3 Email';
  static const String vendor3ContactNO = 'Vendor 3 Contact No';
  static const String primaryServiceEngineerName =
      'Primary Service Engineer Name :';
  static const String secondaryServiceEngineerName =
      'Secondary Service Engineer Name :';
  static const String primaryServiceEngineerContact =
      'Primary Service Engineer Contact :';
  static const String secondaryServiceEngineerContact =
      'Secondary Service Engineer Contact :';
  static const String businessPocDepartment = 'Business POC Department';
  static const String businessPocEscalationDepartment =
      'Business POC Escalation Department';
  static const String eventProtectionOfficers = 'Event protection Officer(s)';
  static const String proposedVendors = 'Proposed Event Management Vendors';
  static const String eventStartDate = 'Event Start Date';
  static const String eventEndDate = 'Event End Date';
  static const String isAnnualPowerShutdown = 'Is Annual Power Shutdown';

  static const String incident = 'Incident';
  static const String ticketLifeCycle = 'Ticket Life Cycle';
  static const String externalVendor = 'External Vendor';
  static const String incidentType = 'Incident Type';
  static const String dbComplaint = 'DB Complainant';
  static const String incidentDescription = 'Incident Description';
  static const String incidentDateTime = 'Incident Date and Time';
  static const String complaint = 'Complainant';
  static const String complaintEmployeeId = 'Complainant Employee Id';
  static const String complaintDepartment = 'Complainant Department';
  static const String complaintHR = 'Complainant Manager/Host';
  static const String incidentLocation = 'Incident Location';
  static const String incidentManager = 'Incident Manager';
  static const String incidentOwner = 'Incident Owner';
  static const String closureTargetDate = 'Target Date of Closure';

  static const String assetType = 'Asset Type';

  //Occurrence
  static const String createOccurrence = 'Create Occurrence';
  static const String editOccurrence = 'Edit Occurrence';
  static const String shiftHandoverBy = 'Shift Handover By  ';
  static const String shiftTakenOverBy = 'Shift Taken Over By';
  static const String shiftBriefingAttended = 'Shift Briefing Attended';
  static const String premisesRoundTaken = 'Premises Round Taken';
  static const String medicalEmergency = 'Medical Emergency';
  static const String lEOVisit = 'LEO Visit';
  static const String incidentItemList = 'Incident Item List';
  static const String securitySystemSLAList = 'Security System SLA List';
  static const String socialEngineeringIncidents =
      'Social Engineering Incidents?';
  static const String addPowerFailuresDates = 'Add Power Failure Date';
  static const String foundArticleTransaction = 'Found Article Transaction?';
  static const String processBreachIncident = 'Process Breach Incident?';
  static const String anyInfrastructuralIssue = 'Any Infrastructural Issue? ';
  static const String anySuspiciousActivity = 'Any Suspicious Activity?';
  static const String fireAlarmEmergencyOccurred =
      'Fire Alarm Emergency Occurred';
  static const String landlordIssue = 'Landlord Issue?';
  static const String securitySystemFailureIncidents =
      'Security System Failure Incidents?';
  static const String anySystemAlarmReceived = 'Any System Alarm Received?';
  static const String transportIncident = 'Transport Incident?';
  static const String anyEvent = 'Any Event?';
  static const String notifySCRI = 'Notify SCRI  ';
  static const String powerFailure = 'Power Failure?';
  static const String aTMVendorVisit = 'ATM Vendor Visit?';
  static const String cWMVisit = 'CWM Visit?';
  static const String dgWrking = 'DG Working';
  static const String followUp = 'Follow Up Actions For Next Shift';
  static const String followedUp = 'Followed Up ';
  static const String powerFailuresDate = 'Power Failure Start & End Date';
  static const String powerFailureDate = 'Power Failure Start Date & Time';
  static const String powerFailureEndDate = 'Power Failure End Date & Time';
  static const String systemManager = 'System Manager';
  static const String lsm = 'LSM';
  static const String securityLead = 'Security Lead';
  static const String asl = 'ASL';
  static const String system = 'System';
  static const String vendorPoc = 'Vendor Poc';
  static const String escalation1Poc = 'Escalation 1 Poc';
  static const String escalation2Poc = 'Escalation 2 Poc';
  static const String escalation3Poc = 'Escalation 3 Poc';
  static const String locationTeam = 'Location Team';
  static const String shortIncidentDescription =
      'Short Description of Incident';
  static const String detailIncidentDescription = 'Detail Description';
  static const String ipbArea = 'IPB Area';
  static const String colourMake = 'Colour/Make/Model';

  static const String showDetails = 'Show Details';

  //SLA Violation Penalty
  static const String sLAViolationPenalty = 'SLA Violation Penalty';

  //Contact Details
  static const String phoneNumber = 'Phone Number';
  static const String generalContact = 'General Contact';
  static const String guardingAgencyContact =
      'Guarding Agency Escalation Contact';
  static const String systemEscalationContact = 'System Escalation Contact';
  static const String supervisorContact = 'Supervisor Contact';
  static const String cmsEscalationContact = 'CMS Escalation(IPB)';
  static const String guardingAgencyZonalManagerContact =
      'Guarding Agency Zonal Manager';
  static const String escalationLevel = 'Escalation Level';
  static const String modifiedDate = 'Modified Date';
  static const String guardingAgencyRank = 'Guarding Agency Escalation Rank';
  static const String supervisorRank = 'Supervisor Rank';
  static const String systemSiEscalationMatrixRank =
      'System (SI) Escalation Matrix';

  ///SLA Violation Penalty
  static const String typeOfService = 'Type Of Service';
  static const String aSL = 'ASL';
  static const String violationPenalty = 'Violation Penalty';
  static const String penaltyAmount = 'Penalty Amount';
  static const String totalNoOfViolations = 'Total No Of Violations';
  static const String totalPenaltyAmount = 'Total Penalty Amount';
  static const String violation = 'Violation';
  static const String staffCategory = 'Staff Category';
  static const String slaViolation = 'SLA_VIOLATION_DESCRIPTION';
  static const String addGuardingAgencyPOC = 'Add Guarding Agency POC';

  ///KeyManagementData
  static const String keyManagementMaster = 'Key Management Master';
  static const String keyManagementIssuance = 'Key Management Issuance';
  static const String keyReconciliationList = 'Key Reconciliation List';
  static const String keyLossDestructionList = 'Key Loss Destruction List';

  /// KeyManagementMaster
  static const String editkeyManagementMaster = 'Edit Key Management Master';
  static const String createkeyManagementMaster =
      'Create Key Management Master';
  static const String floor = 'Floor';
  static const String keyType = 'Key Type';
  static const String keyNo = 'Key No';
  static const String totalKeys = 'Total Keys';
  static const String noOfKeys = 'No.of Keys';
  static const String noOfMasterKeys = 'Number of Master Keys';
  static const String keyDescription = 'Key Description';
  static const String keyTaggingDone =
      'Key Tagging Done? (Numbered Matching with lock)';
  static const String doorHasAccessControl = 'Door Has Access Control';
  static const String doorHasLockAndKeyMechanism =
      'Door Has Lock and Key Mechanism';
  static const String howAndWhereTheKeysAreStored =
      'How and Where The Keys are Stored';
  static const String lockChangeHistory = 'Lock Change History';
  static const String keyLostHistory = 'Key Lost History';
  static const String keyDamageHistory = 'Key Damage History';
  static const String keyDestroyHistory = 'Key Destroy History';
  static const String createLockChangeHistory = 'Create Lock Change History';
  static const String createKeyLostHistory = ' Create Key Lost History';
  static const String createKeyDamageHistory = 'Create Key Damage History';
  static const String createKeyDestroyHistory = 'Create Key Destroy History';
  static const String editLockChangeHistory = ' Edit Lock Change History';
  static const String editKeyLostHistory = 'Edit Key Lost History';
  static const String editKeyDamageHistory = 'Edit Key Damage History';
  static const String editKeyDestroyHistory = 'Edit Key Destroy History';
  static const String type = 'Type';
  static const String srh = 'SRH';
  static const String securityManager = 'Security Manager';
  static const String investigationRequired = 'Investigation Required?';
  static const String destructionReason = 'Reason for Key Destruction';
  static const String detailsOfLostKey = 'Details of Lost Key';
  static const String modifiedBy = 'Modified By';
  static const String modifiedOn = 'Modified On';
  static const String totalAllocated = 'Total Allocated';
  static const String returned = 'Returned';
  static const String notReturned = 'Not Returned';
  static const String lost = 'Lost';
  static const String damaged = 'Damaged';
  static const String localChangeHistoryType = 'LOCK_CHANGE_HISTORY';
  static const String keyLostHistoryType = 'KEY_LOST_HISTORY';
  static const String keyDamageHistoryType = 'KEY_DAMAGE_HISTORY';
  static const String keyDestroyHistoryType = 'KEY_DESTROY_HISTORY';

  ///KeyManagementIssuance
  static const String createKeyManagementIssuance =
      'Create Key Management Issuance';
  static const String editKeyManagementIssuance =
      'Edit Key Management Issuance';
  static const String handedOverTo = 'Handed Over To';
  static const String keyReturnDueDate = 'Key Return Due Date';
  static const String keyReturnDateAndTime = 'Key Return Date And Time';
  static const String returnedByName = 'Returned By Name';

  static const String employeeType = 'Employee Type';
  static const String keyHandingOverDuration = 'Key Handing Over Duration';
  static const String dbSponsorOfCWRT2 = 'DB Sponsor of CWR T2';
  static const String keyIssuanceProcess = 'Key Issuance Process';
  static const String keys = 'Keys';
  static const String keysAvailable = 'Keys Available';
  static const String alreadyIssuedKeys = 'Already Issued Keys';
  static const String keysReturned = 'Keys Returned';
  static const String keysNotReturned = 'Keys Not Returned';
  static const String keysLost = 'Keys Lost';
  static const String keysDamaged = 'Keys Damaged';
  static const String noKeysIssued = 'No. Keys Issued';
  static const String handedOverDate = 'Handed Over Date';
  static const String editKeyLossDestruction = 'Edit Key Loss Destruction';

  /// Duty Post Master
  static const String dutyPostMaster = 'Duty Post Master';
  static const String editDutyPostMaster = 'Edit Duty Post Master';
  static const String createDutyPostMaster = 'Create Duty Post Master';
  static const String dutyPostName = 'Duty Post Name';
  static const String aShift = 'A Shift(7AM-3PM)';
  static const String bShift = 'B Shift(3PM-11PM)';
  static const String cShift = 'C Shift(11PM-7AM)';
  static const String gShift = 'G Shift(9AM-6PM)';
  static const String total = 'Total';

  /// Duty Post Name Master
  static const String dutyPostNameMaster = 'Duty Post Name Master';
  static const String editDutyPostNameMaster = 'Edit Duty Post Name Master';
  static const String createDutyPostNameMaster = 'Create Duty Post Name Master';
  static const String dutyPostLocationName = 'Post Location Name';
  static const String region = 'Region';
  static const String addDutyPostLocationName = 'Add Duty Post Location Name';
  static const String isTransportShift = 'is Transport Shift?';

  ///Attendance
  static const String attendance = 'Attendance';
  static const String attendanceReportBilling = 'Attendance Report and Billing';
  static const String editAttendance = 'Edit Attendance';
  static const String attendanceDetails = 'Attendance Details';
  static const String attendanceType = 'Attendance Type';

  ///Shift Schedule
  static const String shiftScheduling = 'Shift Scheduling';
  static const String shiftSchedule = 'Shift Schedule';
  static const String editShiftSchedule = 'Edit Shift Schedule';
  static const String createShiftSchedule = 'Create Shift Schedule';
  static const String dutyType = 'Duty Type';
  static const String addReplacement = 'Add Replacement';
  static const String replacementFor = 'Replacement For';
  static const String replacementBy = 'Replacement By';
  static const String reason = 'Reason';
  static const String poc = 'POC';
  static const String addPOC = 'Add POC';

  ///VVIP Visitors
  static const String vVipVisitors = 'VVIP Visitor';
  static const String listVvipVisitors = 'List of VVIP Visitor';
  static const String visitorsName = 'Visitor Name';
  static const String visitorsEmailId = 'Visitor Email ID';
  static const String visitorsDesignation = 'Visitor Designation';
  static const String purposeOfVisit = 'Purpose of Visit';
  static const String baseLocationOfVisitors = 'Base Location of Visitor';
  static const String startDateVisit = 'Start Date of Visit';
  static const String endDateVisit = 'End Date of Visit';

  ///Ticket Life Cycle
  static const String sentReminder = 'Reminder Sent';

  ///Module Code for roles
  static const String passManagementRolesModuleCode = 'PM';
}

//static const String height = 'Height(cm)';

/// Quill Html Editor
// String htmlSample =
//     "<html><p><img src=\"data:image/jpeg;base64,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\" /></p>\n\n<p>Dear All,</p>\n\n<p>&nbsp;</p>\n\n<p>Please find first update of the event.<br />\nEvent started at&nbsp; [[startTime]]</p>\n\n<p><br />\n1. Onsite/ remote security support&nbsp;<br />\n2. Venue Security staff briefing time?<br />\n3. Security staff deployed time?<br />\n4. Total number of security staff for venue security<br />\n5. Additional Security Equipment Deployment if any (Fire extinguisher/ DFMD/HHMD/Baggage Scanner)<br />\n6. Ambulance stationed and briefing to ambulance staff<br />\n7. Event Venue Sanitization Completed Time<br />\n8. Event Started at<br />\n9. Number of Participants in the event<br />\n10. Number of member from Corporate Security present for event security (SDM/ASL/SSM/SM/SL/DSL)</p>\n\n<p>&nbsp;</p>\n\n<p>Kind Regards,</p>\n\n<p>Location Security Team</p>\n</html>";
final customToolBarList = [
  ToolBarStyle.bold,
  ToolBarStyle.italic,
  ToolBarStyle.align,
  ToolBarStyle.color,
  ToolBarStyle.background,
  ToolBarStyle.listBullet,
  ToolBarStyle.listOrdered,
  ToolBarStyle.clean,
  ToolBarStyle.addTable,
  ToolBarStyle.editTable,
];

final toolbarColor = Colors.grey.shade200;
const backgroundColor = Colors.white70;
const toolbarIconColor = Colors.black87;
const editorTextStyle = TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto');
const hintTextStyle = TextStyle(
    fontSize: 18, color: Colors.black38, fontWeight: FontWeight.normal);

/// Quill Html Editor
