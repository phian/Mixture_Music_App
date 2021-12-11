import 'dart:io';

import 'package:mixture_music_app/models/auth/auth_user_model.dart';
import 'package:mixture_music_app/services/firebase_service.dart';
import 'package:mixture_music_app/services/share_preference_service.dart';

class UserRepo {
  final FirebaseService _firebaseService = const FirebaseService();
  final SharePrefService _sharePrefService = const SharePrefService();

  Future<AuthUserModel?> getUserByID(String userUID) async {
    var result = await _firebaseService.getUserByUserID(userUID);
    var data = result.data();
    AuthUserModel? user;

    if (data != null) {
      user = AuthUserModel(
        userName: data['user_name'],
        password: data['password'],
        avatarUrl: data['avatar_url'],
      );
    }

    return user;
  }

  Future<String> uploadAvatarToFirebase(File image) async {
    var res = await _firebaseService.uploadAvatarToFirebase(image);

    return await res.ref.getDownloadURL();
  }

  Future<String> getUserAvatarUrl(String userUID) async {
    return await _firebaseService.getUserAvatarUrl(userUID);
  }
}
