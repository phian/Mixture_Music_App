import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  /// Google
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentGoogleUser;
  GoogleSignIn? _googleSignIn;
  GoogleSignInAccount? _googleSignInAccount;
  UserCredential? _userCredential;
  late AuthCredential _credential;
  GoogleSignInAuthentication? _googleSignInAuthentication;

  User? get googleUser => _currentGoogleUser;

  Future<User?> signInWithGoogle() async {
    _auth = FirebaseAuth.instance;

    _googleSignIn = GoogleSignIn();
    _googleSignInAccount = await _googleSignIn?.signIn();

    if (_googleSignInAccount != null) {
      _googleSignInAuthentication = await _googleSignInAccount?.authentication;

      _credential = GoogleAuthProvider.credential(
        accessToken: _googleSignInAuthentication?.accessToken,
        idToken: _googleSignInAuthentication?.idToken,
      );

      try {
        _userCredential = await _auth.signInWithCredential(_credential);

        _currentGoogleUser = _userCredential?.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
        rethrow;
      }
    }

    return _currentGoogleUser;
  }

  Future<void> googleSignOut() async {
    _auth.signOut();
    _googleSignIn?.signOut();
  }

  // Facebook
  late LoginResult _result;
  late AccessToken? _accessToken;

  LoginResult get facebookLoginResult => _result;

  AccessToken? get facebookAccessToken => _accessToken;

  Future<LoginResult?> signInWithFacebook() async {
    LoginResult? result;
    try {
      result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        // User logged in
        _accessToken = result.accessToken!;
        // Add facebook user to current user on Firebase
        var credential = FacebookAuthProvider.credential(result.accessToken?.token ?? '');
        await _auth.signInWithCredential(credential).then((value) {
          print('current facebook user: ${value.user}');
        }).catchError((err) {
          print(err.toString());
        });
      }
    } catch (ex) {
      print(ex.toString());
    }

    return result;
  }

  Future<void> facebookSignOut() async {
    await FacebookAuth.instance.logOut();
  }

  Future<Map<String, dynamic>> getFacebookUserData() async {
    Map<String, dynamic> userData = {};
    try {
      userData = await FacebookAuth.instance.getUserData();
      print(userData);
    } catch (ex) {
      print(ex.toString());
    }

    return userData;
  }

  Future<bool> createAuthUser({
    required String userName,
    required String password,
    required String avatarUrl,
  }) async {
    var result = await FirebaseFirestore.instance.collection('user_accounts').doc(userName).get();

    if (!result.exists) {
      await FirebaseFirestore.instance.collection('user_accounts').doc(userName).set(
        {'user_name': userName, 'password': password, 'avatar_url': avatarUrl},
      ).catchError(
        (err) {
          print(err);
        },
      );

      return true;
    }

    return false;
  }

  Future<void> createSocialUser(String uid, String email, String avatarUrl, String userName) async {
    var isExisted = await _checkIfSocialUserExisted(uid);

    if (!isExisted) {
      await FirebaseFirestore.instance.collection('user_accounts').doc(uid).set(
        {'user_name': userName, 'email': email, 'avatar_url': avatarUrl},
      ).catchError(
        (err) {
          print(err);
        },
      );
    }
  }

  Future<bool> _checkIfSocialUserExisted(String uid) async {
    var result = await FirebaseFirestore.instance.collection('user_accounts').doc(uid).get();

    if (result.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> signInWithAuthAccount(String userName, String password) async {
    var result = await FirebaseFirestore.instance.collection('user_accounts').doc(userName).get();

    if (!result.exists) {
      await FirebaseFirestore.instance.collection('user_accounts').doc(userName).set(
        {'user_name': userName, 'password': password},
      );

      return 'success';
    } else {
      return 'Account already in use';
    }
  }

  Future<QuerySnapshot<dynamic>> getAllAccountFromFirebase() async {
    return await FirebaseFirestore.instance.collection('user_accounts').get().catchError((err) {
      print(err);
    });
  }

  Future<void> resetAccountPassword(String userName, String newPassword) async {
    return await FirebaseFirestore.instance.collection('user_accounts').doc(userName).update({'password': newPassword});
  }
}
