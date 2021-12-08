import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/models/auth/auth_user_model.dart';
import 'package:mixture_music_app/models/auth/facebook/facebook_user_model.dart';

import '../repos/auth_repo.dart';

class AuthController extends GetxController {
  final AuthRepo _authRepo = AuthRepo();

  User? get googleUser => _authRepo.googleUser;

  LoginResult get facebookLoginResult => _authRepo.facebookLoginResult;

  AccessToken? get facebookAccessToken => _authRepo.facebookAccessToken;
  FacebookUserModel facebookUser = FacebookUserModel();

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
  Future<LoginResult?> signInWithFacebook() async {
    LoginResult? result;
    try {
      result = await _authRepo.signInWithFacebook();
      facebookUser.copyWith(_authRepo.facebookUser);
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

  Future<void> addAuthUser({
    required String userName,
    required String password,
    required String avatarUrl,
  }) async {
    return await _authRepo.addAuthUser(userName: userName, password: password, avatarUrl: avatarUrl);
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

  Future<String> uploadAvatarToFirebase(File image) async {
    return await _authRepo.uploadAvatarToFirebase(image);
  }

  Future<void> saveAuthType(String authType) async {
    return await _authRepo.saveAuthType(authType);
  }

  Future<String> getAuthType() async {
    return await _authRepo.getAuthType();
  }

  Future<void> updateAuthType(String newType) async {
    return await _authRepo.updateAuthType(newType);
  }

  Future<void> updateAuthUserData(String oldUserName, String newUserName, String avatarUrl, String password) async {
    return await _authRepo.updateAuthUserData(oldUserName, newUserName, avatarUrl, password);
  }

  Future<void> saveAuthUserName(String userName) async {
    return await _authRepo.saveAuthUserName(userName);
  }

  Future<void> saveAuthUserAvatar(String avatarUrl) async {
    return await _authRepo.saveAuthUserAvatar(avatarUrl);
  }

  Future<String> getAuthUserName() async {
    return await _authRepo.getAuthUserName();
  }

  Future<String> getAuthUserAvatar() async {
    return await _authRepo.getAuthUserAvatar();
  }

  Future<void> updateAuthUserName(String newUserName) async {
    return await _authRepo.updateAuthUserName(newUserName);
  }

  Future<void> updateAuthUserAvatar(String newAvatarUrl) async {
    return await _authRepo.updateAuthUserAvatar(newAvatarUrl);
  }
}
