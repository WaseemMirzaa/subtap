import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:subtap/core/config/config.dart';

class MediationProcessPageController extends GetxController {
  // Form controllers
  final disputeCategoryController = TextEditingController();
  final jobReferenceController = TextEditingController();
  final reasonController = TextEditingController();

  // Reactive variables
  var selectedCategory = ''.obs;
  var uploadedFiles = <Map<String, dynamic>>[].obs;
  var isSubmitting = false.obs;
  var reasonCharCount = 0.obs;

  // Job data from arguments
  var jobTitle = ''.obs;
  var jobId = ''.obs;

  // Dropdown options
  final disputeCategories = [
    'Payment Delay',
    'Incomplete Work',
    'Wrong Materials',
    'Miscommunication',
    'Other'
  ];

  @override
  void onInit() {
    super.onInit();

    // Get job data from arguments if available
    final args = Get.arguments;
    if (args != null && args is Map) {
      jobTitle.value = args['jobTitle'] ?? '';
      jobId.value = args['jobId'] ?? '';

      // Auto-fill job reference if coming from job screen
      if (jobId.value.isNotEmpty) {
        jobReferenceController.text = jobId.value;
      }
    }

    // Listen to reason text changes
    reasonController.addListener(() {
      reasonCharCount.value = reasonController.text.length;
    });
  }

  @override
  void onClose() {
    disputeCategoryController.dispose();
    jobReferenceController.dispose();
    reasonController.dispose();
    super.onClose();
  }

  // Validation
  bool get isFormValid {
    return selectedCategory.value.isNotEmpty &&
        jobReferenceController.text.isNotEmpty &&
        reasonController.text.isNotEmpty;
  }

  // Add file
  void addFile(File file, String type, String label) {
    if (uploadedFiles.length < 10) {
      uploadedFiles.add({
        'file': file,
        'type': type,
        'label': label,
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
      });
    }
  }

  // Remove file
  void removeFile(String id) {
    uploadedFiles.removeWhere((file) => file['id'] == id);
  }

  // Submit mediation request
  Future<void> submitMediationRequest() async {
    if (!isFormValid) return;

    isSubmitting.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Navigate to Support Requests page with dispute data
      Get.offNamed(AppRoutes.supportRequests, arguments: {
        'disputeNumber':
            'DIS-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
        'jobId': jobReferenceController.text,
        'reason': reasonController.text,
        'filesCount': uploadedFiles.length,
      });

      // Show success message
      Get.snackbar(
        'Success',
        'Your dispute was submitted. Track it in Support Requests.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to submit mediation request. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  // Show summary modal
  void showSummaryModal() {
    Get.dialog(
      AlertDialog(
        title: const Text('Review Your Dispute'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Job ID: ${jobReferenceController.text}'),
            const SizedBox(height: 8),
            Text('• Category: ${selectedCategory.value}'),
            const SizedBox(height: 8),
            Text('• Reason: ${reasonController.text}'),
            const SizedBox(height: 8),
            Text('• ${uploadedFiles.length} files attached'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Go Back'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              submitMediationRequest();
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
