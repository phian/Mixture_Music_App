import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:mixture_music_app/models/auth/auth_user_model.dart';
import 'package:mixture_music_app/models/auth/facebook/facebook_user_model.dart';

import '../services/auth_service.dart';

class AuthRepo {
  final AuthService _authService = AuthService();

  User? get googleUser => _authService.googleUser;

  LoginResult get facebookLoginResult => _authService.facebookLoginResult;

  AccessToken? get facebookAccessToken => _authService.facebookAccessToken;
  late FacebookUserModel facebookUser;

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
  Future<LoginResult?> signInWithFacebook() async {
    LoginResult? result;
    try {
      result = await _authService.signInWithFacebook();
      facebookUser = await getFacebookUserData();
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

  Future<FacebookUserModel> getFacebookUserData() async {
    Map<String, dynamic> userData = {};
    FacebookUserModel userModel = FacebookUserModel();
    try {
      userData = await _authService.getFacebookUserData();
      userModel = FacebookUserModel.fromJson(userData);
    } catch (ex) {
      print(ex.toString());
    }

    return userModel;
  }

  Future<void> addUser({
    required String userName,
    required String password,
  }) async {
    return await _authService.addUser(userName: userName, password: password);
  }

  Future<QuerySnapshot<dynamic>> getAllAccountFromFirebase() async {
    return await _authService.getAllAccountFromFirebase();
  }

  Future<bool> checkIfUserExisted(String userName) async {
    var result = await _authService.getUserByUserName(userName);
    print(result.exists);

    return result.exists;
  }

  Future<AuthUserModel?> getUserByUserName(String userName) async {
    var result = await _authService.getUserByUserName(userName);
    var data = result.data();
    AuthUserModel? user;

    if (data != null) {
      user = AuthUserModel(
        userName: data['user_name'],
        password: data['password'],
      );
    }

    return user;
  }

  Future<void> resetAccountPassword(String userName, String newPassword) async {
    return await _authService.resetAccountPassword(userName, newPassword);
  }
}
