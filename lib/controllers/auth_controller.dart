import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

import '../models/facebook/facebook_user_model.dart';
import '../repos/auth_repo.dart';

class AuthController extends GetxController {
  final AuthRepo _authRepo = AuthRepo();

  // Google
  Future<User?> signInWithGoogle() async {
    try {
      var user = await _authRepo.signInWithGoogle();

      return user;
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future<void> googleSignOut() async {
    await _authRepo.googleSignOut();
  }

  // Facebook
  Future<LoginResult> signInWithFacebook() async {
    LoginResult result = LoginResult(status: LoginStatus.operationInProgress);
    try {
      result = await _authRepo.signInWithFacebook();
    } catch (ex) {
      print(ex.toString());
    }

    return result;
  }

  Future<void> facebookSignOut() async {
    try {
      await _authRepo.facebookSignOut();
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future<FacebookUserModel> getFacebookUSerData() async {
    FacebookUserModel userModel = FacebookUserModel();
    try {
      userModel = await _authRepo.getFacebookUSerData();
    } catch (ex) {
      print(ex.toString());
    }

    return userModel;
  }
}