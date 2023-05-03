import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter_clone/resources/storage_methods.dart';
import 'package:instagram_flutter_clone/utils/global_variable.dart';

class AuthMethods {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print(_firebaseAuth.currentUser?.email);
      return success;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signupUser({
    required String email,
    required String password,
    required String bio,
    required String username,
    required Uint8List file,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      String? uid = userCredential.user?.uid;
      String imageURL = await StorageMethods()
          .uploadFileToStorage('profilePictures', file, false);
      print(imageURL);
      if (uid != null) {
        await _fireStore.collection('users').doc(uid).set({
          'username': username,
          'uid': uid,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoURL': imageURL
        });
      }
      return success;
    } catch (err) {
      print("Error$err");
      return err.toString();
    }
  }
}
