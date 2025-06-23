import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/core/config/config.dart';

class CreateAccountController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> proceedToNextStep() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    print('[CreateAccount] Email: $email');
    print('[CreateAccount] Password: $password');
    print('[CreateAccount] Confirm: $confirmPassword');

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      print('[CreateAccount] Validation failed: Empty fields');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      print('[CreateAccount] Validation failed: Passwords do not match');
      return;
    }

    try {
      print('[CreateAccount] Attempting Firebase registration...');
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'authProvider': 'email',
      });
      print(
          '[CreateAccount] Firebase user created: ${userCredential.user?.uid}');

      // await userCredential.user?.sendEmailVerification();
      // print('[CreateAccount] Email verification sent');
      //
      // Get.snackbar('Success', 'Verification email sent to $email');
      // Get.toNamed(AppRoutes.verifyEmail, arguments: {
      //   'email': email,
      //   'password': password,
      // });
      Get.toNamed(AppRoutes.selectRole);
    } on FirebaseAuthException catch (e) {
      print('[CreateAccount] FirebaseAuthException: ${e.code} - ${e.message}');
      Get.snackbar('Registration Failed', e.message ?? 'Unknown error');
    } catch (e) {
      print('[CreateAccount] General Exception: $e');
      Get.snackbar('Error', e.toString());
    }
  }
}
