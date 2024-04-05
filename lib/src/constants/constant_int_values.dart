class ConstantsIntValue {
  /// Key Management
  static const int lockChangeHistoryInt = 0;
  static const int keyLostHistoryInt = 1;
  static const int keyDamageHistoryInt = 2;
  static const int keyDestroyHistoryInt = 3;

  /// Pass Management
  static const int passCategoryPermanent = 0;
  static const int passCategoryTemporary = 1;

  // Status
  static const int passStatusCreated = 0;
  static const int passStatusHandedOver = 1;



  static const int passIdDayPass = 0;
  static const int passIdVisitor = 1;
  static const int passIdVendor = 2;
  static const int passIdSez = 3;

  static const String sezCompanyTypes = 'ATOM_SEZ_COMPANY_TYPES';

  static const int businessUserReview = 1;

  // Status
  static const String passStatusReturned = 'Returned';
  static const String passStatusLostDeActivated = 'Lost/De-Activated';
  static const String passStatusDamagedDeActivated= 'Damaged/De-Activated';
  static const String passStatusDefaced = 'Defaced';
  static const String passStatusCancelled = 'Cancelled';
  static const String passStatusReturnedDamaged = 'Returned/Damaged';
  static const String passStatusReturnedDefaced = 'Returned/Defaced';




  /// Shift Occurence
  static const int submitted = 1;

///Key Management Master
  static const int genderMale = 1;
  static const int genderFemale = 2;
  static const int genderTransgender = 3;


  ///Key Management Master history status
  static const int created = 0;
  static const int lockChangeInitiated = 1;
  static const int lostInitiated = 2;
  static const int damagedInitiated = 3;
  static const int lostApproved =4;
  static const int damagedApproved = 5;
  static const int investigationInitiated = 6;
  static const int destroyInitiated = 7;
  static const int destroyRejected = 8;
  static const int destroyApproved = 9;
  static const int closed = 10;

  ///Shift Schedule status
  static const int draft = 0;
  static const int active = 1;
  static const int inActive= 2;
  static const int cancelled = -1;


}
