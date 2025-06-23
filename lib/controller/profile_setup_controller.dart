import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSetupController extends GetxController {
  final fullNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final phoneController = TextEditingController();
  final referralCodeController = TextEditingController(); // for subcontractor

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveProfileData(String role) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      Get.snackbar('Error', 'No user logged in');
      return;
    }

    final roleId = _getRoleId(role);

    final profileData = {
      'fullName': fullNameController.text.trim(),
      'companyName': companyNameController.text.trim(),
      'phoneNumber': phoneController.text.trim(),
      'role': role,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if (role == 'Subcontractor') {
      profileData['referralCode'] = referralCodeController.text.trim();
      // In the future, you can also add license/insurance file URLs here
    }

    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('roles')
          .doc(roleId)
          .set(profileData);

      print('[ProfileSetup] Profile saved successfully');
    } catch (e) {
      print('[ProfileSetup] Failed to save: $e');
      Get.snackbar('Error', 'Failed to save profile');
    }
  }

  String _getRoleId(String role) {
    switch (role) {
      case 'PropertyManager':
        return 'property_manager';
      case 'Subcontractor':
        return 'subcontractor';
      default:
        return 'unknown';
    }
  }
}
