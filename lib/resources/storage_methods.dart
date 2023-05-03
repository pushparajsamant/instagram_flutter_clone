import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final _firebaseStorage = FirebaseStorage.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<String> uploadFileToStorage(
      String filePath, Uint8List file, bool isPost) async {
    final ref = _firebaseStorage
        .ref()
        .child(filePath)
        .child(_firebaseAuth.currentUser!.uid);
    UploadTask fileUploadTask = ref.putData(file);
    final snap = await fileUploadTask;
    final fileDownloadURL = await snap.ref.getDownloadURL();
    return fileDownloadURL;
  }
}
