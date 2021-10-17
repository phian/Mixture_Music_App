import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:mixture_music_app/models/facebook/facebook_user_model.dart';
import 'package:mixture_music_app/services/auth_service.dart';

class AuthRepo {
  AuthService _authService = AuthService();

  // Google
  Future<User?> signInWithGoogle() async {
    try {
      var user = await _authService.signInWithGoogle();

      if (user != null) {
        return user;
      }

      return null;
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future<void> googleSignOut() async {
    await _authService.googleSignOut();
  }

  // Facebook
  Future<LoginResult> signInWithFacebook() async {
    LoginResult result = LoginResult(status: LoginStatus.operationInProgress);
    try {
       result = await _authService.signInWithFacebook();
    } catch (ex) {
      print(ex.toString());
    }

    return result;
  }

  Future<void> facebookSignOut() async {
    try {
      await _authService.facebookSignOut();
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future<FacebookUserModel> getFacebookUSerData() async {
    Map<String, dynamic> userData = {};
    FacebookUserModel userModel = FacebookUserModel();
    try {
      userData = await _authService.getFacebookUSerData();
      userModel = FacebookUserModel.fromJson(userData);
    } catch (ex) {
      print(ex.toString());
    }

    return userModel;
  }
}