import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:mixture_music_app/constants/enums/enums.dart';
import 'package:mixture_music_app/models/auth/auth_user_model.dart';
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

  Future<void> updateAuthUserData(String uid, String newUserName, String avatarUrl, String email) async {
    return await _firebaseService.updateAuthUserData(uid, newUserName, avatarUrl, email);
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

  Future<Map<String, dynamic>> createUserWithUsernamePassword(String email, String password, String avatarUrl, String username) async {
    var result = await _authService.createUserWithUsernamePassword(email, password, avatarUrl, username);
    late AuthUserModel user;

    if (result['code'].contains('email-already-in-use')) {
      return {
        'state': CreateAccountState.emailAlreadyUsed,
        'user': null,
      };
    } else if (result['code'].contains('email-already-in-use') == false && result['code'] != 'success') {
      return {
        'state': CreateAccountState.failed,
        'user': null,
      };
    }

    UserCredential credential = result['credential'];
    user = AuthUserModel(
      id: credential.user?.uid,
      userName: credential.user?.displayName,
      avatarUrl: credential.user?.photoURL,
      email: credential.user?.email,
    );

    return {
      'state': CreateAccountState.success,
      'user': user,
    };
  }

  Future<Map<String, dynamic>> signInWithUsernameAndPassword(String email, String password) async {
    var result = await _authService.signInWithUsernameAndPassword(email, password);
    late AuthUserModel user;

    if (result['code'].contains('user-not-found')) {
      return {
        'state': SignInAccountState.notFound,
        'user': null,
      };
    } else if (result['code'].contains('wrong-password')) {
      return {
        'state': SignInAccountState.wrongPassword,
        'user': null,
      };
    } else if (result['code'].contains('user-not-found') == false &&
        result['code'].contains('wrong-password') == false &&
        result['code'].contains('success') == false) {
      return {
        'state': SignInAccountState.failed,
        'user': null,
      };
    }

    UserCredential credential = result['credential'];
    user = AuthUserModel(
      id: credential.user?.uid,
      userName: credential.user?.displayName,
      avatarUrl: credential.user?.photoURL,
    );

    return {
      'state': SignInAccountState.success,
      'user': user,
    };
  }
}
