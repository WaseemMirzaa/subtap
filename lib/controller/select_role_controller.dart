import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../core/config/config.dart';

class SelectRoleController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> selectRoleAndNavigate(String role) async {
    final user = _auth.currentUser;
    if (user == null) {
      Get.snackbar('Error', 'No user is logged in');
      return;
    }

    final roleId = _getRoleId(role);

    try {
      // Save role info at top level
      await _firestore.collection('users').doc(user.uid).set({
        'selectedRole': role,
        'roleId': roleId,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Optionally initialize role subcollection for future data
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('roles')
          .doc(roleId)
          .set({
        'createdAt': FieldValue.serverTimestamp(),
        'roleName': role,
        // Add more default role-specific data here
      });

      Get.toNamed(AppRoutes.profileSetup, arguments: {'role': role});
    } catch (e) {
      Get.snackbar('Error', 'Failed to save role: $e');
    }
  }

  String _getRoleId(String role) {
    switch (role) {
      case 'PropertyManager':
        return 'property_manager';
      case 'Subcontractor':
        return 'subcontractor';
      default:
        return 'unknown_role';
    }
  }
}
