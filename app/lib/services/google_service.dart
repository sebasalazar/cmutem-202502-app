import 'package:app/consts/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
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
        await _storage.write(key: AppConst.idTokenLabel, value: idToken);

        SharedPreferences.getInstance().then((current) {
          current.setString(AppConst.emailLabel, account.email);
          current.setString(AppConst.nameLabel, account.displayName ?? '');
          current.setString(AppConst.photoUrlLabel, account.photoUrl ?? '');
        });
        ok = true;
      }
    } catch (error, stackTrace) {
      _logger.e(error);
      _logger.t(error, stackTrace: stackTrace);
    }
    return ok;
  }

  Future<String> getToken() async {
    return await _storage.read(key: AppConst.idTokenLabel) ?? '';
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    SharedPreferences.getInstance().then((current) {
      current.setString(AppConst.emailLabel, '');
      current.setString(AppConst.nameLabel, '');
      current.setString(AppConst.photoUrlLabel, '');

      current.remove(AppConst.emailLabel);
      current.remove(AppConst.nameLabel);
      current.remove(AppConst.photoUrlLabel);

      current.clear();
    });

    await _storage.write(key: AppConst.idTokenLabel, value: '');
    await _storage.delete(key: AppConst.idTokenLabel);
    await _storage.deleteAll();
  }
}
