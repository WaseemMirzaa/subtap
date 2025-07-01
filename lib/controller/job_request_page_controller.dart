import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobRequestController extends GetxController {
  // Reactive variables
  final RxList<Map<String, TextEditingController>> lineItems =
      <Map<String, TextEditingController>>[].obs;
  final RxBool makeCounterOffer = false.obs;

  // Store extras data
  final RxList<Map<String, dynamic>> extrasData = <Map<String, dynamic>>[].obs;

  // Text controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController targetBudgetController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Initialize line items
    initializeLineItems();
  }

  void initializeLineItems() {
    try {
      // Clear existing line items safely
      for (var item in lineItems) {
        item['description']?.dispose();
        item['price']?.dispose();
      }
      lineItems.clear();

      // Initialize with one empty line item
      lineItems.add({
        'description': TextEditingController(),
        'price': TextEditingController(),
      });
    } catch (e) {
      print('Error initializing line items: $e');
      // Ensure we have at least one item even if there's an error
      if (lineItems.isEmpty) {
        lineItems.add({
          'description': TextEditingController(),
          'price': TextEditingController(),
        });
      }
    }
  }

  void addNewLineItem() {
    if (!makeCounterOffer.value) {
      try {
        lineItems.add({
          'description': TextEditingController(),
          'price': TextEditingController(),
        });
      } catch (e) {
        print('Error adding new line item: $e');
      }
    }
  }

  void removeLineItem(int index) {
    if (!makeCounterOffer.value &&
        lineItems.length > 1 &&
        index >= 0 &&
        index < lineItems.length) {
      try {
        // Dispose controllers before removing
        lineItems[index]['description']?.dispose();
        lineItems[index]['price']?.dispose();
        lineItems.removeAt(index);
      } catch (e) {
        print('Error removing line item: $e');
      }
    }
  }

  // Method to add extras data
  void addExtrasData(List<Map<String, dynamic>> extras) {
    try {
      extrasData.addAll(extras);
    } catch (e) {
      print('Error adding extras data: $e');
    }
  }

  // Method to clear extras data
  void clearExtrasData() {
    extrasData.clear();
  }

  // Method to get total extras value
  double getTotalExtrasValue() {
    try {
      return extrasData.fold(
          0.0, (sum, item) => sum + (item['price'] as double? ?? 0.0));
    } catch (e) {
      print('Error calculating total extras value: $e');
      return 0.0;
    }
  }

  @override
  void onClose() {
    try {
      // Dispose all controllers safely
      titleController.dispose();
      locationController.dispose();
      descriptionController.dispose();
      targetBudgetController.dispose();
      dueDateController.dispose();

      for (var item in lineItems) {
        item['description']?.dispose();
        item['price']?.dispose();
      }
    } catch (e) {
      print('Error disposing controllers: $e');
    }
    super.onClose();
  }
}
