import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleService {
  bool _isGoogleSignInInitialized = false;
  static final Logger _logger = Logger();
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<void> _init() async {
    try {
      await _googleSignIn.initialize();
      _isGoogleSignInInitialized = true;
    } catch (e) {
      _logger.e('Falló la inicialización de la clase de google: $e');
    }
  }


  Future<void> _ensureInit() async {
    if (!_isGoogleSignInInitialized) {
      await _init();
    }
  }

  GoogleService() {
    _init();
  }

  Future<bool> logIn(BuildContext context) async {
    bool ok = false;
    try {
      await _ensureInit();
      GoogleSignInAccount account = await _googleSignIn.authenticate(
        scopeHint: ['email', 'profile'],
      );

      GoogleSignInAuthentication auth = account.authentication;
      String idToken = auth.idToken ?? '';
      if (idToken.isNotEmpty) {
        SharedPreferences.getInstance().then((current) {
          current.setString("idToken", idToken);
          current.setString("email", account.email);
          current.setString("name", account.displayName ?? '');
          current.setString("photoUrl", account.photoUrl ?? '');
        });
        ok = true;
      }
    } catch (error, stackTrace) {
      _logger.e(error);
      _logger.t(error, stackTrace: stackTrace);
    }
    return ok;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    SharedPreferences.getInstance().then((current) {
      current.setString("idToken", '');
      current.setString("email", '');
      current.setString("name", '');
      current.setString("photoUrl", '');
    });
  }
}
