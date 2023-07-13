// Created by Ramesh

class Constants {
  static const String customFontFamily = 'Poppins';
  static const String customFontMediumFamily = 'Poppins-Medium';
  static const String customFontBoldFamily = 'Poppins-Bold';
  static const String customFontRegularFamily = 'Poppins-Regular';
  static const String customFontSemiBoldFamily = 'Poppins-SemiBold';
  static const String customFontMixedFamily = 'Poppins-Mixed';
  static const String appname = 'DB_ATOM';
  static const String unsaveddata = 'Unsaved Data';
  static const String unsaveddatadesc = "There is unsaved data. Do you want to exit anyhow?";

  // Validations
  static const String enterusername = 'Please enter valid username';
  static const String enterpassword = 'Please enter valid password';
  static const String invalidusername = 'Invalid username';
  static const String logoutvalidation = "Are you  sure, do you want to logout?";

  // Sharedpreferences keys
  static const String isLoggedInKey = 'isLoggedIn';
  static const String isUserNameKey = 'isUserName';
  static const String isUserIdKey = 'isUserId';
  static const String isMenuIndexIdentifyKey = 'isMenuIndexIdentify';

  // Images
  static const String bg = 'assets/images/bg.png';
  static const String splashscreen = 'assets/images/Arlantologin.png';

  // Names
  static const String version = 'Version';

  //Login
  static const String hintUserName = 'Enter user name';
  static const String hintPassword = "Enter password";
  static const String userError = "Please enter username";
  static const String passwordError = "Please enter password";
  static const String passwordLengthError = "Please enter password minimum 6 characters";
  static const String loginButtonTitle = "Login";
  static const String titleHeaderLogin = "Welcome back, Login!!";
  static const String email = "Email";
  static const String password = "Password";
  static const String forgotpassowrd = 'Forgot Password?';
  static const String supporttext = "Support: +49 6150 961 6244";
  static const String copyrighttext = "Copyright Â© 2023 RimaOne.";

  //Dashboard
  static const String home = 'Home';
  static const String dashboard = 'Dashboard';
  static const String securityfunctions = 'Security functions';
  static const String operations = "Operations";
  static const String settings = "Settings";
  static const String administration = "Administration";
  static const String profile = 'Profile';
  static const String articlefoundregister = 'Article Found Register';
  static const String lawenforcementvisitslist = 'Law Enforcement Visits List';
  static const String eventprotectionlist = 'Event Protection List';
  static const String materialmovement = 'Material Movement';
  static const String passmanagement = 'Pass Management';
  static const String logout = 'Logout';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String name = 'Name';
  static const String key = 'Key';

  // Create Found
  static const String createfound = 'Create Found';
  static const String generalinformation = 'General Information';
  static const String assettype = 'Asset Type';
  static const String foundlocation = 'Found Location';
  static const String quantity = 'Quantity';
  static const String colour = 'Colour';
  static const String depositoremployeeid = 'Depositor Employee Id';
  static const String status = 'Status';
  static const String dateofcreation = 'Date of Creation';
  static const String assetype = 'Asset Type';
  static const String founddate = 'Found Date';
  static const String isdepositordbemployee = 'Is Depositor DBEmployee';
  static const String createdby = 'Created By';
  static const String slno = 'Sl No.';
  static const String articletype = 'Article Type';
  static const String depositor = 'Depositor';
  static const String employeedepartment = 'Employee Department';
  static const String additionalinformation = 'Additional Information';
  static const String informationhere = 'Information here';
  static const String location = 'Location';
  static const String addemployeedepartment = 'Add Employee Department';
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String newuser = 'New User';
  static const String newuserdesc = 'Provide the below data to create a new User.';
  static const String createnewuser = 'Create New User';
  static const String firstname = 'First Name';
  static const String lastname = 'Last Name';
  static const String uploadfile = 'Upload File';
  static const String caotureorupload = 'Capture or Upload';
  static const String addarticletype = 'Add Article Type';
  static const String clicktoupload = 'Click to upload';
  static const String abort = 'Abort';
  static const String internationalization = 'Internationalization';
  static const String nodata = 'No Data Found';
  static const String ok = 'Ok';

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
static const String dateFormat = 'yyyy-MM-dd';
static const String fulldateFormat = 'dd/MM/yyyy a HH:mm:ss';
}
