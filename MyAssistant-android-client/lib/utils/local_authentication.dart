// ignore_for_file: unused_catch_clause

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthenticationAPI {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    return await _auth.canCheckBiometrics;
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();

    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
        localizedReason: 'Scan to access notes',
      );
    } on PlatformException catch (e) {
      return false;
    }
  }
}
