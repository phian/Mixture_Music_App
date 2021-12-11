
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:mixture_music_app/constants/enums/enums.dart';
import 'package:mixture_music_app/models/auth/facebook/facebook_user_model.dart';
import 'package:mixture_music_app/services/firebase_service.dart';
import 'package:mixture_music_app/services/share_preference_service.dart';

import '../services/auth_service.dart';

class AuthRepo {
  final AuthService _authService = AuthService();
  final FirebaseService _firebaseService = const FirebaseService();
  final SharePrefService _sharePrefService = const SharePrefService();

  User? get googleUser => _authService.googleUser;

  LoginResult get facebookLoginResult => _authService.facebookLoginResult;

  AccessToken? get facebookAccessToken => _authService.facebookAccessToken;
  FacebookUserModel facebookUser = FacebookUserModel();

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

  Future<CreateAccountState> createAuthUser({
    required String userName,
    required String password,
    required String avatarUrl,
  }) async {
    var result = await _authService.createAuthUser(userName: userName, password: password, avatarUrl: avatarUrl);

    if (result) {
      return CreateAccountState.success;
    } else {
      return CreateAccountState.failed;
    }
  }

  Future<SignInAccountState> signInWithAuthAccount(String userName, String password) async {
    var result = await _authService.signInWithAuthAccount(userName, password);

    if (result == 'success') {
      return SignInAccountState.success;
    } else {
      return SignInAccountState.failed;
    }
  }

  Future<void> createSocialUser(String uid, String email, String avatarUrl, String userName) async {
    return await _authService.createSocialUser(uid, email, avatarUrl, userName);
  }

  Future<QuerySnapshot<dynamic>> getAllAccountFromFirebase() async {
    return await _authService.getAllAccountFromFirebase();
  }

  Future<void> resetAccountPassword(String userName, String newPassword) async {
    return await _authService.resetAccountPassword(userName, newPassword);
  }

  Future<void> saveAuthType(String authType) async {
    return await _sharePrefService.saveAuthType(authType);
  }

  Future<String> getAuthType() async {
    return await _sharePrefService.getAuthType();
  }

  Future<void> updateAuthType(String newType) async {
    return await _sharePrefService.updateAuthType(newType);
  }

  Future<void> updateAuthUserData(String oldUserName, String newUserName, String avatarUrl, String password) async {
    return await _firebaseService.updateAuthUserData(oldUserName, newUserName, avatarUrl, password);
  }

  Future<void> saveAuthUserName(String userName) async {
    return await _sharePrefService.saveAuthUserName(userName);
  }

  Future<void> saveAuthUserAvatar(String avatarUrl) async {
    return await _sharePrefService.saveAuthUserAvatar(avatarUrl);
  }

  Future<String> getAuthUserName() async {
    return await _sharePrefService.getAuthUserName();
  }

  Future<String> getAuthUserAvatar() async {
    return await _sharePrefService.getAuthUserAvatar();
  }

  Future<void> updateAuthUserName(String newUserName) async {
    return await _sharePrefService.updateAuthUserName(newUserName);
  }

  Future<void> updateAuthUserAvatar(String newAvatarUrl) async {
    return await _sharePrefService.updateAuthUserAvatar(newAvatarUrl);
  }

  Future<int> removeAuthUserName() async {
    return await _sharePrefService.removeAuthUserName();
  }

  Future<int> removeAuthUserAvatar() async {
    return await _sharePrefService.removeAuthUserAvatar();
  }

  Future<void> updateGoogleUserAvatar(String avatarUrl) async {
    return await _firebaseService.updateGoogleUserAvatar(avatarUrl);
  }

  Future<void> updateGoogleUserName(String newName) async {
    return await _firebaseService.updateGoogleUserName(newName);
  }

  Future<void> updateGoogleUserPassword(String newPassword) async {
    return await _firebaseService.updateGoogleUserPassword(newPassword);
  }

  Future<void> updateGoogleUserOnFirebase(String uid, String email, String avatarUrl, String newName) async {
    return await _firebaseService.updateGoogleUserOnFirebase(uid, email, avatarUrl, newName);
  }
}
