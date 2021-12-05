import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/models/auth/auth_user_model.dart';
import 'package:mixture_music_app/models/auth/facebook/facebook_user_model.dart';

import '../repos/auth_repo.dart';

class AuthController extends GetxController {
  final AuthRepo _authRepo = AuthRepo();
  User? googleUser;

  LoginResult get facebookLoginResult => _authRepo.facebookLoginResult;

  AccessToken? get facebookAccessToken => _authRepo.facebookAccessToken;

  // Google
  Future<User?> signInWithGoogle() async {
    try {
      var user = await _authRepo.signInWithGoogle();
      googleUser = user;

      return user;
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future<void> googleSignOut() async {
    await _authRepo.googleSignOut();
  }

  // Facebook
  Future<LoginResult?> signInWithFacebook() async {
    LoginResult? result;
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

  Future<FacebookUserModel> getFacebookUserData() async {
    FacebookUserModel userModel = FacebookUserModel();
    try {
      userModel = await _authRepo.getFacebookUserData();
    } catch (ex) {
      print(ex.toString());
    }

    return userModel;
  }

  Future<void> addUser({
    required String userName,
    required String password,
  }) async {
    return await _authRepo.addUser(userName: userName, password: password);
  }

  Future<QuerySnapshot<dynamic>> getAllAccountFromFirebase() async {
    return await _authRepo.getAllAccountFromFirebase();
  }

  Future<bool> checkIfUserExisted(String userName) async {
    return await _authRepo.checkIfUserExisted(userName);
  }

  Future<AuthUserModel?> getUserByUserName(String userName) async {
    return await _authRepo.getUserByUserName(userName);
  }

  Future<void> resetAccountPassword(String userName, String newPassword) async {
    return await _authRepo.resetAccountPassword(userName, newPassword);
  }
}
