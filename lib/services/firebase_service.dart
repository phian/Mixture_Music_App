import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  const FirebaseService();

  Future<TaskSnapshot> uploadAvatarToFirebase(File image) async {
    Reference reference = FirebaseStorage.instance.ref().child('userAvatar/image${DateTime.now()}');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snapshot = await uploadTask;

    return snapshot;
  }

  Future<String> getUserAvatarUrl(String userUID) async {
    var result = await FirebaseFirestore.instance.collection('user_accounts').doc(userUID).get();

    return result['avatar_url'];
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserByUserID(String userID) async {
    var res = await FirebaseFirestore.instance.collection('user_accounts').doc(userID).get();
    print(res.data());
    return res;
  }

  Future<void> updateAuthUserData(String uid, String newUserName, String avatarUrl, String email) async {
    await FirebaseFirestore.instance.collection('user_accounts').doc(uid).delete();
    return await FirebaseFirestore.instance.collection('user_accounts').doc(uid).set(
      {'user_name': newUserName, 'avatar_url': avatarUrl, 'email': email},
    );
  }

  Future<void> updateGoogleUserAvatar(String avatarUrl) async {
    return await FirebaseAuth.instance.currentUser?.updatePhotoURL(avatarUrl);
  }

  Future<void> updateGoogleUserName(String newName) async {
    return await FirebaseAuth.instance.currentUser?.updateDisplayName(newName);
  }

  Future<void> updateGoogleUserPassword(String newPassword) async {
    return await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
  }

  Future<void> updateGoogleUserOnFirebase(String uid, String email, String avatarUrl, String newName) async {
    await FirebaseFirestore.instance.collection('user_accounts').doc(uid).delete();
    return await FirebaseFirestore.instance.collection('user_accounts').doc(uid).set(
      {'user_name': newName, 'email': email, 'avatar_url': avatarUrl},
    );
  }
}
