import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hpcompose/data/datasource/local/shared_preferences_manager.dart';
import 'package:hpcompose/modules/auth/data/auth_service.dart';
import 'package:hpcompose/modules/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._authService, this._prefsManager);

  final AuthService _authService;
  final SharedPreferencesManager _prefsManager;

  @override
  Future<GoogleSignInAuthentication?> signInWithGoogle() async {
    final googleAuth = await _authService.signInWithGoogle();
    if (googleAuth != null) {
      _prefsManager.setToken(googleAuth.idToken!);
    }
    return googleAuth;
  }

  @override
  Future<dynamic> signInWithFacebook() async {
    final userCredential = await _authService.signInWithFacebook();
    return userCredential;
  }
}
