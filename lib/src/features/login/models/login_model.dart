import 'package:db_atom/src/models/organisation.dart';

class LoginResponseModel {
  String? message;
  String? token;
  LoginUserResponseModel? user;
  String? refreshToken;
  bool? requirePasswordChange;

  LoginResponseModel({
    this.message,
    this.token,
    this.user,
    this.refreshToken,
    this.requirePasswordChange,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      message = json['message'] as String?;
      token = json['token'] as String?;
      user = (json['user'] as Map<String, dynamic>?) != null
          ? LoginUserResponseModel.fromJson(
              json['user'] as Map<String, dynamic>)
          : null;
      refreshToken = json['refreshToken'] as String?;
      requirePasswordChange = json['requirePasswordChange'] as bool?;
    } catch (e) {
      // Log the exception
      print('Error parsing JSON: $e');

      // Log the specific variable causing the issue
      if (json['message'] == null) {
        print('Error: "message" is null');
      }
      if (json['token'] == null) {
        print('Error: "token" is null');
      }
      if (json['user'] == null) {
        print('Error: "user" is null');
      }
      if (json['refreshToken'] == null) {
        print('Error: "refreshToken" is null');
      }
      if (json['requirePasswordChange'] == null) {
        print('Error: "requirePasswordChange" is null');
      }

      // Handle the exception or throw it again if needed
      // ...
    }
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'token': token,
        'user': user?.toJson(),
        'refreshToken': refreshToken,
        'requirePasswordChange': requirePasswordChange
      };
}

class LoginUserResponseModel {
  int? userId;
  String? userName;
  String? email;
  String? firstName;
  String? lastName;

  String? phone;
  Organisation? defaultLocation;
  DisplayMenu? displayMenu;
  String? timezone;

  LoginUserResponseModel({
    this.userId,
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.defaultLocation,
    this.displayMenu,
    this.timezone,
  });

  LoginUserResponseModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int?,
        userName = json['userName'] as String?,
        email = json['email'] as String?,
        firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?,
        phone = json['phone'] as String?,
        defaultLocation =
            (json['defaultLocation'] as Map<String, dynamic>?) != null
                ? Organisation.fromJson(
                    json['defaultLocation'] as Map<String, dynamic>)
                : null,
        displayMenu = (json['displayMenu'] as Map<String, dynamic>?) != null
            ? DisplayMenu.fromJson(json['displayMenu'] as Map<String, dynamic>)
            : null,
        timezone = json['timezone'] as String?;

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'userName': userName,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'defaultLocation': defaultLocation?.toJson(),
        'displayMenu': displayMenu?.toJson(),
        'timezone': timezone
      };
}

class DisplayMenu {
  bool? mM;
  bool? sSSLA;
  bool? cD;
  bool? iM;
  bool? aF;
  bool? gM;
  bool? lEO;
  bool? gR;
  bool? eP;
  bool? aps;
  bool? dP;
  bool? pM;
  bool? oCC;

  DisplayMenu({
    this.mM,
    this.sSSLA,
    this.cD,
    this.iM,
    this.aF,
    this.gM,
    this.lEO,
    this.gR,
    this.eP,
    this.aps,
    this.dP,
    this.pM,
    this.oCC,
  });

  DisplayMenu.fromJson(Map<String, dynamic> json)
      : mM = json['MM'] as bool?,
        sSSLA = json['SSSLA'] as bool?,
        cD = json['CD'] as bool?,
        iM = json['IM'] as bool?,
        aF = json['AF'] as bool?,
        gM = json['GM'] as bool?,
        lEO = json['LEO'] as bool?,
        gR = json['GR'] as bool?,
        eP = json['EP'] as bool?,
        aps = json['APS'] as bool?,
        dP = json['DP'] as bool?,
        pM = json['PM'] as bool?,
        oCC = json['OCC'] as bool?;

  Map<String, dynamic> toJson() => {
        'MM': mM,
        'SSSLA': sSSLA,
        'CD': cD,
        'IM': iM,
        'AF': aF,
        'GM': gM,
        'LEO': lEO,
        'GR': gR,
        'EP': eP,
        'APS': aps,
        'DP': dP,
        'PM': pM,
        'OCC': oCC
      };
}
