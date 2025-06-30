import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobRequestController extends GetxController {
  // Reactive variables
  final RxList<Map<String, TextEditingController>> lineItems =
      <Map<String, TextEditingController>>[].obs;
  final RxBool makeCounterOffer = false.obs;

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
    // Clear existing line items
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
      // Dispose controllers before removing
      lineItems[index]['description']?.dispose();
      lineItems[index]['price']?.dispose();
      lineItems.removeAt(index);
    }
  }

  @override
  void onClose() {
    // Dispose all controllers
    titleController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    targetBudgetController.dispose();
    dueDateController.dispose();
    for (var item in lineItems) {
      item['description']?.dispose();
      item['price']?.dispose();
    }
    super.onClose();
  }
}
