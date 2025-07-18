import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExtrasController extends GetxController {
  // Job information
  final jobTitle = ''.obs;
  final jobId = ''.obs;
  final budget = 0.0.obs;

  // Line items
  final lineItems = <Map<String, dynamic>>[].obs;
  final lineItemErrors = <String>[].obs;

  // State
  final isSubmitting = false.obs;
  final showReviewStep = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with one empty line item
    addNewLineItem();
  }

  @override
  void onClose() {
    // Dispose all controllers
    for (var item in lineItems) {
      item['description']?.dispose();
      item['quantity']?.dispose();
      item['price']?.dispose();
    }
    super.onClose();
  }

  void initializeJobData({
    required String jobTitle,
    required String jobId,
    required double budget,
  }) {
    this.jobTitle.value = jobTitle;
    this.jobId.value = jobId;
    this.budget.value = budget;

    // Clear any existing data
    lineItems.clear();
    lineItemErrors.clear();
    showReviewStep.value = false;
    isSubmitting.value = false;

    // Add initial line item
    addNewLineItem();
  }

  void addNewLineItem() {
    lineItems.add({
      'description': TextEditingController(),
      'quantity': TextEditingController(text: '1'),
      'price': TextEditingController(),
      'total': 0.0,
    });
    lineItemErrors.add('');
  }

  void removeLineItem(int index) {
    if (lineItems.length > 1 && index >= 0 && index < lineItems.length) {
      // Dispose controllers
      lineItems[index]['description']?.dispose();
      lineItems[index]['quantity']?.dispose();
      lineItems[index]['price']?.dispose();

      lineItems.removeAt(index);
      lineItemErrors.removeAt(index);
    }
  }

  void editLineItem(int index) {
    // Focus on the description field for editing
    if (index >= 0 && index < lineItems.length) {
      final descriptionController =
          lineItems[index]['description'] as TextEditingController?;
      if (descriptionController != null) {
        // You can add focus logic here if needed
        Get.snackbar(
          'Edit Mode',
          'You can now edit this line item',
          duration: const Duration(seconds: 1),
        );
      }
    }
  }

  void calculateLineTotal(int index) {
    if (index >= 0 && index < lineItems.length) {
      final item = lineItems[index];
      final quantity = double.tryParse(item['quantity']?.text ?? '1') ?? 1.0;
      final price = double.tryParse(item['price']?.text ?? '0') ?? 0.0;

      item['total'] = quantity * price;

      // Use update instead of refresh to avoid build conflicts
      lineItems.refresh();

      // Validate after calculation to avoid build conflicts
      Future.microtask(() => validateLineItem(index));
    }
  }

  double getLineTotal(int index) {
    if (index >= 0 && index < lineItems.length) {
      return lineItems[index]['total'] ?? 0.0;
    }
    return 0.0;
  }

  double getTotalAmount() {
    return lineItems.fold(0.0, (sum, item) => sum + (item['total'] ?? 0.0));
  }

  void validateLineItem(int index) {
    if (index >= 0 &&
        index < lineItems.length &&
        index < lineItemErrors.length) {
      final item = lineItems[index];
      final description = item['description']?.text?.trim() ?? '';
      final quantity = item['quantity']?.text?.trim() ?? '';
      final price = item['price']?.text?.trim() ?? '';

      String error = '';

      if (description.isEmpty) {
        error = 'Description is required';
      } else if (quantity.isEmpty ||
          double.tryParse(quantity) == null ||
          double.parse(quantity) <= 0) {
        error = 'Valid quantity is required';
      } else if (price.isEmpty ||
          double.tryParse(price) == null ||
          double.parse(price) <= 0) {
        error = 'Valid price is required';
      }

      lineItemErrors[index] = error;
    }
  }

  String getLineItemError(int index) {
    if (index >= 0 && index < lineItemErrors.length) {
      return lineItemErrors[index];
    }
    return '';
  }

  bool get isFormValid {
    if (lineItems.isEmpty) return false;

    // Don't validate during getter to avoid setState during build
    for (int i = 0; i < lineItems.length; i++) {
      final item = lineItems[i];
      final description = item['description']?.text?.trim() ?? '';
      final quantity = item['quantity']?.text?.trim() ?? '';
      final price = item['price']?.text?.trim() ?? '';

      if (description.isEmpty ||
          quantity.isEmpty ||
          double.tryParse(quantity) == null ||
          double.parse(quantity) <= 0 ||
          price.isEmpty ||
          double.tryParse(price) == null ||
          double.parse(price) <= 0) {
        return false;
      }
    }

    return true;
  }

  void showReviewDialog() {
    // Use Future.microtask to avoid setState during build
    Future.microtask(() {
      showReviewStep.value = true;
    });
  }

  void hideReviewDialog() {
    showReviewStep.value = false;
  }

  Future<void> submitExtras() async {
    if (!isFormValid) {
      Get.snackbar(
        'Validation Error',
        'Please fix all errors before submitting',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isSubmitting.value = true;

    try {
      // Prepare data
      List<Map<String, dynamic>> extrasData = [];
      for (var item in lineItems) {
        extrasData.add({
          'description': item['description']!.text.trim(),
          'quantity': double.parse(item['quantity']!.text.trim()),
          'price': double.parse(item['price']!.text.trim()),
          'total': item['total'],
          'timestamp': DateTime.now().toIso8601String(),
        });
      }

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        'Success',
        'Extra items request submitted successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Return result
      Get.back(result: {
        'success': true,
        'extrasData': extrasData,
        'totalAmount': getTotalAmount(),
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to submit extras: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
      showReviewStep.value = false;
    }
  }
}
