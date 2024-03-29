import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRepository {
  Future<GoogleSignInAuthentication?> signInWithGoogle();

  Future<dynamic> signInWithFacebook();
}
