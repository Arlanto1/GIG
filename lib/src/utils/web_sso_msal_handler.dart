import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:msal_auth/msal_auth.dart';

class WebSsoMsalHandler {
  static final String clientId = Environment().config.aadClientId;
  static final String tenantId = Environment().config.aadTenantId;

  // late final _authority =
  //     'https://login.microsoftonline.com/$tenantId/oauth2/v2.0/authorize';
  late final _authority = 'https://login.microsoftonline.com/common';
  final scopes = <String>[
    'https://graph.microsoft.com/user.read',
    // Add other scopes here if required.
  ];

  Future<MsalAuth> getMsalAuth() async {
    log('getMsalAuth');
    return MsalAuth.createPublicClientApplication(
      clientId: clientId,
      scopes: scopes,
      androidConfig: AndroidConfig(
        configFilePath: 'assets/msal_config.json',
        tenantId: tenantId,
      ),
      iosConfig: IosConfig(
          authority: _authority,
          authMiddleware: AuthMiddleware.msAuthenticator,
          tenantType: TenantType.entraIDAndMicrosoftAccount),
    );
  }

  Future<MsalUser?> getToken() async {
    log('getToken');
    try {
      final MsalAuth msalAuth = await getMsalAuth();
      final MsalUser? user = await msalAuth.acquireToken();
      log('User data: ${user?.toJson()}');
      return user;
    } on MsalException catch (e) {
      log('Msal exception with error: ${e.errorMessage}');
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> logout() async {
    try {
      final MsalAuth msalAuth = await getMsalAuth();
      await msalAuth.logout();
    } on MsalException catch (e) {
      log('Msal exception with error: ${e.errorMessage}');
    } catch (e) {
      log(e.toString());
    }
  }
}
