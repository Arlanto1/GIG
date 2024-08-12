class ConstantsIntValue {
  static const int cancelledStatus = -1; // Common for all the modules

  /// Article
  // Status
  static const int articleFoundStatusFound = 0;
  static const int articleFoundStatusUnderSecurityCustody = 1;
  static const int articleFoundStatusHandedOverOrClaimed = 2;

  /// Key Management
  static const int lockChangeHistoryInt = 0;
  static const int keyLostHistoryInt = 1;
  static const int keyDamageHistoryInt = 2;
  static const int keyDestroyHistoryInt = 3;


  /// Event Protection
  static const int eventDurationBefore = 0;
  static const int eventDurationDuring = 1;
  static const int eventDurationAfter = 2;

  /// Pass Management
  static const int passCategoryPermanent = 0;
  static const int passCategoryTemporary = 1;

  /// Pass Management status
  static const int passStatusCreated = 0;
  static const int passStatusHandedOver = 1;
  static const int passStatusReturned = 2;
  static const int passStatusNonReturned = 3;
  static const int passStatusLostDeActivated = 4;
  static const int passStatusDamagedDeActivated = 5;
  static const int passStatusDefacedDeActivated = 6;
  static const int passStatusCancelled = 7;
  static const int passStatusReturnedDamaged = 8;
  static const int passStatusReturnedDefaced = 9;

  static const int passIdDayPass = 0;
  static const int passIdVisitor = 1;
  static const int passIdVendor = 2;
  static const int passIdSez = 3;

  static const String sezCompanyTypes = 'ATOM_SEZ_COMPANY_TYPES';

  // // Status
  // static const String passStatusReturned = 'Returned';
  // static const String passStatusLostDeActivated = 'Lost/De-Activated';
  // static const String passStatusDamagedDeActivated = 'Damaged/De-Activated';
  // static const String passStatusDefaced = 'Defaced';
  // static const String passStatusCancelled = 'Cancelled';
  // static const String passStatusReturnedDamaged = 'Returned/Damaged';
  // static const String passStatusReturnedDefaced = 'Returned/Defaced';

  /// Shift Occurence
  static const int occurrenceStatusCreated = 0;
  static const int submitted = 1;

  /// Key Management Master
  static const int genderMale = 1;
  static const int genderFemale = 2;
  static const int genderTransgender = 3;

  /// Key Management Master history status
  static const int created = 0;
  static const int lockChangeInitiated = 1;
  static const int lostInitiated = 2;
  static const int damagedInitiated = 3;
  static const int lostApproved = 4;
  static const int damagedApproved = 5;
  static const int investigationInitiated = 6;
  static const int destroyInitiated = 7;
  static const int destroyRejected = 8;
  static const int destroyApproved = 9;
  static const int closed = 10;

  /// Shift Schedule status
  static const int shiftScheduleDraft = 0;
  static const int shiftScheduleActive = 1;
  static const int shiftScheduleInActive = 2;

  /// Incident status
  static const int incidentStatusCancelled = 40;
  static const int incidentStatusClosed = 39;

  /// Incident Management
  // static const int incidentStatusCancelled = 40;

  /// LawEnforcement status
  static const int leoStatusDraft = 0;
  static const int leoStatusSubmitted = 1;
  static const int leoStatusVerificationUnderProgress = 2;
  static const int leoStatusDistributed = 3;

  /// SLA Violation status
  static const int slaStatusDraft = 0;
  static const int slaStatusActive = 1;
  static const int slaStatusFinalized = 2;

  ///Material Movement status
  static const int businessUserReview = 1;
  static const int mmStatusDraft = 0;
  static const int mmStatusLSMReview = 3;
  static const int mmStatusLSMApproved = 4;
  static const int mmStatusLSMRejected = 5;
  static const int mmStatusApproved = 6;
  static const int mmStatusInwardWaiting =9;
  static const int mmStatusClosed = 10;

  ///Key Issuance status
  static const int issuanceDraftStatus = 0;
  static const int issuanceHandedOverStatus = 1;
  static const int issuanceNotReturnedStatus = 2;
}
