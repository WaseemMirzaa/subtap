import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:subtap/core/config/config.dart';

class UploadProgressController extends GetxController {
  // Form controllers
  final progressNotesController = TextEditingController();
  final additionalCommentsController = TextEditingController();

  // Reactive variables
  var uploadedImages = <Map<String, dynamic>>[].obs;
  var isSubmitting = false.obs;
  var progressNotesCharCount = 0.obs;
  var commentsCharCount = 0.obs;

  // Job data
  var jobTitle = ''.obs;
  var jobId = ''.obs;
  var dueDate = ''.obs;
  var extrasTotal = 0.0.obs;

  // Image tags
  final imageTags = ['Before', 'After', 'Issue', 'Materials Used', 'Progress'];

  @override
  void onInit() {
    super.onInit();

    // Get job data from arguments
    final args = Get.arguments;
    if (args != null && args is Map) {
      jobTitle.value = args['jobTitle'] ?? 'General Trades';
      jobId.value = args['jobId'] ?? 'JOB-123';
      dueDate.value = args['dueDate'] ?? 'Due in 2 days';
      extrasTotal.value = args['extrasTotal'] ?? 0.0;
    }

    // Listen to text changes
    progressNotesController.addListener(() {
      progressNotesCharCount.value = progressNotesController.text.length;
    });

    additionalCommentsController.addListener(() {
      commentsCharCount.value = additionalCommentsController.text.length;
    });
  }

  @override
  void onClose() {
    progressNotesController.dispose();
    additionalCommentsController.dispose();
    super.onClose();
  }

  // Validation
  bool get isFormValid {
    return progressNotesController.text.isNotEmpty || uploadedImages.isNotEmpty;
  }

  String get validationMessage {
    if (!isFormValid) {
      return 'Please upload a photo or add a note before submitting.';
    }
    return '';
  }

  // Add image
  void addImage(File file, String type, String tag) {
    if (uploadedImages.length < 8) {
      uploadedImages.add({
        'file': file,
        'type': type,
        'tag': tag,
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
      });
    }
  }

  // Remove image
  void removeImage(String id) {
    uploadedImages.removeWhere((image) => image['id'] == id);
  }

  // Update image tag
  void updateImageTag(String id, String newTag) {
    final index = uploadedImages.indexWhere((image) => image['id'] == id);
    if (index != -1) {
      uploadedImages[index]['tag'] = newTag;
      uploadedImages.refresh();
    }
  }

  // Submit progress
  Future<void> submitProgress() async {
    if (!isFormValid) return;

    isSubmitting.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Show success dialog
      _showSuccessDialog();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to submit progress. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  // Mark job as complete
  Future<void> markJobComplete() async {
    isSubmitting.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        'Success',
        'Job marked as complete! Awaiting final review.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate to feedback screen like other job completion flows
      Get.toNamed(AppRoutes.jobVerification);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to mark job complete. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  // Show confirmation modal
  void showConfirmationModal() {
    Get.dialog(
      AlertDialog(
        title: const Text('Review Your Progress'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Job: ${jobTitle.value} - ${jobId.value}'),
            const SizedBox(height: 8),
            Text(
                '• Notes: ${progressNotesController.text.isNotEmpty ? "Added" : "None"}'),
            const SizedBox(height: 8),
            Text(
                '• Comments: ${additionalCommentsController.text.isNotEmpty ? "Added" : "None"}'),
            const SizedBox(height: 8),
            Text('• ${uploadedImages.length} files attached'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Edit'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              submitProgress();
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 60,
            ),
            const SizedBox(height: 16),
            const Text(
              '✅ Progress submitted!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'PM will review within 24 hrs.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: const Text('Back to Job'),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
