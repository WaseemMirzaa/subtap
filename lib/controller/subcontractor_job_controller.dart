import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SubcontractorJobController extends GetxController {
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  final makeCounterOffer = false.obs;
  final lineItems = <Map<String, TextEditingController>>[].obs;
  final attachments = <String>[].obs;
  final showPreview = false.obs;

  // Validation
  final hasValidationErrors = false.obs;
  final validationMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initializeControllers();
  }

  void initializeControllers() {
    lineItems.clear();

    if (makeCounterOffer.value) {
      // Construction-oriented pre-fill
      descriptionController.text =
          "Frame interior walls and install blocking per site specs.";
      lineItems.addAll([
        {
          'description': TextEditingController(text: 'Framing materials'),
          'price': TextEditingController(text: '450.00'),
        },
        {
          'description': TextEditingController(text: 'Labor and installation'),
          'price': TextEditingController(text: '350.00'),
        }
      ]);
      startDateController.text = '2024-01-15';
      endDateController.text = '2024-01-18';
    } else {
      lineItems.add({
        'description': TextEditingController(),
        'price': TextEditingController(),
      });
    }
  }

  void toggleCounterOffer() {
    HapticFeedback.lightImpact();
    makeCounterOffer.value = !makeCounterOffer.value;
    initializeControllers();
  }

  void addNewLineItem() {
    if (!makeCounterOffer.value) {
      lineItems.add({
        'description': TextEditingController(),
        'price': TextEditingController(),
      });
    }
  }

  void removeLineItem(int index) {
    if (!makeCounterOffer.value && lineItems.length > 1) {
      lineItems[index]['description']?.dispose();
      lineItems[index]['price']?.dispose();
      lineItems.removeAt(index);
    }
  }

  double get totalBudget {
    final budgetText =
        titleController.text.replaceAll('\$', '').replaceAll(',', '');
    return double.tryParse(budgetText) ?? 1000.0;
  }

  double get itemizedTotal {
    return lineItems.fold(0.0, (sum, item) {
      final priceText =
          item['price']?.text.replaceAll('\$', '').replaceAll(',', '') ?? '0';
      return sum + (double.tryParse(priceText) ?? 0.0);
    });
  }

  double get remaining => totalBudget - itemizedTotal;

  bool get hasRemainingMismatch => remaining.abs() > 0.01;

  void validateDates() {
    if (startDateController.text.isNotEmpty &&
        endDateController.text.isNotEmpty) {
      final startDate = DateTime.parse(startDateController.text);
      final endDate = DateTime.parse(endDateController.text);

      if (endDate.isBefore(startDate)) {
        endDateController.text = startDateController.text;
        validationMessage.value = 'End date cannot be before start date';
        hasValidationErrors.value = true;
      } else {
        hasValidationErrors.value = false;
        validationMessage.value = '';
      }
    }
  }

  bool validateForm() {
    if (descriptionController.text.isEmpty) {
      validationMessage.value = 'Please enter a scope description';
      hasValidationErrors.value = true;
      return false;
    }

    if (!makeCounterOffer.value && titleController.text.isEmpty) {
      validationMessage.value = 'Please enter total budget';
      hasValidationErrors.value = true;
      return false;
    }

    if (startDateController.text.isEmpty || endDateController.text.isEmpty) {
      validationMessage.value = 'Please select start and end dates';
      hasValidationErrors.value = true;
      return false;
    }

    hasValidationErrors.value = false;
    validationMessage.value = '';
    return true;
  }

  void showPreviewModal() {
    if (validateForm()) {
      showPreview.value = true;
    }
  }

  void addAttachment(String filePath) {
    attachments.add(filePath);
  }

  void removeAttachment(int index) {
    attachments.removeAt(index);
  }

  @override
  void onClose() {
    titleController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    for (var item in lineItems) {
      item['description']?.dispose();
      item['price']?.dispose();
    }
    super.onClose();
  }
}
