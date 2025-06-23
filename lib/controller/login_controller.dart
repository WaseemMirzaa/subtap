import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:subtap/core/config/config.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signInWithEmail() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.toNamed(AppRoutes.selectRole);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Login Failed', e.message ?? 'Unknown error');
    }
  }

  // Future<void> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     if (googleUser == null) return;
  //
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     final UserCredential userCredential =
  //         await _auth.signInWithCredential(credential);
  //
  //     final uid = userCredential.user?.uid;
  //     final email = userCredential.user?.email;
  //
  //     if (uid != null) {
  //       final userDoc = _firestore.collection('users').doc(uid);
  //       final userSnapshot = await userDoc.get();
  //
  //       if (!userSnapshot.exists) {
  //         await userDoc.set({
  //           'uid': uid,
  //           'email': email,
  //           'createdAt': FieldValue.serverTimestamp(),
  //         });
  //       }
  //     }
  //
  //     Get.toNamed(AppRoutes.selectRole); // or home screen
  //   } catch (e) {
  //     Get.snackbar('Google Sign-In Failed', e.toString());
  //   }
  // }
}
