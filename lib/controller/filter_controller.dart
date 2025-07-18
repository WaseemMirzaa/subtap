import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/new_jobs_controller.dart';
import 'package:subtap/models/models.dart';

class FilterController extends GetxController {
  // Text controllers
  final locationController = TextEditingController();
  final categorySearchController = TextEditingController();

  // Observable variables
  final radius = 25.0.obs;
  final selectedCategories = <String>[].obs;
  final minRating = 1.0.obs;
  final minBudget = 0.0.obs;
  final maxBudget = 1000.0.obs;
  final selectedPostedDate = Rxn<String>();
  final selectedJobType = Rxn<String>();
  final selectedTimeRequired = Rxn<String>();
  final showInvitedOnly = false.obs;
  final isLoading = false.obs;
  final useCurrentLocation = false.obs;

  // Add a reactive location text variable
  final locationText = ''.obs;

  // New filter options
  final List<String> postedDateOptions = [
    'Last 24 hours',
    'Last 3 days',
    'Last week',
    'Last month'
  ];

  final List<String> jobTypeOptions = [
    'One-time',
    'Ongoing',
    'Emergency',
    'Labor-only'
  ];

  final List<String> timeRequiredOptions = [
    'Quick (1-2 hours)',
    'Half day (3-4 hours)',
    'Full day (5-8 hours)',
    'Multi-day'
  ];

  // Categories with search functionality
  final List<String> allCategories = [
    'Electrician',
    'Plumber',
    'Mechanic',
    'Carpenter',
    'Painter',
    'Cleaner',
    'Gardener',
    'Chef',
    'Tutor',
    'Photographer',
    'Barber',
    'Tailor',
    'Driver',
    'Delivery',
    'Repair Service',
  ];

  final filteredCategories = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredCategories.assignAll(allCategories);
    categorySearchController.addListener(_filterCategories);
  }

  void _filterCategories() {
    if (categorySearchController.text.isEmpty) {
      filteredCategories.assignAll(allCategories);
    } else {
      filteredCategories.assignAll(allCategories
          .where((category) => category
              .toLowerCase()
              .contains(categorySearchController.text.toLowerCase()))
          .toList());
    }
  }

  void updateRadius(double value) {
    radius.value = value;
  }

  void updateMinRating(double value) {
    minRating.value = value;
  }

  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  void removeCategory(String category) {
    selectedCategories.remove(category);
  }

  void updatePostedDate(String? value) {
    selectedPostedDate.value = value;
  }

  void updateJobType(String? value) {
    selectedJobType.value = value;
  }

  void updateTimeRequired(String? value) {
    selectedTimeRequired.value = value;
  }

  void toggleInvitedOnly(bool value) {
    showInvitedOnly.value = value;
  }

  void toggleCurrentLocation(bool value) {
    useCurrentLocation.value = value;
    if (value) {
      // TODO: Implement location service
      locationController.text = "Current Location";
    }
  }

  void updateBudgetRange(double min, double max) {
    minBudget.value = min;
    maxBudget.value = max;
  }

  final selectedDueDate = Rxn<String>();

  void updateDueDate(String? date) {
    selectedDueDate.value = date;
  }

  void updateInvitedOnly(bool value) {
    showInvitedOnly.value = value;
  }

  // Get active filter count
  int get activeFilterCount {
    int count = 0;
    if (locationText.value.isNotEmpty) count++;
    if (radius.value != 25.0) count++;
    if (selectedCategories.isNotEmpty) count++;
    if (minRating.value != 1.0) count++;
    if (minBudget.value != 0.0 || maxBudget.value != 1000.0) count++;
    if (selectedPostedDate.value != null) count++;
    if (selectedJobType.value != null) count++;
    if (selectedTimeRequired.value != null) count++;
    if (selectedDueDate.value != null) count++;
    if (showInvitedOnly.value) count++;
    return count;
  }

  // Get matching jobs count (mock implementation)
  int get matchingJobsCount {
    // Make this reactive by accessing observable variables
    // This ensures GetX can track changes
    final _ = selectedCategories.length +
        (selectedPostedDate.value != null ? 1 : 0) +
        (selectedJobType.value != null ? 1 : 0) +
        (selectedTimeRequired.value != null ? 1 : 0) +
        (selectedDueDate.value != null ? 1 : 0) +
        (showInvitedOnly.value ? 1 : 0);

    // TODO: Implement actual job filtering logic
    return 14; // Mock count
  }

  void resetFilters() {
    locationController.clear();
    categorySearchController.clear();
    radius.value = 25.0;
    selectedCategories.clear();
    minRating.value = 1.0;
    minBudget.value = 0.0;
    maxBudget.value = 1000.0;
    selectedPostedDate.value = null;
    selectedJobType.value = null;
    selectedTimeRequired.value = null;
    selectedDueDate.value = null;
    showInvitedOnly.value = false;
    useCurrentLocation.value = false;
  }

  void applyFilters() async {
    isLoading.value = true;

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Implement actual filtering logic
    final newJobsController = Get.find<NewJobsController>();
    // Apply filters to jobs...

    isLoading.value = false;
    Get.back();
  }
}
