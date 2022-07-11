import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  const AuthService(this._dio);

  final Dio _dio;

  Future<GoogleSignInAuthentication?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    inspect(userCredential);
    return googleAuth;
  }

  Future<dynamic> signInWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    if (loginResult.status == LoginStatus.success) {
      inspect(loginResult.accessToken);
      final userData = await FacebookAuth.instance.getUserData();
      inspect(userData);
    }
    return null;
  }
}
