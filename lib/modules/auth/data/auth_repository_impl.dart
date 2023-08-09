import 'package:frd/modules/auth/data/auth_service.dart';
import 'package:frd/modules/auth/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._authService);

  final AuthService _authService;

  @override
  Future<GoogleSignInAuthentication?> signInWithGoogle() async {
    final googleAuth = await _authService.signInWithGoogle();
    if (googleAuth != null) {
      // _prefsManager.setToken(googleAuth.idToken!);
    }
    return googleAuth;
  }

  @override
  Future<dynamic> signInWithFacebook() async {
    final userCredential = await _authService.signInWithFacebook();
    return userCredential;
  }
}
