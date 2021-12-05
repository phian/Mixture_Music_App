import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  const FirebaseService();

  Future<TaskSnapshot> uploadAvatarToFirebase(File image) async {
    Reference reference = FirebaseStorage.instance.ref().child('userAvatar/image${DateTime.now()}');

    UploadTask uploadTask = reference.putFile(image);

    TaskSnapshot snapshot = await uploadTask;

    return snapshot;
  }
}
