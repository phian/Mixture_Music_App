import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/enums/enums.dart';
import 'package:mixture_music_app/models/auth/auth_user_model.dart';
import 'package:mixture_music_app/models/auth/facebook/facebook_user_model.dart';
import 'package:mixture_music_app/services/user_repo.dart';

import '../repos/auth_repo.dart';

class AuthController extends GetxController {
  final AuthRepo _authRepo = AuthRepo();
  final _userRepo = UserRepo();

  User? get googleUser => _authRepo.googleUser;

  LoginResult get facebookLoginResult => _authRepo.facebookLoginResult;

  AccessToken? get facebookAccessToken => _authRepo.facebookAccessToken;
  FacebookUserModel facebookUser = FacebookUserModel();

  User? get currentAuthUser => FirebaseAuth.instance.currentUser;

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

  Future<CreateAccountState> createAuthUser({
    required String userName,
    required String password,
    required String avatarUrl,
  }) async {
    return await _authRepo.createAuthUser(userName: userName, password: password, avatarUrl: avatarUrl);
  }

  Future<SignInAccountState> signInWithAuthAccount(String userName, String password) async {
    return await _authRepo.signInWithAuthAccount(userName, password);
  }

  Future<void> createSocialUser(String uid, String email, String avatarUrl, String userName) async {
    return await _authRepo.createSocialUser(uid, email, avatarUrl, userName);
  }

  Future<QuerySnapshot<dynamic>> getAllAccountFromFirebase() async {
    return await _authRepo.getAllAccountFromFirebase();
  }

  Future<AuthUserModel?> getUserByID(String userName) async {
    return await _userRepo.getUserByID(userName);
  }

  Future<void> resetAccountPassword(String userName, String newPassword) async {
    return await _authRepo.resetAccountPassword(userName, newPassword);
  }

  Future<String> uploadAvatarToFirebase(File image) async {
    return await _userRepo.uploadAvatarToFirebase(image);
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

  Future<int> removeAuthUserName() async {
    return await _authRepo.removeAuthUserName();
  }

  Future<int> removeAuthUserAvatar() async {
    return await _authRepo.removeAuthUserAvatar();
  }

  Future<String> getUserAvatarUrl(String userUID) async {
    return await _userRepo.getUserAvatarUrl(userUID);
  }

  Future<void> updateGoogleUserAvatar(String avatarUrl) async {
    return await _authRepo.updateGoogleUserAvatar(avatarUrl);
  }

  Future<void> updateGoogleUserName(String newName) async {
    return await _authRepo.updateGoogleUserName(newName);
  }

  Future<void> updateGoogleUserPassword(String newPassword) async {
    return await _authRepo.updateGoogleUserPassword(newPassword);
  }

  Future<void> updateGoogleUserOnFirebase(String uid, String email, String avatarUrl, String newName) async {
    return await _authRepo.updateGoogleUserOnFirebase(uid, email, avatarUrl, newName);
  }
}
