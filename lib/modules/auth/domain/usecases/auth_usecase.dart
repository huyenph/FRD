import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hpcompose/modules/auth/domain/repositories/auth_repository.dart';

class AuthUseCase {
  const AuthUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<GoogleSignInAuthentication?> signInWithGoogle() =>
      _authRepository.signInWithGoogle();

  Future<dynamic> signInWithFacebook() => _authRepository.signInWithFacebook();
}
